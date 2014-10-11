class Student 
	attr_accessor :name, :cohort, :hobby, :statement

	def initialize(details = {})
		@name = details[:name]
		@cohort = details[:cohort]
		@hobby = details[:hobby]
		@statement = "is #{@name}, they are on the #{@cohort} Cohort and their hobby is #{@hobby}."
	end

end