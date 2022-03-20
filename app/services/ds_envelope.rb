module DsEnvelope
    include ApiCreator

    def create_and_send(document, envelope_args)
  
      envelope_definition = DocuSign_eSign::EnvelopeDefinition.new
  
      envelope_definition.email_subject = envelope_args[:email_subject]
  
      # Create the document models
      ds_document = DocuSign_eSign::Document.new(
        documentBase64: Base64.encode64(document.download),
        name: 'RELEASE FORM', # Can be different from actual file name
        fileExtension: 'pdf', # Many different document types are accepted
        documentId: '1' # A label used to reference the doc
      )
  
      # The order in the docs array determines the order in the envelope
      envelope_definition.documents = [ds_document]
  
      # Create the signer recipient model
      signer = DocuSign_eSign::Signer.new
      signer.email = envelope_args[:signer_email]
      signer.name = envelope_args[:signer_name]
      signer.recipient_id = '1'
      signer.routing_order = '1'
      ## routingOrder (lower means earlier) determines the order of deliveries
      # to the recipients. Parallel routing order is supported by using the
      # same integer as the order for two or more recipients
  
      # Create a cc recipient to receive a copy of the documents
      carbon_copy = DocuSign_eSign::CarbonCopy.new(
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
      signer_tabs = DocuSign_eSign::Tabs.new({
        signHereTabs: [sign_here1, sign_here2]
      })
  
      signer.tabs = signer_tabs
  
      # Add the recipients to the envelope object
      recipients = DocuSign_eSign::Recipients.new(
        signers: [signer],
        carbonCopies: [carbon_copy]
      )
      # Request that the envelope be sent by setting status to "sent".
      # To request that the envelope be created as a draft, set status to "created"
      envelope_definition.recipients = recipients
      envelope_definition.status = 'sent'
  
      envelope_api = initialize_api_client
  
      results = envelope_api.create_envelope Rails.cache.fetch('account_id'), envelope_definition
      envelope_id = results.envelope_id
      { 'envelope_id' => envelope_id }
    end
  
    # Small defence against code injection
    def sanitize_param(param)
        param.gsub(/([^\w \-\@\.\,])+/, '')
    end
end