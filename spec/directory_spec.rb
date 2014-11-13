require 'spec_helper'
describe Directory do 

include FakeFS::SpecHelpers

let(:jerome) {double :student, name: "Jerome"}
let(:directory) {Directory.new}
let(:directory2) {Directory.new}

	it "should be able to set the parameters it will take" do
		directory.set_cohort
		expect(directory.parameters.include?(:cohort)).to eq true
	end

	it "should be able to create students" do 
		expect(directory.students.count).to eq 0
		directory.add_student
		expect(directory.students.count).to eq 1
	end

    it 'should be able to add students with any parameters' do 
        directory.add_student(name: "james", car:"honda")
        expect(directory.students.first.car).to eq "honda"
    end

    it 'after adding 2 students with different params, 2nd student doesn\'t have param of first' do 
        directory.add_student(name: "james", car:"honda")
        directory.add_student(name: "peter", age: "20")
        james = directory.find_student("james")
        peter = directory.find_student("peter")
        expect(james.instance_variable_defined?(:@car)).to eq true
        expect(peter.instance_variable_defined?(:@car)).to eq false
    end

	it "should be able to display info about each student" do 
		add_student_jerome
		add_student_peter
        expect(directory.summarise_students).to eq "Name: Jerome \nCohort: August \nHobby: basketball \nDob: 12/03/90 \nCob: England \n\nName: Peter \nCohort: September \nHobby: tennis \nDob: 01/01/01 \nCob: France \n\n"
	end
	
	context "using the file system" do
		
		before {
			add_student_jerome
			add_student_peter
			FakeFS.activate!
		}

		after {
			FakeFS.deactivate!
		}

		it "should be able to write student details to a csv file" do 
			directory.save_students
			expect(File.exist?("students.csv")).to eq true
		end

		it "should be able to read student details from a csv file" do
            directory.save_students
			directory2.load_students
			expect(directory2.students.first.name).to eq "Jerome"
			expect(directory2.students.first.dob).to eq "12/03/90"
			expect(directory2.students.first.cob).to eq "England"
		end
	end

    


	def add_student_jerome
		directory.add_student(name: "Jerome",
                              cohort: "August",
                              hobby: "basketball",
                              dob: "12/03/90",
                              cob: "England")
	end

	def add_student_peter
		directory.add_student(name: "Peter",
                              cohort: "September",
                              hobby: "tennis",
                              dob: "01/01/01",
                              cob: "France")
	end
end
