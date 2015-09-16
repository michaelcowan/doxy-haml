module DoxyHaml

  class Compound < Entity
    
    def initialize id, parent
      super id, parent
      parse_xml
      @xml = @xml.xpath(%Q{/doxygen/compounddef}).first unless @xml.xpath(%Q{/doxygen/compounddef}).empty?
    end

    def name
      remove_namespace qualified_name
    end

    def html_name
      link_to_self name
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

    def has_namespaces?
      not xpath_empty? %Q{innernamespace}
    end

    def namespaces
      @namespaces ||= map_xpath %Q{innernamespace} do |namespace|
        Namespace.new namespace['refid'], self
      end
    end

    private

    def link_to_self link_name
      link_to link_name, filename
    end

  end

end