module DoxyHaml

  class Compound < Entity
    
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

    def classes
      @classes ||= map_xpath %Q{innerclass} do |clazz|
        Class.new clazz['refid'], self
      end
    end

    def namespaces
      @namespaces ||= map_xpath %Q{innernamespace} do |clazz|
        Class.new clazz['refid'], self
      end
    end

    private

    def link_to_self link_name
      link_to link_name, filename
    end

  end

end