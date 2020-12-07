# frozen_string_literal: true

RakutenWebService.configure do |c|
  c.application_id = Rails.application.credentials.rakuten_app_id
  c.affiliate_id = Rails.application.credentials.rakuten_afi_id
end
