require 'spec_helper'
describe Directory do 

include FakeFS::SpecHelpers

let(:jerome) {double :student, name: "Jerome"}
let(:directory) {Directory.new}

	it "should be able to create students" do 
		expect(directory.students.count).to eq 0
		directory.add_student
		expect(directory.students.count).to eq 1
	end

	it "should be able to display info about each student" do 
		directory.add_student(name: "Jerome")
		jerome = directory.find_student("Jerome")
		jerome.add_cohort("August")
		jerome.add_hobby("basketball")
		directory.add_student(name: "Peter")
		peter = directory.find_student("Peter")
		peter.add_cohort("September")
		peter.add_hobby("tennis")
		expect(directory.summarise_students).to eq "Student number 1 is Jerome, they are on the August Cohort and their hobby is basketball. Student number 2 is Peter, they are on the September Cohort and their hobby is tennis."
	end

	
	context "using the file system" do
		
		before {
			directory.add_student(name: "Jerome", cohort: "August", hobby: "basketball", dob: "12/03/1990", cob: "England")
			directory.add_student(name: "Peter", cohort: "September", hobby: "tennis", dob: "07/05/1979", cob: "Madagascar")
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
			directory2 = Directory.new
			directory2.load_students
			expect(directory2.students.first.name).to eq "Jerome"
			expect(directory2.students.first.dob).to eq "12/03/1990"
		end
	end
end