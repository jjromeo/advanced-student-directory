require 'spec_helper'
describe Directory do 

let(:jerome) {double :student, name: "Jerome"}
let(:directory) {Directory.new}

	it "should be able to create students" do 
		expect(directory.students.count).to eq 0
		directory.add_student
		expect(directory.students.count).to eq 1
	end



end