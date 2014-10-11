class Student 
	attr_accessor :name, :cohort, :hobby

	def initialize(details = {})
		@name = details[:name]
		@cohort = details[:cohort]
		@hobby = details[:hobby]
	end

end