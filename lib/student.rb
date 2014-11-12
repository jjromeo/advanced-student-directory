class Student 
	attr_accessor :name, :cohort, :hobby

	def initialize(details = {})
        if details.class == String
            details = eval details
        end
        @name = details[:name]
        details.each {|key, value| instance_variable_set("@#{key.to_s}", details[key.to_sym])}
	end

	def method_missing(method, string)
		if method_has_add_ = (method.to_s.slice(0..3) == "add_")
			instance_variable_set("@#{method.to_s.slice(4..-1)}", string)
			self.class.send(:attr_accessor, method.to_s.slice(4..-1))
		else super
		end
	end

end
