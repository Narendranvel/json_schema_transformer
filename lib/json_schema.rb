# frozen_string_literal: true

require 'json'
require 'json_schema/version'
require 'json_schema/Constants'
require 'json_schema/draft07'

module JsonSchema
  class << self
    include Constants
    def generate(json_data, options = {})
      version = options[:schema_version] || DEFAULT_VERSION
      options[:array_validation] = options[:array_validation] || DEFAULT_ARRAY_VALIDATION
      raise "Unsupported Schema version: #{version}" unless SUPPORTED_VERSIONS.include? version.to_s.downcase
      # raise "Unsupported Array Validation #{options[:array_validation]}" unless options[:array_validation] && ARRAY_VALIDATIONS.include? options[:array_validation]
      # Todo - Support draft4 & draft6
      @version = DRAFT7 if DRAFT7_VERSION.include? version.to_s.downcase
      @schema_class = Object.const_get(SCHEMA_CLASS[@version])
      @schema_class.new(json_data, options).generate
    end
  end
end
