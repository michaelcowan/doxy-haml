module DoxyHaml

  class Definition < Member

    def qualified_name
      qualify self
    end

    def html_qualified_name
      html_qualify self
    end

  end

end