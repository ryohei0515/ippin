# frozen_string_literal: true

require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

unless Rails.env.test?
  CarrierWave.configure do |config|
    config.storage :fog
    config.cache_storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = Rails.application.credentials.dev_aws[:BUCKET_NAME]
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.dev_aws[:ACCESS_KEY_ID],
      aws_secret_access_key: Rails.application.credentials.dev_aws[:SECRET_ACCESS_KEY_ID],
      region: Rails.application.credentials.dev_aws[:DEFAULT_REGION],
      path_style: true
    }
  end
end
