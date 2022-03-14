class ReleaseFormsController < ApplicationController
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
            flash.now[:error] = "ERROR: Failed to create release form!"
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
            format.html
            format.pdf do
                send_data @release_form.pdf.download, filename: @release_form.pdf_file_name
            end
        end
    end

    def index
        @release_forms = ReleaseForm.all
        render :index
    end

    def release_form_params
        params.require(:release_form).permit(
            :claim_number, 
            :date_of_incident, 
            :defendant_name, 
            :insurance_company_name, 
            :law_firm_name, 
            :place_of_incident,
            :plaintiff_name,
            :policy_number,
            :settlement_amount,
            :incident_description)
    end
end
