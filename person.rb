require_relative './validator'

class Person
  extend Validations

  validates :name, presence: true
  validates :owner, type: String
  validates :form, format: /\d/
  attr_accessor :name, :owner, :form
end
