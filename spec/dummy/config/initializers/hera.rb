# see https://github.com/horta-tech/hera_cms for more info

HeraCms.setup do |config|
  config.image_upload = false
  config.upload_service = :active_storage
end
