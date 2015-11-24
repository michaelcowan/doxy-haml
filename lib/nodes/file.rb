module DoxyHaml

  class File < Compound

    def html_source
      lines = []
      program_listing = xpath_first("programlisting")
      xpath(program_listing, "codeline").each do |codeline|
        lines << doxygen_markup(codeline)
      end
      return lines
    end

    def source
      lines = []
      program_listing = xpath_first("programlisting")
      xpath(program_listing, "codeline").each do |codeline|
        lines << doxygen_markup(codeline, false)
      end
      return lines
    end

  end
  
end