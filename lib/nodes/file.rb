module DoxyHaml

  class File < Compound

    def source
      lines = []
      program_listing = xpath_first("programlisting")
      xpath(program_listing, "codeline").each do |codeline|
        lines << doxygen_markup_to_html(codeline)
      end
      return lines
    end

  end
  
end