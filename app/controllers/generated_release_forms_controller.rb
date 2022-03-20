class GeneratedReleaseFormsController < ApplicationController
    # before_action :authenticate_user!

    def new
        @release_form = GeneratedReleaseForm.new
        render :new
    end

    def update
        @release_form = GeneratedReleaseForm.find(params[:id])
        if @release_form.update(generated_release_form_params)
            UserMailer.with(user: @release_form.lawyer).insurance_edit_notification.deliver_later
            flash[:success] = "Release form updated!"
            redirect_to release_form_show_url(@release_form)
        else
            flash[:error] = "Failed to update release form!"
            render :show
        end 
    end

    def create
        @release_form = GeneratedReleaseForm.create(generated_release_form_params)
        if @release_form.save
            UserMailer.with(user: @release_form.lawyer).insurance_new_notification.deliver_later
            flash[:success] = "Release form created!"
            redirect_to release_form_show_url(@release_form)
        else
            flash.now[:error] = "Failed to create release form!"
            render :new
        end
    end

    def generated_release_form_params
        params.require(:generated_release_form).permit(
            :claim_number, 
            :date_of_incident, 
            :defendant_name, 
            :insurance_company_name, 
            :law_firm_name, 
            :place_of_incident,
            :plaintiff_name,
            :policy_number,
            :settlement_amount,
            :incident_description,
            :pdf)
    end
end
