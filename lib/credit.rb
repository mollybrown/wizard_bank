class Credit

	attr_reader :credit_name,
				:credit_accounts

	def initialize(credit_name)
		@credit_name = credit_name
		@credit_accounts = {}
	end

	def open_credit(person, credit_limit, interest_rate)
		credit_accounts[person.name] = [credit_limit, interest_rate]
	end

	def cc_spend(person, spending_amount)
		if spending_amount > credit_accounts[person][0]
			#puts "Insufficent credit."
		else
			credit_accounts[person][0] -= spending_amount
		end
	end

	def cc_pay_down_balance(person, payment_amount)
		if payment_amount > person.amount
			puts "You don't have that kind of money."
		else
			credit_accounts[person][0] += payment_amount
		end
	end

end