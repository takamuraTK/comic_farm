# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  config.enable_standard_devise_support = true
  config.default_confirm_success_url = "confirmed"

  config.change_headers_on_each_request = false
  config.token_lifespan = 1.month

  config.headers_names = {:'access-token' => 'access-token',
                          :'client' => 'client',
                          :'expiry' => 'expiry',
                          :'uid' => 'uid',
                          :'token-type' => 'token-type' }
end
