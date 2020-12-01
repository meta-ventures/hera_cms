# modules
require "hera_cms/version"

# dependencies
require "active_support/dependencies"

# engine
require "hera_cms/engine"

module HeraCms
  class Error < StandardError; end

  # mattr_accessor :app_root

  # class << self
  #   attr_accessor :s3_bucket
  # end

  # Yield self on setup for nice config blocks
  def self.setup
    yield self
  end

  def self.test
    return "Successful"
  end
end

