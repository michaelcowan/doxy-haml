require 'nodes/mixins/describable'

module DoxyHaml

  class Compound < Node
    include Describable
    
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
      @classes ||= sort_by_name parse_classes
    end

    def html_link link_name
      link_to link_name, filename
    end

    private

    def parse_classes
      map_xpath %Q{innerclass} do |clazz|
        Class.new clazz['refid'], self
      end
    end

    def sort_by_name objects
      objects.sort_by { |o| o.name }
    end

  end

end