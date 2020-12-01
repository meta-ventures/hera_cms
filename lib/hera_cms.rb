require "hera_cms/version"

module HeraCms
  class Error < StandardError; end

  class << self
    attr_accessor :s3_bucket
  end

  def self.test
    return "Successful"
  end
end
