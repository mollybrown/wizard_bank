gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/bank'
require './lib/person'
require 'pry'

class BankTest < Minitest::Test
  def test_it_has_a_name
  	bank = Bank.new("Bank Name")
  	assert_equal "Bank Name", bank.bank_name
  end

  def test_it_allows_account_creation
  	bank = Bank.new("Bank Name")
  	bank.open_account(Person.new("Name", 1000))
  	assert_equal 0, bank.accounts["Name"]
  end

  def test_it_accepts_a_deposit
  	bank = Bank.new("Bank Name")
  	person = Person.new("Name", 1000)
  	bank.open_account(person)
  	bank.deposit(person, 750)
  	assert_equal 750, bank.accounts["Name"]
  	assert_equal 250, person.amount
  end

  def test_cannot_deposit_more_than_current_cash_level
  	bank = Bank.new("Bank Name")
  	person = Person.new("Name", 500)
  	bank.open_account(person)
  	bank.deposit(person, 750)
  	assert_equal 0, bank.accounts["Name"]
  	assert_equal 500, person.amount
  end

  def test_it_allows_withdrawls
  	bank = Bank.new("Bank Name")
  	person = Person.new("Name", 1000)
  	bank.open_account(person)
  	bank.deposit(person, 750)
  	assert_equal 250, person.amount
  	assert_equal 750, bank.accounts["Name"]
  	bank.withdrawal(person, 250)
  	assert_equal 500, person.amount
  	assert_equal 500, bank.accounts["Name"]
  end

  def test_cannot_withdraw_more_than_current_account_balance
  	bank = Bank.new("Bank Name")
  	person = Person.new("Name", 1000)
  	bank.open_account(person)
  	bank.deposit(person, 500)
  	bank.withdrawal(person, 750)
  	assert_equal 500, bank.accounts["Name"]
  end

  def test_person_can_have_multiple_accounts
  	bank_1 = Bank.new("Bank 1 Name")
  	bank_2 = Bank.new("Bank 2 Name")
  	person = Person.new("Name", 1000)
  	bank_1.open_account(person)
  	bank_1.deposit(person, 500)
  	bank_2.open_account(person)
  	bank_2.deposit(person, 10)
  	assert_equal 500, bank_1.accounts["Name"]
  	assert_equal 10, bank_2.accounts["Name"]
  end

  def test_can_transfer_funds_to_another_bank
  	bank_1 = Bank.new("Bank 1 Name")
  	bank_2 = Bank.new("Bank 2 Name")
  	person = Person.new("Name", 1000)
  	bank_1.open_account(person)
  	bank_1.deposit(person, 500)
  	bank_2.open_account(person)
  	bank_2.deposit(person, 10)
  	bank_1.transfer(person, bank_2, 100)
  	assert_equal 400, bank_1.accounts["Name"]
  	assert_equal 110, bank_2.accounts["Name"]
  end

  def test_cannot_transfer_more_than_current_account_balance
  	bank_1 = Bank.new("Bank 1 Name")
  	bank_2 = Bank.new("Bank 2 Name")
  	person = Person.new("Name", 1000)
  	bank_1.open_account(person)
  	bank_1.deposit(person, 500)
  	bank_2.open_account(person)
  	bank_2.deposit(person, 10)
  	bank_1.transfer(person, bank_2, 750)
  	assert_equal 500, bank_1.accounts["Name"]
  end

  def test_cannot_transfer_to_bank_without_account
  	bank_1 = Bank.new("Bank 1 Name")
  	bank_2 = Bank.new("Bank 2 Name")
  	person = Person.new("Name", 1000)
  	bank_1.open_account(person)
  	bank_1.deposit(person, 500)
  	bank_1.transfer(person, bank_2, 750)
  	assert_equal 500, bank_1.accounts["Name"]
  	assert_equal nil, bank_2.accounts["Name"]
  end

  def test_it_returns_total_cash_in_bank
  	bank_1 = Bank.new("Bank 1 Name")
  	person_1 = Person.new("Name_1", 1000)
  	person_2 = Person.new("Name_2", 2000)
  	bank_1.open_account(person_1)
  	bank_1.deposit(person_1, 1000)
  	bank_1.open_account(person_2)
  	bank_1.deposit(person_2, 2000)
  	assert_equal 3000, bank_1.total_cash
  end
end