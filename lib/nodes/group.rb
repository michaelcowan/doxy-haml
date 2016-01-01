module DoxyHaml

  class Group < Compound

    def title
      @title ||= xpath_first_content %Q{title}
    end

  end
  
end