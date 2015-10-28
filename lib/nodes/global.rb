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
      @public_methods ||= sort_methods scrape_public_methods_from_files
    end

    def public_static_methods
      @public_static_methods ||= sort_methods scrape_public_static_methods_from_files
    end

    private

    def patch_nodes_ids! nodes
      nodes.each do |method|
        method.id = "global_#{id_to_a_id(method.id)}"
      end
    end

    def scrape_public_methods_from_files
      result = []
      parent.files.each do |file|
        result.concat file.public_methods if file.has_public_methods?
      end
      patch_nodes_ids! result
    end

    def scrape_public_static_methods_from_files
      result = []
      parent.files.each do |file|
        result.concat file.public_static_methods if file.has_public_static_methods?
      end
      patch_nodes_ids! result
    end
    
  end

end