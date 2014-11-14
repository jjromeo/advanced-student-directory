class Student 
	attr_accessor :name, :cohort, :hobby

	def initialize(details = {})
        @name = details[:name] || "no name given"
        details.each {|key, value|
            if detail = details[key]
                instance_variable_set("@#{key.to_s}", detail) 
                self.class.send(:attr_accessor, key)
            end
        }
	end

	def method_missing(method, string = nil )
        method_string = method.to_s ; method_sliced = method_string.slice(4..-1)
		if method_has_add_ = (method_string.to_s.slice(0..3) == "add_")
			instance_variable_set("@#{method_sliced}", string)
			self.class.send(:attr_accessor, method_sliced)
		else super
		end
	end

end
