# frozen_string_literal: true

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_directory = 'www.comic-farm.net'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.aws_s3_user_key,
    aws_secret_access_key: Rails.application.credentials.aws_s3_user_s_key,
    region: Rails.application.credentials.aws_s3_region
  }
  config.fog_public     = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end
