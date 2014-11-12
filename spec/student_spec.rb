require 'spec_helper'
describe Student do 

	it "Can initialize with attributes" do
		jerome = Student.new(name: "Jerome", cohort: "August", hobby: "basketball")
		expect(jerome.name).to eq "Jerome"
		expect(jerome.cohort).to eq "August"
		expect(jerome.hobby).to eq "basketball"
	end

    it "can initialize with any random attributes" do 
        jamie = Student.new(name: "Jamie", star_sign: "Pisces", dream: "to be a millionaire")
        expect(jamie.name).to eq "Jamie"
        expect(jamie.star_sign).to eq "Pisces"
        expect(jamie.dream).to eq "to be a millionaire"
    end

	it "can change attributes" do
		jerome = Student.new(name: "Jerome", cohort: "August", hobby: "basketball")
		jerome.name = "Peter"
		expect(jerome.name).to eq "Peter"
	end

	it "can dynamically add attributes" do 
		jerome = Student.new
		jerome.add_dob("12/03/90")
		expect(jerome.dob).to eq "12/03/90"
	end


end
