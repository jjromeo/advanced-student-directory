class Directory
	attr_accessor :students

	def initialize
		@students = []
	end

	def add_student(details = {})
		@name = details[:name]
		@cohort = details[:cohort]
		@hobby = details[:hobby]
		# get_name
		# get_cohort
		# get_hobby
		students << Student.new(name: @name, cohort: @cohort, hobby: @hobby)
	end

	def get_name
		puts "please enter the student's name"
		@name = gets.chomp
	end

	def get_cohort
		puts "please enter the student's cohort"
		@cohort = gets.chomp
	end

	def get_hobby
		puts "please enter the student's hobby"
		@hobby = gets.chomp
	end

	def summarise_students
		statements = students.each_with_index.map {|student, i|
			"Student number #{i + 1} " + student.statement
		}
		statements.inject {|memo, student|
			memo + " " + student
		}
	end

end