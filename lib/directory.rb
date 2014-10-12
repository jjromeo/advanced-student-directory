class Directory
	attr_accessor :students

	def initialize
		@students = []
	end

	def add_student(details = {})
		@name = details[:name]
		# @cohort = details[:cohort]
		# @hobby = details[:hobby]
		students << Student.new(name: @name)
		student = find_student(@name)
		student.add_cohort(details[:cohort])
		student.add_hobby(details[:hobby])
		student.add_dob(details[:dob])
		student.add_cob(details[:cob])
	end

	def find_student(name)
		students.find {|student| student.name == name}
	end

	def get_name
		puts "please enter the student's name"
		gets.chomp
	end

	def get_cohort
		puts "please enter the student's cohort"
		gets.chomp
	end

	def get_hobby
		puts "please enter the student's hobby"
		gets.chomp
	end

	def get_dob
		puts "please enter the student's dob"
		gets.chomp
	end

	def get_cob
		puts "please enter the student's cob"
		gets.chomp
	end

	def summarise_students
		statements = students.each_with_index.map {|student, i|
			"Student number #{i + 1} " + "is #{student.name}, they are on the #{student.cohort} Cohort and their hobby is #{student.hobby}. Additionally they were born on the #{student.dob} in #{student.cob}."
		}
		statements.inject {|memo, student|
			memo + " " + student
		}
	end

	def save_students
		file = File.open("students.csv", "w")
		students.each do |student|
			student_data = [student.name, student.cohort, student.hobby, student.dob, student.cob]
			csv_line = student_data.join(",")
			file.puts(csv_line)
		end
		file.close
	end

	def load_students
		file = File.open("students.csv", "r")
		file.readlines.each do |line|
			loaded_students = line.chomp.split(',')
			add_student(name: loaded_students[0], cohort: loaded_students[1], hobby: loaded_students[2], dob: loaded_students[3], cob: loaded_students[4])
		end
		file.close

	end

end