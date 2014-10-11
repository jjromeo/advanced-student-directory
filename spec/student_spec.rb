require 'spec_helper'
describe Student do 

	it "Can initialize with attributes" do
		jerome = Student.new(name: "Jerome", cohort: "August", hobby: "basketball")
		expect(jerome.name).to eq "Jerome"
		expect(jerome.cohort).to eq "August"
		expect(jerome.hobby).to eq "basketball"
	end

	it "can create a statement about itself" do 
		jerome = Student.new(name: "Jerome", cohort: "August", hobby: "basketball")
		expect(jerome.statement).to eq "is Jerome, they are on the August Cohort and their hobby is basketball."
	end

	it "can change attributes" do
		jerome = Student.new(name: "Jerome", cohort: "August", hobby: "basketball")
		jerome.name = "Peter"
		expect(jerome.name).to eq "Peter"
	end



end