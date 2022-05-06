The module provides a Rails-like model attributes verification for PORO. Currently, it has three verifications:
- for attribute presence
- for the attribute type
- for attribute format

## Usage
- download module
- require `/validator.rb` file in your Ruby file
- extend your Class with `Validations` module:

		```
		class DummyClass
		  extend Validations
		end
    
		```
- list validations for attributes:

		```
		class DummyClass
		  extend Validations

		  validates :name, presence: true
		  validates :date_of_birth, type: DateTime
		  validates :phone_number, format: /\d/
		end

		```
- check if an object is valid with `valid?` instance method, which will return `true` if the object is valid and `false` otherwise
- use `validate!` instance method to check the object for validity. It will raise an error for failed verification
- check `person.rb` file for more examples of usage

## Extension
Add your custom validations to the `/validations/` folder. The name of the validation file should match the class name, the class should be namespaced under the `Validations` module, and the class name should end with `Validator` postfix. The class should contain class method `validate`, which accepts three parameters - `object`, `attr_name`, `value` - and runs the check. Errors with custom messages could be added via `Validations::ValidationError` class. Example for custom validation with the name `absence`:
- Ruby file name: `/validations/absence.rb`
- Namespace and the class name:

		```
		module Validations
		  class AbsenceValidator
		    def self.validate(object, attr_name, value)
		      # Your code
		    end
		  end
		end

		```

- call the validates method in your model:

		```
		class DummyClass
		  validates name, absence: true
		end

		```

## Tests

Validations module is covered with RSpec tests. To run tests, in the root of the project:
- `bundle install`
- `rspec --format documentation`
