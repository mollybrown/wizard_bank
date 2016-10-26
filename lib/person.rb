class Person

	attr_reader :name

	attr_accessor :amount

	def initialize(name, amount)
		@name = name
		@amount = amount
	end

end