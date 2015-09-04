module DoxyHaml

  class Namespace < Compound

    def name
      @name ||= xpath_first_content %Q{/doxygen/compounddef/compoundname}
    end

    def classes
      @classes ||= map_xpath %Q{/doxygen/compounddef/innerclass} do |clazz|
        Class.new clazz['refid'], self
      end
    end
    
  end

end