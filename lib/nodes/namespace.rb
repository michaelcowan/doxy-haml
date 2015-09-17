module DoxyHaml

  class Namespace < Compound

    def has_classes?
      not xpath_empty? %Q{innerclass}
    end

    def classes
      @classes ||= map_xpath %Q{innerclass} do |clazz|
        Class.new clazz['refid'], self
      end
    end
    
  end

end