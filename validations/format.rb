module Validations
  class FormatValidator
    def self.validate(object, attr_name, value)
      return if object.send(attr_name).match?(value)

      error_message = "#{attr_name.capitalize} should match /#{value.source}/ format"
      error = ValidationError.format_error(attr_name, error_message)

      object.errors << error
      ValidationError.raise_exception(error_message)
    end
  end
end
