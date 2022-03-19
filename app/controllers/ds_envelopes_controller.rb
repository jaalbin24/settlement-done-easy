class DsEnvelopesController < ApplicationController
    before_action :check_jwt_auth

    def check_jwt_auth
        
    end
    
    def generate_jwt





    end
    # envelope_args = {
    #     signer_email: sanitize_params(params['signerEmail']),
    #     signer_name: sanitize_params(params['signerName']),
    #     cc_email: sanitize_params(params['ccEmail']),
    #     cc_name: sanitize_params(params['ccName']),
    #     status: 'sent'
    #   }
    def create(envelope_args)
        # document 1 (HTML) has tag **signature_1**
        # document 2 (DOCX) has tag /sn1/
        # document 3 (PDF) has tag /sn1/
        #
        # The envelope has two recipients:
        # recipient 1 - signer
        # recipient 2 - cc
        # The envelope will be sent first to the signer.
        # After it is signed, a copy is sent to the cc person
    
        # Create the envelope definition
        envelope_definition = DocuSign_eSign::EnvelopeDefinition.new
    
        envelope_definition.email_subject = 'Please sign this document set'
    
        # Add the documents
        doc1_b64 = Base64.encode64(create_document1(envelope_args))
        # Read files 2 and 3 from a local directory
        # The reads could raise an exception if the file is not available!
        doc_docx = Rails.application.config.doc_docx
        doc2_b64 = Base64.encode64(File.binread(File.join('data', doc_docx)))
        doc_pdf = Rails.application.config.doc_pdf
        doc3_b64 = Base64.encode64(File.binread(File.join('data', doc_pdf)))
    
        # Create the document models
        document1 = DocuSign_eSign::Document.new(
          # Create the DocuSign document object
          documentBase64: doc1_b64,
          name: 'Order acknowledgement', # Can be different from actual file name
          fileExtension: 'html', # Many different document types are accepted
          documentId: '1' # A label used to reference the doc
        )
        document2 = DocuSign_eSign::Document.new(
          # Create the DocuSign document object
          documentBase64: doc2_b64,
          name: 'Battle Plan', # Can be different from actual file name
          fileExtension: 'docx', # Many different document types are accepted
          documentId: '2' # A label used to reference the do
        )
        document3 = DocuSign_eSign::Document.new(
          # Create the DocuSign document object
          documentBase64: doc3_b64,
          name: 'Lorem Ipsum', # Can be different from actual file name
          fileExtension: 'pdf', # Many different document types are accepted
          documentId: '3' # A label used to reference the doc
        )
    
        # The order in the docs array determines the order in the envelope
        envelope_definition.documents = [document1, document2, document3]
    
        # Create the signer recipient model
        signer1 = DocuSign_eSign::Signer.new
        signer1.email = envelope_args[:signer_email]
        signer1.name = envelope_args[:signer_name]
        signer1.recipient_id = '1'
        signer1.routing_order = '1'
        ## routingOrder (lower means earlier) determines the order of deliveries
        # to the recipients. Parallel routing order is supported by using the
        # same integer as the order for two or more recipients
    
        # Create a cc recipient to receive a copy of the documents
        cc1 = DocuSign_eSign::CarbonCopy.new(
          email: envelope_args[:cc_email],
          name: envelope_args[:cc_name],
          routingOrder: '2',
          recipientId: '2'
        )
        # Create signHere fields (also known as tabs) on the documents
        # We're using anchor (autoPlace) positioning
        #
        # The DocuSign platform searches throughout your envelope's documents for matching
        # anchor strings. So the sign_here_2 tab will be used in both document 2 and 3
        # since they use the same anchor string for their "signer 1" tabs.
        sign_here1 = DocuSign_eSign::SignHere.new(
          anchorString: '**signature_1**',
          anchorYOffset: '10',
          anchorUnits: 'pixels',
          anchorXOffset: '20'
        )
    
        sign_here2 = DocuSign_eSign::SignHere.new(
          anchorString: '/sn1/',
          anchorYOffset: '10',
          anchorUnits: 'pixels',
          anchorXOffset: '20'
        )
        # Add the tabs model (including the sign_here tabs) to the signer
        # The Tabs object takes arrays of the different field/tab types
        signer1_tabs = DocuSign_eSign::Tabs.new({
          signHereTabs: [sign_here1, sign_here2]
        })
    
        signer1.tabs = signer1_tabs
    
        # Add the recipients to the envelope object
        recipients = DocuSign_eSign::Recipients.new(
          signers: [signer1],
          carbonCopies: [cc1]
        )
        # Request that the envelope be sent by setting status to "sent".
        # To request that the envelope be created as a draft, set status to "created"
        envelope_definition.recipients = recipients
        envelope_definition.status = envelope_args[:status]
        envelope_definition
    end

    # Small defence against code injection
    def sanitize_param(param)
        param.gsub(/([^\w \-\@\.\,])+/, '')
    end

    def redirect_to_authenticate_via_jwt
        redirect_to 'https://account-d.docusign.com/oauth/auth?response_type=code&scope=impersonation&client_id=7c3457f0-5abb-49f7-97b8-5ad0c634eed9&redirect_uri=http://localhost:3000/ds_test_page'
    end
end
