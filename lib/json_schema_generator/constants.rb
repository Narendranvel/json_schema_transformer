# frozen_string_literal: true
module JsonSchemaGenerator
  module Constants
    DRAFT7 = 'draft-07'

    DEFAULT_VERSION = 'draft7'
    DRAFT7_VERSION = %w(draft7 draft-07)

    SUPPORTED_VERSIONS = DRAFT7_VERSION

    ARRAY_VALIDATIONS = %I(first_element any_of)

    DEFAULT_ARRAY_VALIDATION = :first_element

    SCHEMA_CLASS = {'draft-07' => 'JsonSchemaGenerator::Draft07'}
  end
end
