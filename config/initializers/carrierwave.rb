require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
    CarrierWave.configure do |config|
        config.fog_provider = "fog/aws"
        config.fog_credentials ={
            provider: "AWS",
            aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
            aws_secret_access_key: ENV["AWS_SECRETE_ACCESS_KEY"],
            region: 'ap-northeast-1'
        }

        config.fog_directory = "purchase-app-backet"
        config.asset_host = 'https://purchase-app-backet.s3.amazonaws.com'

    end

    CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

end
