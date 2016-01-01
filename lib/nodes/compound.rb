require 'nodes/mixins/describable'
require 'nodes/mixins/qualifiable'

module DoxyHaml

  class Compound < Node
    include Describable
    include Qualifiable
    
    def initialize id, parent, xml=nil
      super id, parent, xml
      @xml = @xml.xpath(%Q{/doxygen/compounddef}).first if xml.nil?
    end

    def name
      remove_namespace fully_qualified_name
    end

    def html_name
      html_link name
    end

    def fully_qualified_name
      @fully_qualified_name ||= xpath_first_content %Q{compoundname}
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

    def has_public_functions?
      not public_functions.empty?
    end

    def public_functions
      @public_functions ||= sort_functions parse_public_functions
    end

    def has_public_static_functions?
      not public_static_functions.empty?
    end

    def public_static_functions
      @public_static_functions ||= sort_functions parse_public_static_functions
    end

    def has_public_enums?
      not public_enums.empty?
    end

    def public_enums
      @public_enums ||= sort_by_name parse_public_enums
    end

    def has_public_variables?
      not public_variables.empty?
    end

    def public_variables
      @public_variables ||= sort_by_name parse_public_variables
    end

    def has_public_static_variables?
      not public_static_variables.empty?
    end

    def public_static_variables
      @public_static_variables ||= sort_by_name parse_public_static_variables
    end

    private

    def sort_functions functions
      functions.sort_by { |m| [alpha_name(m.name), m.parameters.count] }.partition { |m| m.destructor? }.flatten.partition { |m| m.constructor? }.flatten
    end

    def xpath_or_attributes kind
      kind = kind.join "' or '" if kind.is_a? Array
      return kind
    end

    def memberdef_xpath access_level, kind, static
      "sectiondef[@kind='#{xpath_or_attributes(access_level)}']/memberdef[@kind='#{kind}' and @static='#{static}']"
    end

    def parse_classes
      map_xpath %Q{innerclass} do |clazz|
        find_node_by_id(clazz['refid']) || Class.new(clazz['refid'], self)
      end
    end

    def parse_public_functions
      map_xpath memberdef_xpath(["public-func", "func"], "function", "no") do |function|
        find_node_by_id(function['id']) || Function.new(function['id'], self, function)
      end
    end

    def parse_public_static_functions
      map_xpath memberdef_xpath(["public-static-func", "func"], "function", "yes") do |function|
        find_node_by_id(function['id']) || Function.new(function['id'], self, function)
      end
    end

    def parse_public_enums
      map_xpath memberdef_xpath(["public-type", "enum"], "enum", "no") do |enum|
        find_node_by_id(enum['id']) || Enum.new(enum['id'], self, enum)
      end
    end

    def parse_public_variables
      map_xpath memberdef_xpath(["public-attrib", "var"], "variable", "no") do |variable|
        find_node_by_id(variable['id']) || Variable.new(variable['id'], self, variable)
      end
    end

    def parse_public_static_variables
      map_xpath memberdef_xpath(["public-static-attrib", "var"], "variable", "yes") do |variable|
        find_node_by_id(variable['id']) || Variable.new(variable['id'], self, variable)
      end
    end

  end

end