RakutenWebService.configure do |c|
    c.application_id = Rails.application.credentials.rakuten_app_id.to_s
    c.affiliate_id = Rails.application.credentials.rakuten_afi_id
end
