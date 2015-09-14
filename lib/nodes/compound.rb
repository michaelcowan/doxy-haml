module DoxyHaml

  class Compound < Node
    
    def initialize id, parent
      super id, parent
      parse_xml
    end

    def html_name
      link_to_self name
    end

    def filename
      "#{@id}.html"
    end

    def has_brief?
      not xpath_empty? %Q{/doxygen/compounddef/briefdescription/para}
    end

    def brief
      @brief ||= (xpath_first_content %Q{/doxygen/compounddef/briefdescription/para}).squish
    end

    def html_brief
      @html_brief ||= link_to_refs xpath_first %Q{/doxygen/compounddef/briefdescription/para}
    end

    def description
      @description ||= (xpath_first_content %Q{/doxygen/compounddef/detaileddescription/para}).squish
    end

    def html_description
      @html_description ||= link_to_refs xpath_first %Q{/doxygen/compounddef/detaileddescription/para}
    end

    private

    def parse_xml
      File.open id_xml_filepath do |xml_file|
        @xml = Nokogiri::XML xml_file
      end
    end

    def id_xml_filepath
      File.join Parser.xml_folder, "#{@id}.xml"
    end

    def link_to_self link_name
      link_to link_name, filename
    end

  end

end