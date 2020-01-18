require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
    CarrierWave.configure do |config|
        config.fog_provider = "fog/aws"
        config.fog_credentials ={
            provider: "AWS",
            aws_access_key_id: ENV["aws_access_key_id"],
            aws_secret_access_key: ENV["aws_secret_access_key"],
            region: 'ap-northeast-1'
        }
        config.fog_directory = "purchase.app.backet"
        
    end
    
    CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/ 
    
end