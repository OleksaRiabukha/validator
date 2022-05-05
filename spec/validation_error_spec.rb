require 'spec_helper'

RSpec.describe Validations::ValidationError do
  let(:attr_name) { :name }
  let(:message) { "Name can't be blank" }
  let(:error_hash) { { attr_name => message } }

  describe '.format_error' do
    it 'return a hash with formatted error' do
      expect(Validations::ValidationError.format_error(attr_name, message)).to eq(error_hash)
    end
  end

  describe '.raise_exception' do
    it 'raises an Validations::ValidationError exception with custom message' do
      expect { Validations::ValidationError.raise_exception(message) }
        .to raise_exception(Validations::ValidationError, message)
    end
  end
end
