class Student 
	attr_accessor :name, :cohort, :hobby, :statement

	def initialize(details = {})
		@name = details[:name]
		@cohort = details[:cohort]
		@hobby = details[:hobby]
	end

	def method_missing(method, string)
		if method_has_add_ = (method.to_s.slice(0..3) == "add_")
			instance_variable_set("@#{method.to_s.slice(4..-1)}", string)
			self.class.send(:attr_accessor, method.to_s.slice(4..-1))
		else super
		end
	end

end