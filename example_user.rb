class User
	attr_accessor :name, :email

	# The initialize method is called when User.new is executed
	# This initialize method takes the "attributes" argument
	# Here we set the attributes variable to a default value = to empty hash so we can difine a user with no name or email address
	def initialize(attributes = {})

		# Instance variables (always starts with a "@")
		# If variables are not defined they are "nil" 
		@name  = attributes[:name]
		@email = attributes[:email]
	end

	# This method uses the values assigned to @name & @email variables to build up a formatted version of the user's email address using string interpolation
	# Because @name & @email are instance variables, they are automatically available in the "formatted_email" method.
	def formatted_email
		"#{@name} <#{@email}>" 	
	end 
end