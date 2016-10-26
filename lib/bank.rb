require'pry'

class Bank

	attr_reader :bank_name,
				      :accounts

	def initialize(bank_name)
		@bank_name = bank_name
		@accounts = {}
	end

	def open_account(person)
		accounts[person.name] = 0
	end

	def deposit(person, deposit_amount)
		if deposit_amount > person.amount
			#puts "#{person.name} does not have enough cash to perform this deposit."
		else	
			accounts[person.name] += deposit_amount
			person.amount -= deposit_amount
		end
	end

	def withdrawal(person, withdrawal_amount)
		if withdrawal_amount > accounts[person.name]
			#puts "Insufficient funds."
		else	
			accounts[person.name] -= withdrawal_amount
			person.amount += withdrawal_amount
		end	
	end

	def transfer(person, bank_name, transfer_amount)
		if bank_name.accounts[person.name] == nil
			#puts "#{person.name} does not have an account with #{bank_name}"
		elsif transfer_amount > accounts[person.name]
			#puts "Insufficient funds."	
		else
			accounts[person.name] -= transfer_amount
			bank_name.accounts[person.name] += transfer_amount
		end
	end

  def total_cash
  	@accounts.values.reduce(:+)
  end
  


end