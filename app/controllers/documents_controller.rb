class DocumentsController < ApplicationController
    include DsEnvelope
    before_action :authenticate_user!
    
    def index
        @settlement = Settlement.find_by!(public_id: params[:id])
        if @settlement.nil?
            handle_invalid_request
            return
        end
        render :index
    end
        
    def new
        @settlement = Settlement.find_by!(public_id: params[:id])
        if @settlement.nil?
            handle_invalid_request
            return
        end
        @document = Document.new
        render :new
    end

    def create
        settlement = Settlement.find_by!(public_id: params[:id])
        if settlement.nil?
            handle_invalid_request
            return
        end
        @document = settlement.documents.build(document_params)
        @document.added_by = current_user
        if @document.save
            flash[:info] = "Release form added! Click <a href=#{document_show_path(@document)}>here<a> to view it."
            redirect_back(fallback_location: root_path)
        else
            flash.now[:error] = "Failed to upload document!"
            render :new
        end
    end

    def update
        @document = Document.find_by!(public_id: params[:id])
        if @document.nil?
            handle_invalid_request
            return
        end
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
        document = Document.find_by!(public_id: params[:id])
        if document.nil?
            handle_invalid_request
            return
        end
        filename = document.pdf_file_name
        settlement = document.settlement
        if document.destroy
            flash[:info] = "#{filename} has been deleted."
        else
            flash[:info] = "#{filename} could not be removed right now. Try again later."
        end
        redirect_to settlement_show_url(settlement)
    end

    def show
        begin
            @document = Document.find_by!(public_id: params[:id])
            @settlement = @document.settlement
            @approval_progress = ((@document.reviews.approvals.size.to_f / @document.reviews.size) * 100).to_i
        rescue ActiveRecord::RecordNotFound => e
            flash[:info] = "That document does not exist."
            redirect_to root_path
            return
        rescue => e
            flash[:info] = "An unknown error occured."
            puts "⚠️⚠️⚠️ ERROR: #{e.message}"
            redirect_back(fallback_location: root_path)
            return
        end
        respond_to do |format|
            format.html do
                render :show
            end
            format.pdf do
                send_data @document.pdf.download, filename: @document.pdf_file_name
            end
        end
    end
    
    def ready_to_send
        @document = Document.find_by!(public_id: params[:id])
        render :ready_to_send
    end

    def get_e_signature
        begin
            @document = Document.find_by!(public_id: params[:id])
        rescue
            handle_invalid_request
            return
        end
        if !@document.approved?
            flash[:info] = "Document must be approved before e-signing."
            redirect_back(fallback_location: root_path)
        else
            render :get_e_signature
        end
    end

    def send_ds_signature_request
        begin
            document = Document.find_by!(public_id: params[:id])
            if params[:client_email] == nil || !params[:client_email].include?("@") || !params[:client_email].include?(".")
                flash.now[:warning] = "You did not provide a valid client email. No email sent."
                redirect_back(fallback_location: root_path)
                return
            elsif params[:client_name] != document.settlement.claimant_name
                flash[:warning] = "Client's name does not match the plaintiff name given in settlement. No email sent."
                redirect_back(fallback_location: root_path)
                return
            elsif !document.approved?
                flash[:info] = "Document must be approved before e-signing."
                redirect_back(fallback_location: root_path)
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
        if !document.save
            puts "====================== ERROR SAVING: #{document.errors.full_messages.inspect}"
        end
        puts "================================================================================================================= DS ENVELOPE ID: #{document.ds_envelope_id}"
        flash[:info] = "Sent signature request to #{params[:client_email]}"
        redirect_back(fallback_location: root_path)
    end

    def get_ds_envelope_status
        document = Document.find_by!(public_id: params[:id])
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
                doc.added_by = User.find_by!(public_id: 0)
                doc.ds_envelope_id = document.ds_envelope_id
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
