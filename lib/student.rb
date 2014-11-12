class Student 
	attr_accessor :name, :cohort, :hobby

	def initialize(details = {})
        @name = details[:name] || "no name given"
        details.each {|key, value|
            if details[key.to_sym] 
                instance_variable_set("@#{key.to_s}", details[key.to_sym]) 
                self.class.send(:attr_accessor, key.to_sym)
            end
        }
	end

	def method_missing(method, string)
		if method_has_add_ = (method.to_s.slice(0..3) == "add_")
			instance_variable_set("@#{method.to_s.slice(4..-1)}", string)
			self.class.send(:attr_accessor, method.to_s.slice(4..-1))
		else super
		end
	end

end
