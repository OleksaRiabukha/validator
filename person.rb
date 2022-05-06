require 'date'
require_relative './validator'

class Person
  extend Validations

  validates :name, presence: true
  validates :date_of_birth, type: DateTime
  validates :phone_number, format: /\d/

  attr_accessor :name, :date_of_birth, :phone_number
end

valid_person = Person.new
valid_person.name = 'TestPerson'
valid_person.date_of_birth = DateTime.new(2001, 2, 3)
valid_person.phone_number = '99999999'

puts valid_person.valid?               # => true
valid_person.validate!                 # => will not raise an exception

person_with_invalid_name = Person.new
person_with_invalid_name.date_of_birth = DateTime.new(2001, 2, 3)
person_with_invalid_name.phone_number = '99999'

puts person_with_invalid_name.valid?   # => false

# uncomment to see an exception, comment it out to see following examples
# person_with_invalid_name.validate!   # => will raise Name can't be blank (Validations::ValidationError) exception

person_with_invalid_type = Person.new
person_with_invalid_type.name = 'TestPerson'
person_with_invalid_type.date_of_birth = 'March 20'
person_with_invalid_type.phone_number = '99999'

puts person_with_invalid_type.valid?   # => false

# uncomment to see an exception, comment it out to see following examples
# person_with_invalid_type.validate!     # => will raise Date_of_birth should be a type of DateTime (Validations::ValidationError) exception

person_with_invalid_format = Person.new
person_with_invalid_format.name = 'TestPerson'
person_with_invalid_format.date_of_birth = DateTime.new(2001, 2, 3)
person_with_invalid_format.phone_number = 'GGGG'

puts person_with_invalid_format.valid? # => false

# uncomment to see an exception, comment it out to see following examples
# person_with_invalid_format.validate!   # => Phone_number should match /\\d/ format (Validations::ValidationError) exception
