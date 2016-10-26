gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/person'
require 'pry'

class PersonTest < Minitest::Test
  def test_class_exists
  	person = Person.new("Name", 1000)
  	assert_equal Person, person.class
  end

  def test_person_has_a_name
  	person = Person.new("Name", 1000)
  	assert_equal "Name", person.name
  end

  def test_person_has_an_initial_amount
  	person = Person.new("Name", 1000)
  	assert_equal 1000 , person.amount
  end

end