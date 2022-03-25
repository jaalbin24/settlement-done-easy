class ReleaseFormsController < ApplicationController
    include DsEnvelope
    # before_action :authenticate_user!
    def new
        @release_form = ReleaseForm.new
        render :new
    end

    def create
        settlement = Settlement.find(params[:settlement_id])
        @release_form = settlement.build_release_form(release_form_params)
        if @release_form.save
            flash[:info] = "Release form added! Click <a href=#{release_form_show_path(@release_form)}>here<a> to view it."
            redirect_to settlement_show_url(settlement)
        else
            flash.now[:error] = "Failed to upload release_form!"
            render :new
        end
    end

    def edit
        @release_form = ReleaseForm.find(params[:id])
        render :edit
    end

    def update
        @release_form = ReleaseForm.find(params[:id])
        if @release_form.update(release_form_params)
            UserMailer.with(user: @release_form.lawyer).insurance_edit_notification.deliver_later
            flash[:info] = "Release form updated!"
            @release_form.update_pdf
            # This^ should be moved to the release_form.rb file.
            # TODO: Move the PDF-updating feature to the model file. This should not be in the controller.
            redirect_to release_form_show_url(@release_form)
        else
            flash[:error] = "Failed to update release form!"
            render :show
        end 
    end

    def destroy
        @release_form = ReleaseForm.find(params[:id])
        @release_form.destroy
    end

    def show
        @release_form = ReleaseForm.find(params[:id])
        respond_to do |format|
            format.html do
                render :show
            end
            format.pdf do
                send_data @release_form.pdf.download, filename: @release_form.pdf_file_name
            end
        end
    end

    def index
        @user = current_user
        @release_forms = ReleaseForm.all
        # @release_forms = @user.lawyer_owned_release_forms + @user.insurance_agent_owned_release_forms
        render :index
    end

    def ready_to_send
        @release_form = ReleaseForm.find(params[:id])
        render :ready_to_send
    end

    def send_to_client
        @release_form = ReleaseForm.find(params[:id])
        if (@release_form.status == 'Approved')
            envelope_args = {
                email_subject: 'Signature Required!',
                signer_email: params[:client_email],
                signer_name: params[:client_name],
                cc_email: Rails.configuration.APP_EMAIL,
                cc_name: 'Settlement Done Easy',
                status: 'sent'
            }
            create_and_send(@release_form.pdf, envelope_args)
            flash[:info] = "Sent signature request to #{params[:client_email]}"
            redirect_to root_path
        else
            flash[:error] = "Release Form must be approved first! Click #{view_context.link_to('here', approve_or_reject_path(@release_form))} to approve it!".html_safe
            redirect_back(fallback_location: root_path)
        end
    end

    # Defines what parameters can be accepted from a browser. This is for security. Without defining the data expected from the browser,
    # potentially malicious data can be accepted as valid.
    def release_form_params
        params.require(:release_form).permit(:claim_number, :policy_number, :pdf)
    end

    def approve_form
        @release_form = ReleaseForm.find(params[:id])
        @release_form.update_attribute(:status, "Approved")
        UserMailer.with(user: @release_form.insurance_agent).lawyer_approve_notification.deliver_now
        redirect_to ready_to_send_path
    end

    def reject_form
        @release_form = ReleaseForm.find(params[:id])
        @release_form.update_attribute(:status, "Approved")
        UserMailer.with(user: @release_form.insurance_agent).lawyer_reject_notification.deliver_now
        redirect_to approve_or_reject_path
    end
end
