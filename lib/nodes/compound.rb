require 'nodes/mixins/describable'

module DoxyHaml

  class Compound < Node
    include Describable
    
    def initialize id, parent, xml=nil
      super id, parent, xml
      @xml = @xml.xpath(%Q{/doxygen/compounddef}).first if xml.nil?
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

    def has_public_methods?
      not public_methods.empty?
    end

    def public_methods
      @public_methods ||= sort_methods parse_public_methods
    end

    def has_public_static_methods?
      not public_static_methods.empty?
    end

    def public_static_methods
      @public_static_methods ||= sort_methods parse_public_static_methods
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

    def sort_methods methods
      methods.sort_by { |m| [m.name, m.parameters.count] }.partition { |m| m.destructor? }.flatten.partition { |m| m.constructor? }.flatten
    end

    def xpath_or_attributes kind
      kind = kind.join "' or '" if kind.is_a? Array
      return kind
    end

    def memberdef_xpath access_level, kind, static
      "sectiondef[@kind='#{xpath_or_attributes(access_level)}']/memberdef[@kind='#{kind}' and @static='#{static}']"
    end

    def parse_public_methods
      map_xpath memberdef_xpath(["public-func", "func"], "function", "no") do |method|
        Method.new method['id'], self, method
      end
    end

    def parse_public_static_methods
      map_xpath memberdef_xpath(["public-static-func", "func"], "function", "yes") do |method|
        Method.new method['id'], self, method
      end
    end

  end

end