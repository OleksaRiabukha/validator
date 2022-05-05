require 'pry'
require_relative './spec_helper'

class TestPerson
  extend Validations

  validates :name, presence: true

  attr_accessor :name
end

RSpec.describe Validations do
  describe '.extended' do
    it 'extends class with Validations::ClassMethods class methods' do
      expect(TestPerson.singleton_class.ancestors).to include(Validations::ClassMethods)
    end

    it 'includes Validations::InstanceMethods into the class' do
      expect(TestPerson.ancestors).to include(Validations::InstanceMethods)
    end
  end
end

RSpec.describe Validations::InstanceMethods do
  let(:person) { TestPerson.new }

  describe '#initialize' do
    it 'initializes an object' do
      expect(person.instance_variable_get(:@object)).to be_a(TestPerson)
    end

    it 'initializes an error object of array type' do
      expect(person.instance_variable_get(:@errors)).to be_a(Array)
    end
  end

  describe '#valid?' do
    it 'returns false if validations failed' do
      expect(person.valid?).to be_falsy
    end

    it 'returns true if all validations passed successfully' do
      person.name = 'test name'
      expect(person.valid?).to be_truthy
    end
  end

  describe '#validate!' do
    it 'raises an Exception if validation failed' do
      expect { person.validate! }.to raise_error(Validations::ValidationError)
    end

    it 'throws an error message with attribute details' do
      attribute_name = 'name'
      expect { person.validate! }
        .to raise_error(Validations::ValidationError, "#{attribute_name.capitalize} can't be blank")
    end
  end
end

RSpec.describe Validations::ClassMethods do
  describe '.validates' do
    it 'raises an ArgumentError if called without options' do
      expect { TestPerson.validates(:name) }.to raise_error(ArgumentError)
    end

    it 'calls .validators_matcher to set validator with attr name and value' do
      validators = TestPerson.instance_variable_get(:@validators).first

      aggregate_failures do
        expect(validators[:validator]).to eq(Validations::PresenceValidator)
        expect(validators[:attr_name]).to eq(:name)
        expect(validators[:value]).to eq(true)
      end
    end
  end

  describe '.validators' do
    it 'returns a validators instance' do
      validators = TestPerson.instance_variable_get(:@validators)

      expect(TestPerson.validators).to eq(validators)
    end
  end
end
