require './lib/directory.rb'
require './lib/student.rb'

@directory = Directory.new

def interactive_menu
	loop do
		if @directory.parameters.empty?
			set_parameters
		end
		print_menu
		process(gets.chomp)
	end
end


def print_menu
	puts "1. Enter a students details"
	puts "2. Show the students"
	puts "3. Save the list to students.csv"
	puts "4. Load the list from students.csv"
	puts "9. Exit" #9 because we'll be adding more items
end

def set_parameters
	loop do
		puts "Please enter the parameters you would like to take for each student, press enter twice when finished"
		parameter = gets.chomp
		unless parameter == ""
			@directory.send("set_#{parameter}")
		end
	break if parameter == ""
	end
end

def process(selection)
	case selection
	  when "1"
	  	@directory.add_student(name: @directory.get_name, cohort: @directory.get_cohort, hobby: @directory.get_hobby, dob: @directory.get_dob, cob: @directory.get_cob)
	  when "2"
	  	puts @directory.summarise_students
	  when "3"
	  	@directory.save_students
	  when "4"
		@directory.load_students
	  when "9"
		exit # this will cause the program to terminate
	  else
	  	puts "I don't know what you meant, try again"
	  end
end

def students_with_parameters
	@directory.parameters.inject do |accumulator, parameter|
		if parameter == @directory.parameters.last
			@directory.parameters[parameter.to_sym] = @directory.send("get_#{parameter}")
		else
			@directory.parameters[parameter.to_sym] = @directory.send("get_#{parameter}") + ","
		end
	end
end

interactive_menu