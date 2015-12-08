module DoxyHaml

  class Global < Namespace

    def initialize id, parent, xml
      super id, parent, xml
    end

    def fully_qualified_name
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
          find_node_by_id(clazz['refid']) || Class.new(clazz['refid'], self)
        end
      end).compact
    end

    def public_functions
      @public_functions ||= sort_functions scrape_public_functions_from_files
    end

    def public_static_functions
      @public_static_functions ||= sort_functions scrape_public_static_functions_from_files
    end

    def public_enums
      @public_enums ||= sort_by_name scrape_public_enums_from_files
    end

    def public_variables
      @public_variables ||= sort_by_name scrape_public_variables
    end

    def public_static_variables
      @public_static_variables ||= sort_by_name scrape_public_static_variables
    end

    private

    def patch_nodes_ids! nodes
      nodes.each do |function|
        function.id = "global_#{id_to_a_id(function.id)}"
      end
    end

    def scrape_from_files function, condition_function
      result = []
      parent.files.each do |file|
        result.concat file.send(function) if file.send(condition_function)
      end
      patch_nodes_ids! result
    end

    def scrape_public_functions_from_files
      scrape_from_files "public_functions", "has_public_functions?"
    end

    def scrape_public_static_functions_from_files
      scrape_from_files "public_static_functions", "has_public_static_functions?"
    end

    def scrape_public_enums_from_files
      scrape_from_files "public_enums", "has_public_enums?"
    end

    def scrape_public_variables
      scrape_from_files "public_variables", "has_public_variables?"
    end

    def scrape_public_static_variables
      scrape_from_files "public_static_variables", "has_public_static_variables?"
    end
    
  end

end