require_relative './error_formater'
Dir[File.expand_path('validations/*.rb', __dir__)].each { |file| require file }

module Validations
  def self.extended(klass)
    klass.send(:include, InstanceMethods)
    klass.extend(ClassMethods)
  end

  module InstanceMethods
    attr_reader :object, :errors

    def initialize
      @object = self
      @errors = []
    end

    def valid?
      self.class.validators.each { |option| validate(option) }
      @object.errors.empty?
    end

    def validate!
      self.class.validators.each { |option| validate(option) }
    end

    private

    def validate(option)
      validator, attr_name, value = option.values
      raise_exception = raise_exception?

      if raise_exception
        validator.validate(@object, attr_name, value)
      else
        begin
          validator.validate(@object, attr_name, value)
        rescue Exception
        end
      end
    end

    def raise_exception?
      validate_called = caller.select { |call| call.include?('validate!') }

      validate_called.any?
    end
  end

  module ClassMethods
    def validates(attr_name, options = {})
      raise(ArgumentError, 'Please provide options for validation') if options.empty?

      validators_matcher(attr_name, options)
    end

    def validators
      @validators
    end

    private

    def validators_matcher(attr_name, options)
      @validators = [] unless defined?(@validators)

      transformed_attributes = transform_attributes_for_validator(attr_name, options)

      @validators << transformed_attributes
    end

    def transform_attributes_for_validator(attr_name, options)
      normalized_hash = {}

      options.each_pair do |pair|
        normalized_hash[:validator] = find_validator(pair.first)
        normalized_hash[:attr_name] = attr_name
        normalized_hash[:value] = pair.last
      end

      normalized_hash
    end

    def find_validator(validator)
      Object.const_get("Validations::#{validator.capitalize}Validator")
    end
  end
end
