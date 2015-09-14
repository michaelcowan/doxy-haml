module DoxyHaml

  class Compound < Node
    
    def initialize id, parent
      super id, parent
      parse_xml
      @xml = @xml.xpath(%Q{/doxygen/compounddef}).first unless @xml.xpath(%Q{/doxygen/compounddef}).empty?
    end

    def html_name
      link_to_self name
    end

    def filename
      "#{@id}.html"
    end

    def has_brief?
      not xpath_empty? %Q{briefdescription/para}
    end

    def brief
      @brief ||= (xpath_first_content %Q{briefdescription/para}).squish
    end

    def html_brief
      @html_brief ||= link_to_refs xpath_first %Q{briefdescription/para}
    end

    def has_description?
      not xpath_empty? %Q{detaileddescription/para}
    end

    def description
      @description ||= (xpath_first_content %Q{detaileddescription/para}).squish
    end

    def html_description
      @html_description ||= link_to_refs xpath_first %Q{detaileddescription/para}
    end

    private

    def link_to_self link_name
      link_to link_name, filename
    end

  end

end