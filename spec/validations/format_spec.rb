require 'spec_helper'

class FormatPerson
  extend Validations

  validates :name, type: /\d/

  attr_accessor :name
end

RSpec.describe Validations::FormatValidator do
  let(:object) { FormatPerson.new }
  let(:attr_name) { :name }
  let(:value) { /\d/ }
  let(:error) { { attr_name => "#{attr_name.capitalize} should match /#{value.source}/ format" } }

  describe '.validate' do
    before do
      object.name = 'test'
    end
    it 'adds error to errors object if attribute doe not match a provided format' do
      begin
        Validations::FormatValidator.validate(object, attr_name, value)
      rescue Exception
      end

      expect(object.errors.first).to eq(error)
    end

    it 'raises an exception with message' do
      expect { Validations::FormatValidator.validate(object, attr_name, value) }
        .to raise_exception(Validations::ValidationError, error[:attr_name])
    end
  end
end
