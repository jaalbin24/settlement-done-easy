class DocumentsController < ApplicationController
    include DsEnvelope
    before_action :authenticate_user!
    
    def index
        @settlement = Settlement.find(params[:id])
        render :index
    end
        
    def new
        @document = Document.new
        render :new
    end

    def create
        settlement = Settlement.find(params[:settlement_id])
        @document = settlement.documents.build(document_params)
        @document.added_by = current_user
        if @document.save
            flash[:info] = "Release form added! Click <a href=#{document_show_path(@document)}>here<a> to view it."
            redirect_to settlement_show_url(settlement)
        else
            flash.now[:error] = "Failed to upload document!"
            render :new
        end
    end

    def edit
        @document = Document.find(params[:id])
        render :edit
    end

    def update
        @document = Document.find(params[:id])
        if @document.update(document_params)
            flash[:info] = "Release form updated!"
            @document.update_pdf
            # This^ should be moved to the document.rb file.
            # TODO: Move the PDF-updating feature to the model file. This should not be in the controller.
            redirect_to document_show_url(@document)
        else
            flash[:error] = "Failed to update document!"
            render :show
        end 
    end

    def destroy
        document = Document.find(params[:id])
        settlement = document.settlement
        filename = document.pdf.filename
        document.destroy
        flash[:info] = "#{filename} has been removed."
        if settlement.documents.size == 0
            redirect_to settlement_show_url(settlement)
        else
            redirect_back(fallback_location: root_path)
        end
    end

    def show
        @document = Document.find(params[:id])
        respond_to do |format|
            format.html do
                render :show
            end
            format.pdf do
                send_data @document.pdf.download, filename: @document.pdf_file_name
            end
        end
    end

    def approve
        document = Document.find(params[:id])
        document.rejected = false
        document.approved = true
        if document.save
            flash[:info] = "Document approved!"
            redirect_to document_show_url(document)
        else
            flash[:warning] = "Document could not be approved! #{document.errors.full_messages.inspect}"
            redirect_back(fallback_location: root_path)
        end
    end

    def reject
        document = Document.find(params[:id])
        document.rejected = true
        document.approved = false
        if document.save
            flash[:info] = "Document rejected!"
            redirect_to document_show_url(document)
        else
            flash[:warning] = "Document could not be rejected! #{document.errors.full_messages.inspect}"
            redirect_back(fallback_location: root_path)
        end
    end
    
    def ready_to_send
        @document = Document.find(params[:id])
        render :ready_to_send
    end

    def send_to_client
        @document = Document.find(params[:id])
        envelope_args = {
            email_subject: 'Signature Required!',
            signer_email: params[:client_email],
            signer_name: params[:client_name],
            cc_email: Rails.configuration.APP_EMAIL,
            cc_name: 'Settlement Done Easy',
            status: 'sent'
        }
        create_and_send(@document.pdf, envelope_args)
        flash[:info] = "Sent signature request to #{params[:client_email]}"
        redirect_to root_path
    end

    # Defines what parameters can be accepted from a browser. This is for security. Without defining the data expected from the browser,
    # potentially malicious data can be accepted as valid.
    def document_params
        params.require(:document).permit(:claim_number, :policy_number, :pdf, :signed)
    end
end
