module DsEnvelope
  include DsApi

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
    # anchor strings.
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

    # create_envelope also sends the envelope since status is set to 'sent'
    results = envelope_api.create_envelope Rails.cache.fetch('account_id'), envelope_definition
    envelope_id = JSON.parse(results.to_json)['envelopeId']
    Rails.logger.info "==> Results from envelope creation: #{results}"
    return envelope_id
  end

  def retrieve_envelope(envelope_id)
    envelope_api = initialize_api_client
    return envelope_api.get_envelope(Rails.cache.fetch('account_id'), envelope_id)
  end

  def download_document(envelope_id)
    envelope_api = initialize_api_client
    document_file = envelope_api.get_document(Rails.cache.fetch('account_id'), 1, envelope_id)
    puts "======================== download_document: document_file = #{document_file} | document_file.class = #{document_file.class}"
    return document_file
  end
end