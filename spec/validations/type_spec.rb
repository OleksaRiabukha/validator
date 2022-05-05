require 'spec_helper'

class TypePerson
  extend Validations

  validates :name, type: String

  attr_accessor :name
end

RSpec.describe Validations::TypeValidator do
  let(:object) { TypePerson.new }
  let(:attr_name) { :name }
  let(:value) { String }
  let(:error) { { attr_name => "#{attr_name.capitalize} should be a type of #{value}" } }

  describe '.validate' do
    before do
      object.name = 999
    end

    it 'adds error to errors object if it does not have an attribute' do
      begin
        Validations::TypeValidator.validate(object, attr_name, value)
      rescue Exception
      end

      expect(object.errors.first).to eq(error)
    end

    it 'raises an exception with message' do
      expect { Validations::TypeValidator.validate(object, attr_name, value) }
        .to raise_exception(Validations::ValidationError, error[:attr_name])
    end
  end
end
