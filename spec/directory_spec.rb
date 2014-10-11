require 'spec_helper'
describe Directory do 

let(:jerome) {double :student, name: "Jerome"}
let(:directory) {Directory.new}

	it "should be able to create students" do 
		expect(directory.students.count).to eq 0
		directory.add_student
		expect(directory.students.count).to eq 1
	end

	it "should be able to display info about each student" do 
		directory.add_student(name: "Jerome", cohort: "August", hobby: "basketball")
		directory.add_student(name: "Peter", cohort: "September", hobby: "tennis")
		expect(directory.summarise_students).to eq "Student number 1 is Jerome, they are on the August Cohort and their hobby is basketball. Student number 2 is Peter, they are on the September Cohort and their hobby is tennis."
	end


end