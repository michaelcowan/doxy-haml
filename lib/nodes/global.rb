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
      @classes ||= (map_xpath %Q{compound[@kind='class' or @kind='struct']} do |clazz|
        unless clazz.child.content.include? "::"
          Class.new clazz['refid'], self
        end
      end).compact
    end

    def public_methods
      @public_methods ||= scrape_public_methods_from_files
    end

    private

    def scrape_public_methods_from_files
      result = []
      parent.files.each do |file|
        result.concat file.public_methods if file.has_public_methods?
      end
      return result
    end
    
  end

end