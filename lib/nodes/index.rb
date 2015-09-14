module DoxyHaml

  class Index < Node

    def initialize
      super 'index', nil
      parse_xml
    end

    def namespaces
      @namespaces ||= map_xpath %Q{/doxygenindex/compound[@kind='namespace' and @refid!='namespacestd']} do |namespace|
        Namespace.new namespace['refid'], self
      end
    end

    def classes
      @classes ||= map_xpath %Q{/doxygenindex/compound[@kind='class']} do |clazz|
        Class.new clazz['refid'], self
      end
    end

    def global_classes
      @global_classes ||= classes.reject { |c| c.qualified_name.include? "::" }
    end

  end

end