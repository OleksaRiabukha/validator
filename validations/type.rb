module Validations
  class TypeValidator
    def self.validate(object, attr_name, value)
      return if object.send(attr_name).is_a?(value)

      error_message = "#{attr_name.capitalize} should be a type of #{value}"
      error = ValidationError.format_error(attr_name, error_message)

      object.errors << error
      ValidationError.raise_exception(error_message)
    end
  end
end
