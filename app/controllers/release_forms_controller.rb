class ReleaseFormsController < ApplicationController
    def new
        @release_form = ReleaseForm.new
    end

    def create
        @release_form = ReleaseForm.create(release_form_params)
        @release_form.save
    end

    def edit
        @release_form = ReleaseForm.find(params[:id])
    end

    def update
        @release_form = ReleaseForm.find(params[:id])
    end

    def delete
        @release_form = ReleaseForm.find(params[:id])
    end

    def show
        @release_form = ReleaseForm.find(params[:id])

        respond_to do |format|
            format.html
            format.pdf do
                @release_form.generate_pdf.render_file("filename.pdf")
            end
        end
    end

    def index
        @release_forms = ReleaseForm.all
    end

    def release_form_params
        params.require(:release_form).permit(   :claim_number, 
                                                :date_of_accident, 
                                                :defendent, 
                                                :insurance_company_name, 
                                                :law_firm_name, 
                                                :place_of_accident,
                                                :plaintiff,
                                                :policy_number,
                                                :settlement_amount)
    end
end
