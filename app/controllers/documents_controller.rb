class DocumentsController < ApplicationController
    include DsEnvelope
    before_action :authenticate_user!
    
    def index
        @settlement = Settlement.find(params[:id])
        render :index
    end
        
    def new
        @settlement = Settlement.find(params[:id])
        @document = Document.new
        render :new
    end

    def create
        settlement = Settlement.find(params[:id])
        @document = settlement.documents.build(document_params)
        @document.added_by = current_user
        if @document.signed?
            @document.uses_wet_signature = true
        end
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

    def get_e_signature
        begin
            @document = Document.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        if !@document.approved?
            flash[:info] = "Document must be approved before e-signing."
            redirect_to document_show_url(@document)
        else
            render :get_e_signature
        end
    end

    def send_ds_signature_request
        begin
            document = Document.find(params[:id])
            if params[:client_email] == nil || !params[:client_email].include?("@") || !params[:client_email].include?(".")
                flash.now[:warning] = "You did not provide a valid client email. No email sent."
                redirect_to document_show_url(document)
                return
            elsif params[:client_name] != document.settlement.plaintiff_name
                flash[:warning] = "Client's name does not match the plaintiff name given in settlement. No email sent."
                redirect_to document_show_url(document)
                return
            elsif !document.approved?
                flash[:info] = "Document must be approved before e-signing."
                redirect_to document_show_url(document)
                return
            end
        rescue
            handle_invalid_request
            return
        end
        envelope_args = {
            email_subject: "#{document.settlement.attorney.full_name} is requesting a signature.",
            signer_email: params[:client_email],
            signer_name: params[:client_name],
            cc_email: Rails.configuration.APP_EMAIL,
            cc_name: 'Settlement Done Easy',
            status: 'sent'
        }
        envelope_id = create_and_send(document.pdf, envelope_args)
        document.settlement.signature_requested = true
        document.ds_envelope_id = envelope_id
        document.uses_wet_signature = false
        if !document.save
            puts "====================== ERROR SAVING: #{document.errors.full_messages.inspect}"
        end
        puts "================================================================================================================= DS ENVELOPE ID: #{document.ds_envelope_id}"
        flash[:info] = "Sent signature request to #{params[:client_email]}"
        redirect_to document_show_url(document)
    end

    def get_ds_envelope_status
        document = Document.find(params[:id])
        if !document.signed? && document.ds_envelope_id != nil
            envelope = retrieve_envelope(document.ds_envelope_id)
            status = JSON.parse(envelope.to_json)['status']
            flash[:info] = "Document signature status: #{status}"
            puts "================================== get_ds_envelope_status: envelope = #{envelope}"
            if status == "completed" 
                temp_file = download_document(document.ds_envelope_id)
                doc = document.settlement.documents.build(
                    signed: true
                )
                doc.pdf.attach(io: temp_file.open, filename: doc.pdf_file_name, content_type: "application/pdf")
                doc.added_by = User.find(0)
                if !doc.save
                    puts "============== doc not saved! #{doc.errors.full_messages.inspect}"
                end
            end
        else
            handle_invalid_request
            return
        end
        redirect_to root_path
    end

    # Defines what parameters can be accepted from a browser. This is for security. Without defining the data expected from the browser,
    # potentially malicious data can be accepted as valid.
    def document_params
        params.require(:document).permit(:claim_number, :policy_number, :pdf, :signed)
    end
end
