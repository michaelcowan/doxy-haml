module DoxyHaml

  module Qualifiable
    
    def fully_qualified_name
      qualify self
    end

    def html_fully_qualified_name
      html_qualify self
    end

    def html_fully_qualified_name_except_self
      html_qualify_except_self self
    end

    def qualified_name
      return "#{parent.name}::#{name}" if has_qualifying_parent?
      name
    end

    def html_qualified_name
      return "#{parent.html_name}::#{html_name}" if has_qualifying_parent?
      html_name
    end

    def html_qualified_name_except_self
      return "#{parent.html_name}::#{name}" if has_qualifying_parent?
      name
    end

  end

end