class Directory
	attr_accessor :students, :parameters

	def initialize
		@students = []
		@parameters = []
        set_name
	end

	def add_student(details = {})
        student_params = [details].each {|detail| detail}.inject({}) {|accu, elem| accu.merge(elem)}.inspect
        new_student = Student.new(student_params)
		students << new_student 
		@student = find_student(new_student.name)
		parameters.each {|parameter|
			@student.send("add_#{parameter}", details[parameter.to_sym])
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
			parameters << method.to_s.slice(4..-1)
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
            student_data = parameters.map { |param| {param.to_sym => student.send(param.to_sym)} }
			csv_line = student_data.join(",")
			file.puts(csv_line)
		end
		file.close
	end

	def load_students
		file = File.open("students.csv", "r")
		file.readlines.each do |line|
			loaded_students = line.chomp.split(',')
            loaded_students.inject({}) do |accu, student|
                student.class == String ? @injection = accu.merge(eval student) : @injection = accu.merge(student)
            end 
            add_student(@injection)
		end
		file.close

	end

end
