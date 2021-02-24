# modules
require "hera_cms/version"

# dependencies
require "active_support/dependencies"

# engine
require "hera_cms/engine"

module HeraCms
  class Error < StandardError; end

  # mattr_accessor :app_root

  class << self
    # attr_accessor :s3_bucket
    attr_accessor :image_upload, :upload_service
  end

  # Yield self on setup for nice config blocks
  def self.setup
    yield self
  end

  def self.active_storage?
    self.image_upload && ["active_storage", :active_storage].include?(self.upload_service&.downcase)
  end
end

