class ReleaseFormsController < ApplicationController
    before_action :authenticate_user!

    def new
        @release_form = ReleaseForm.new
        render :new
    end

    def create
        @release_form = ReleaseForm.create(release_form_params)
        if @release_form.save
            flash[:success] = "Release form created!"
            redirect_to release_form_show_url(@release_form)
        else
            flash.now[:error] = "Failed to create release form!"
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
            flash[:success] = "Release form updated!"
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

        if @user.role = "Lawyer"
            @release_forms = @user.lawyer_owned_release_forms
        end

        if @user.role = "Insurance Agent"
            @release_forms = @user.insurance_agent_owned_release_forms
        end
        
        render :index
    end

    # Defines what parameters can be accepted from a browser. This is for security. Without defining the data expected from the browser,
    # potentially malicious data can be accepted as valid.
    def release_form_params
        params.require(:release_form).permit(:claim_number, :policy_number, :pdf)
    end
end
