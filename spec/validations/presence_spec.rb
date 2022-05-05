require 'spec_helper'

class TestPerson
  extend Validations

  validates :name, presence: true

  attr_accessor :name
end

RSpec.describe Validations::PresenceValidator do
  let(:object) { TestPerson.new }
  let(:attr_name) { :name }
  let(:value) { true }
  let(:error) { { attr_name => "#{attr_name.capitalize} can't be blank" } }

  describe '.validate' do
    it 'adds error to errors object if it does not have an attribute' do
      begin
        Validations::PresenceValidator.validate(object, attr_name, value)
      rescue Exception
      end

      expect(object.errors.first).to eq(error)
    end

    it 'raises an exception with message' do
      expect { Validations::PresenceValidator.validate(object, attr_name, value) }
        .to raise_exception(Validations::ValidationError, error[:attr_name])
    end
  end
end
