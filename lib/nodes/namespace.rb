module DoxyHaml

  class Namespace < Compound

    def name
      @name ||= xpath_first_content %Q{compoundname}
    end

    def classes
      @classes ||= map_xpath %Q{innerclass} do |clazz|
        Class.new clazz['refid'], self
      end
    end
    
  end

end