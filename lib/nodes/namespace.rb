module DoxyHaml

  class Namespace < Compound

    def name
      @name ||= xpath_first_content %Q{compoundname}
    end
    
  end

end