class Directory
    attr_accessor :students, :parameters

    def initialize
        @students = []
        @parameters = []
        set_name
    end

    def add_student(details = {})
        create_student(details)
        update_student(details)
    end
        


    def method_missing(method)
        method_string = method.to_s ; 
        param, prefix = method_string.slice(4..-1).to_sym, method_string.slice(0..3)
        decide_method(prefix, param)
    end


    def summarise_students
        @statement_array = []                
        students.each_with_index do |student, index|
            create_statements(student)
            compact_statements
        end
        @statements
    end

    def save_students
        file = File.open("students.csv", "w")
        students.each do |student|
            map_student_data(student)
            file.puts(@csv_line)
        end
        file.close
    end

    def load_students
        file = File.open("students.csv", "r")
        file.readlines.each do |line|
            format_students(line)
            add_student(@injection)
            end 
        file.close
    end

    def find_student(name)
        students.find {|student| student.name == name}
    end
    
    private

    def create_student(student_params)
        @new_student = Student.new(student_params)
        student_params.each {|key, value| parameters << key unless parameters.include?(key)}
        students << @new_student 
    end

    def update_student(details)
        @student = find_student(@new_student.name)
        add_param_to_student(details)
    end

    def add_param_to_student(details)
        parameters.each {|parameter|
            detail = details[parameter.to_sym]
            @student.send("add_#{parameter}", detail) if detail
        }
    end

    def map_student_data(student)
            student_data = parameters.map { |param| param_s = param.to_sym; {param_s => student.send(param_s)} }
            @csv_line = student_data.join(",")
    end

    def format_students(line)
        loaded_students = line.chomp.split(',')
        loaded_students.inject({}) do |accu, student|
            student.class == String ? @injection = accu.merge(eval student) : @injection = accu.merge(student)
        end
    end

    def create_statements(student)
            parameters.each do |param|
                @statement_array << {param => student.send(param)} 
            end
            @statement_array << "\n"
    end

    def compact_statements
            @statements = @statement_array.inject("") {|accu, pair|
                if pair.respond_to?(:keys)
                    accu + "#{pair.keys.first.capitalize.to_s.gsub("_", " ")}: #{pair.values.first.to_s} \n" 
                else
                    accu + pair
                end
            }
    end

    def decide_method(get_or_set, param)
        if method_has_get = (get_or_set == "get_")
            puts "please enter the student's #{param}"
            gets.chomp
        elsif method_has_set = (get_or_set == "set_")
            parameters << param
        else super
        end
    end

    

end
