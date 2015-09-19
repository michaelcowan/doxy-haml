module DoxyHaml

  class Global < Namespace

    def initialize id, parent, xml
      super id, parent, xml
    end

    def qualified_name
      "global"
    end

    def has_namespaces?
      not namespaces.empty?
    end

    def namespaces
      @namespaces ||= (map_xpath %Q{compound[@kind='namespace' and @refid!='namespacestd']} do |namespace|
        unless namespace.child.content.include? "::"
          Namespace.new namespace['refid'], self
        end
      end).compact
    end

    def has_classes?
      not classes.empty?
    end

    def classes
      @classes ||= (map_xpath %Q{compound[@kind='class']} do |clazz|
        unless clazz.child.content.include? "::"
          Class.new clazz['refid'], self
        end
      end).compact
    end
    
  end

end