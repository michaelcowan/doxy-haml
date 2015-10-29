module DoxyHaml

  class Definition < Member

    def fully_qualified_name
      qualify self
    end

    def html_fully_qualified_name
      html_qualify self
    end

    def html_fully_qualified_name_except_self
      html_qualify_except_self self
    end

  end

end