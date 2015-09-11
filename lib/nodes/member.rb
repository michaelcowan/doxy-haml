module DoxyHaml

  class Member < Value

    def qualified_name
      qualify self
    end

    def html_qualified_name
      html_qualify self
    end

  end

end