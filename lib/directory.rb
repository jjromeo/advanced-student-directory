class Directory
	attr_accessor :students, :parameters

	def initialize
		@students = []
		@parameters = {}
	end

	def add_student(details = {})
		@name = details[:name]
		students << Student.new(name: @name)
		@student = find_student(@name)
		set_cohort
		set_hobby
		set_dob
		set_cob
		parameters.each {|paramkey, paramvalue|
			@student.send("add_#{paramkey}", details[paramkey.to_sym])
		}
	end

	def find_student(name)
		students.find {|student| student.name == name}
	end

	def method_missing(method)
		if method_has_get = (method.to_s.slice(0..3) == "get_")
			puts "please enter the student's #{method.to_s.slice(4..-1)}"
			gets.chomp
		elsif method_has_set = (method.to_s.slice(0..3) == "set_")
			parameters.merge!(method.to_s.slice(4..-1).to_sym => "placeholder" )
		else super
		end
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