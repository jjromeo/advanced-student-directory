class Directory
	attr_accessor :students

	def initialize
		@students = []
	end

	def add_student
		puts "please enter the student's name"
		name = gets.chomp
		puts "please enter the student's cohort"
		cohort = gets.chomp
		puts "please enter the student's hobby"
		hobby = gets.chomp
		students << Student.new(name: name, cohort: cohort, hobby: hobby)
	end

	def get_name
	end

	def get_cohort
	end

	def get_hobby
	end



end