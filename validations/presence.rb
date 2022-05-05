module Validations
  class PresenceValidator
    def self.validate(object, attr_name, value)
      return unless value
      return unless object.send(attr_name).nil?

      error_message = "#{attr_name.capitalize} can't be blank"
      error = ValidationError.format_error(attr_name, error_message)

      object.errors << error
      ValidationError.raise_exception(error_message)
    end
  end
end
