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
      qualify self, false
    end

    def html_qualified_name
      html_qualify self, false
    end

    def html_qualified_name_except_self
      html_qualify_except_self self, false
    end

  end

end