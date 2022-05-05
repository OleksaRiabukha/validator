module Validations
  class ValidationError < StandardError
    class << self
      def format_error(attr_name, message)
        error_hash = {}
        error_hash[attr_name] = message

        error_hash
      end

      def raise_exception(message)
        raise(self, message, caller)
      end
    end
  end
end
