require 'yaml'

module JwtAuth
  class JwtCreator
    include ApiCreator

    def initialize
      @api_client = initialize_api_client
      check_jwt_token
    end

    def get_access_token_from_ds
      rsa_pk = docusign_rsa_private_key_file
      begin
        # GET /oauth/auth
        # This endpoint is used to obtain consent and is the first step in several authentication flows.
        # https://developers.docusign.com/platform/auth/reference/obtain-consent
        @token = api_client.request_jwt_user_token(
          Rails.configuration.DOCUSIGN_INTEGRATION_KEY, 
          Rails.configuration.DOCUSIGN_USER_ID, 
          rsa_pk, 
          expires_in=3600, 
          Rails.configuration.DOCUSIGN_SCOPE)
      rescue DocuSign_eSign::ApiError => exception
        Rails.logger.warn exception.inspect
      end
    end

    # DocuSign authorization URI to obtain individual consent
    # https://developers.docusign.com/platform/auth/jwt/jwt-get-token
    # https://developers.docusign.com/platform/auth/consent/obtaining-individual-consent/
    def self.consent_url
      # GET /oauth/auth
      # This endpoint is used to obtain consent and is the first step in several authentication flows.
      # https://developers.docusign.com/platform/auth/reference/obtain-consent
      
      base_uri = "#{Rails.configuration.DOCUSIGN_AUTH_SERVER}/oauth/auth"
      response_type = "code"
      scopes = ERB::Util.url_encode(Rails.configuration.DOCUSIGN_SCOPE) # https://developers.docusign.com/platform/auth/reference/scopes/
      client_id = Rails.configuration.DOCUSIGN_INTEGRATION_KEY
      redirect_uri = Rails.configuration.DOCUSIGN_REDIRECT_URI
      consent_url = "#{base_uri}?response_type=#{response_type}&scope=#{scopes}&client_id=#{client_id}&redirect_uri=#{redirect_uri}"
      Rails.logger.info "==> Obtain Consent Grant required: #{consent_url}"
      consent_url
    end

    # @return [Boolean] `true` if the token was successfully updated, `false` if consent still needs to be grant'ed
    def check_jwt_token
      rsa_pk = docusign_rsa_private_key_file
      begin
        # docusign_esign: POST /oauth/token
        # This endpoint enables you to exchange an authorization code or JWT token for an access token.
        # https://developers.docusign.com/platform/auth/reference/obtain-access-token
        token = @api_client.request_jwt_user_token(Rails.configuration.DOCUSIGN_INTEGRATION_KEY, Rails.configuration.DOCUSIGN_USER_ID, rsa_pk, expires_in=3600, Rails.configuration.DOCUSIGN_SCOPE)
      rescue OpenSSL::PKey::RSAError => exception
        Rails.logger.error exception.inspect
        if File.read(rsa_pk).starts_with? '{RSA_PRIVATE_KEY}'
          fail "Please add your private RSA key to: #{rsa_pk}"
        else
          raise
        end
      rescue DocuSign_eSign::ApiError => exception
        Rails.logger.warn exception.inspect

        if exception.response_body == nil
          return false
        end

        body = JSON.parse(exception.response_body)

        if body['error'] == "consent_required"
          false
        else
          details = <<~TXT
            See: https://support.docusign.com/articles/DocuSign-Developer-Support-FAQs#Troubleshoot-JWT-invalid_grant
            or https://developers.docusign.com/esign-rest-api/guides/authentication/oauth2-code-grant#troubleshooting-errors
            or try enabling `configuration.debugging = true` in the initialize method above for more logging output
          TXT
          fail "JWT response error: `#{body}`. #{details}"
        end
      else
        update_account_info(token)
        true
      end
    end

    def update_account_info(token)
      # docusign_esign: GET /oauth/userinfo
      # This endpoint returns information on the caller, including their name, email, account, and organizational information.
      # The response includes the base_uri needed to interact with the DocuSign APIs.
      # https://developers.docusign.com/platform/auth/reference/user-info
      user_info_response = @api_client.get_user_info(token.access_token)
      accounts = user_info_response.accounts
      target_account_id = false
      account = get_account(accounts, target_account_id)
      store_data(token, user_info_response, account)

      @api_client.config.host = account.base_uri
      Rails.logger.info "==> JWT: Received token for impersonated user which will expire in: #{token.expires_in.to_i.seconds / 1.hour} hour at: #{Time.at(token.expires_in.to_i.seconds.from_now)}"
    end

    def store_data(token, user_info, account)
      @access_token = token.access_token
      @account_id = account.account_id
      @base_path = account.base_uri
    end

    def fetch_access_token
      @access_token
    end

    def fetch_base_path
      @base_path
    end

    def fetch_account_id
      @account_id
    end

    def get_account(accounts, target_account_id)
      if target_account_id.present?
        return accounts.find { |acct| acct.account_id == target_account_id }
        raise "The user does not have access to account #{target_account_id}"
      else
        accounts.find(&:is_default)
      end
    end

    def docusign_rsa_private_key_file
      File.join(Rails.root, 'config', 'docusign_private_key.txt')
    end
  end
end
