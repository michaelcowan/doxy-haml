module DoxyHaml

  class Compound < Entity
    
    def initialize id, parent, xml=nil
      super id, parent, xml
      if xml.nil?
        parse_xml
        @xml = @xml.xpath(%Q{/doxygen/compounddef}).first
      end
    end

    def name
      remove_namespace qualified_name
    end

    def html_name
      html_link name
    end

    def qualified_name
      @qualified_name ||= xpath_first_content %Q{compoundname}
    end

    def html_qualified_name
      html_qualify self
    end

    def filename
      "#{@id}.html"
    end

    def has_classes?
      not xpath_empty? %Q{innerclass}
    end

    def classes
      @classes ||= map_xpath %Q{innerclass} do |clazz|
        Class.new clazz['refid'], self
      end
    end

    def html_link link_name
      link_to link_name, filename
    end

  end

end