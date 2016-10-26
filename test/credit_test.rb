gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/bank'
require './lib/person'
require './lib/credit'
require 'pry'

class CreditTest < Minitest::Test
  def test_it_has_a_name
  	credit = Credit.new("Credit Name")
  	assert_equal "Credit Name", credit.credit_name
  end

  def test_person_can_open_a_new_credit_line
  	credit = Credit.new("Credit Name")
  	person = Person.new("Name", 1000)
  	credit.open_credit(person, 5000, 0.05)
  	assert_equal 5000, credit.credit_accounts["Name"][0]
  	assert_equal 0.05, credit.credit_accounts["Name"][1]
  end

  def test_person_can_spend_against_credit_limit
  	credit = Credit.new("Credit Name")
  	person = Person.new("Name", 1000)
  	credit.open_credit(person, 5000, 0.05)
  	credit.cc_spend("Name", 500)
  	assert_equal 4500, credit.credit_accounts["Name"][0]
  end

  def test_person_cannot_spend_more_than_credit_limit
  	credit = Credit.new("Credit Name")
  	person = Person.new("Name", 1000)
  	credit.open_credit(person, 5000, 0.05)
  	credit.cc_spend("Name", 10000)
  	assert_equal 5000, credit.credit_accounts["Name"][0]
  end

  def test_person_can_pay_down_credit_balance
  	credit = Credit.new("Credit Name")
  	person = Person.new("Name", 1000)
  	credit.open_credit(person, 5000, 0.05)
  	credit.cc_spend("Name", 2000)
  	credit.cc_pay_down_balance("Name", 100)
  	assert_equal 3100, credit.credit_accounts["Name"][0]
  end

  def test_person_cannot_pay_down_credit_balance_with_nonexistant_cash
  	credit = Credit.new("Credit Name")
  	person = Person.new("Name", 1000)
  	credit.open_credit(person, 5000, 0.05)
  	credit.cc_spend("Name", 2000)
  	credit.cc_pay_down_balance("Name", 1500)
  	assert_equal 1000, person.amount
  end

end
