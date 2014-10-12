require './lib/directory.rb'
require './lib/student.rb'

@directory = Directory.new

def interactive_menu
	loop do
		print_menu
		process(gets.chomp)
	end
end


def print_menu
	puts "1. Input the students"
	puts "2. Show the students"
	puts "3. Save the list to students.csv"
	puts "4. Load the list from students.csv"
	puts "9. Exit" #9 because we'll be adding more items
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

interactive_menu