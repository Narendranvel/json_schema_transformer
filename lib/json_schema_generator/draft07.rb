# frozen_string_literal: true
require 'json_schema_generator/draft_constants'

module JsonSchemaGenerator
  class Draft07
    include DraftConstants
    def initialize(raw_json, options = {})
      @raw_json = raw_json
      @options = options
      @parsed_json = parse(raw_json)
    end

    def generate
      raise StandardError, 'Invalid Input. Input should in the valid JSON format' unless parsed_json
      { 'title' => ROOT_TITLE, 'description' => ROOT_DESCRIPTION, "$schema" => "http://json-schema.org/draft-07/schema" }.merge(schema_generate(parsed_json))
    end

    private

    attr_reader :raw_json, :options, :parsed_json

    def parse(json)
      JSON.parse(json)
    rescue StandardError
      nil
    end

    def schema_generate(input)
      case input
      when Hash
        generate_object(input)
      when Array
        generate_array(input)
      else
        {'type' => datatype(input)}
      end
    end

    def generate_object(object)
      params = {
        'type' => 'object',
        'required' => object.keys,
        'properties' => {}
      }
      object.each_with_object(params) do |(key, value), hsh|
        hsh['properties'].merge!({key => schema_generate(value)})
      end
    end

    def generate_array(array)
      params = {
        'type' => 'array',
        'items' => {},
      }
      case @options[:array_validation]
      when :any_of
        params['items']['anyOf'] = []
        array.each_with_object(params) do |elem, hsh|
          hsh['items']['anyOf'].push(schema_generate(elem))
        end
      when :first_element
        array.values_at(0).each_with_object(params) do |elem, hsh|
          hsh['items'].merge!(schema_generate(elem))
        end
      end
    end

    def datatype(value)
      case value
      when TrueClass, FalseClass
        'boolean'
      when Float
        'number'
      when Hash
        'object'
      when String, Integer, Array
        value.class.to_s.downcase
      when NilClass
        'null'
      else
        raise Error, "Invalid type #{value.class}"
      end
    end
  end
end
