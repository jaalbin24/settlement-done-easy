# frozen_string_literal: true

module DsApi
  def initialize_api_client
    configuration = DocuSign_eSign::Configuration.new
    configuration.debugging = false
    @api_client = DocuSign_eSign::ApiClient.new(configuration)
    @api_client.set_oauth_base_path(Rails.configuration.DOCUSIGN_BASE_PATH)
    token = request_new_access_token
    Rails.cache.fetch('access_token', expires_in: 1.hours) do
      token
    end
    account = @api_client.get_user_info(token.access_token).accounts.find(&:is_default)
    account_id = account.account_id
    Rails.cache.fetch('account_id', expires_in: 1.hours) do
      account_id
    end
    configuration = DocuSign_eSign::Configuration.new
    configuration.host = account.base_uri
    api_client = DocuSign_eSign::ApiClient.new configuration

    api_client.default_headers['Authorization'] = "Bearer #{token.access_token}"

    return DocuSign_eSign::EnvelopesApi.new api_client
  end

  def request_new_access_token
    rsa_pk = docusign_rsa_private_key_file
    begin
      # DocuSign_eSign::ApiClient.request_jwt_user_token() generates a JWT and sends it to DS. DS sends back an access token that is
      # returned by the method. The access token is used to authenticate all future API calls. It must be set to expire after 1 hour
      # or it will not be granted in the first place.
      access_token = @api_client.request_jwt_user_token(
            Rails.configuration.DOCUSIGN_INTEGRATION_KEY,
            Rails.configuration.DOCUSIGN_USER_ID,
            rsa_pk,
            expires_in=3600,
            Rails.configuration.DOCUSIGN_SCOPE)
    rescue DocuSign_eSign::ApiError => exception
      Rails.logger.warn exception.inspect
    rescue OpenSSL::PKey::RSAError => exception
      Rails.logger.error exception.inspect
      if File.read(rsa_pk).starts_with? '{RSA_PRIVATE_KEY}'
        fail "Please add your private RSA key to: #{rsa_pk}"
      else
        raise
      end
    else
      return access_token
    end
  end

  def create_envelope_api(args)
    token = Rails.cache.fetch('access_token')
    configuration = DocuSign_eSign::Configuration.new
    configuration.host = args[:base_path]
    api_client = DocuSign_eSign::ApiClient.new configuration
    api_client.default_headers['Authorization'] = "Bearer #{args[:access_token]}"
    DocuSign_eSign::EnvelopesApi.new api_client
  end

  def docusign_rsa_private_key_file
    File.join(Rails.root, 'config', 'docusign_private_key.txt')
  end
end
