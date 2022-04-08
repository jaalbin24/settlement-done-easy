class GeneratedDocumentsController < ApplicationController
    before_action :authenticate_user!

    def new
        @document = GeneratedDocument.new
        render :new
    end

    def update
        @document = GeneratedDocument.find(params[:id])
        if @document.update(generated_document_params)
            flash[:success] = "Release form updated!"
            redirect_to document_show_url(@document)
        else
            flash[:error] = "Failed to update document!"
            render :show
        end 
    end

    def create
        @document = GeneratedDocument.create(generated_document_params)
        if @document.save
            flash[:success] = "Release form created!"
            redirect_to document_show_url(@document)
        else
            flash.now[:error] = "Failed to create document!"
            render :new
        end
    end

    def generated_document_params
        params.require(:generated_document).permit(
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
