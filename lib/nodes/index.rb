module DoxyHaml

  class Index < Node

    def initialize
      super 'index', nil
      @global = Global.new 'global', self, xpath(%Q{doxygenindex})
      create_all_nodes
    end

    def has_namespaces?
      not namespaces.empty?
    end

    def namespaces
      @namespaces ||= (get_namespaces @global).unshift @global
    end

    def has_classes?
      not classes.empty?
    end

    def classes
      @classes ||= sort_by_name(get_classes @global)
    end

    def grouped_classes
      @grouped_classes ||= group_by_name classes
    end

    def methods
      @methods ||= sort_by_name(get_all("public_methods") + get_all("public_static_methods"))
    end

    def grouped_methods
      @grouped_methods ||= group_by_name methods
    end

    def variables
      @variables ||= sort_by_name(get_all "public_variables")
    end

    def grouped_variables
      @grouped_variables ||= group_by_name variables
    end

    def enums
      @enums ||= sort_by_name(get_all "public_enums")
    end

    def files
      @files ||= sort_by_name parse_files
    end

    private

    def create_all_nodes
      namespaces
      classes.each do |clazz|
        clazz.public_methods
        clazz.public_static_methods
        clazz.public_enums
        clazz.public_variables
        clazz.public_static_variables
      end
      files
    end

    def sort_by_name objects
      objects.sort_by { |o| o.name }
    end

    def group_by_name objects
      objects.group_by { |o| o.name[0].downcase }
    end

    def get_namespaces node
      result = []
      if node.has_namespaces?
        (sort_by_name node.namespaces).each do |namespace|
          result << namespace
          result += get_namespaces namespace
        end
      end
      return result
    end

    def get_classes node
      result = []
      if node.has_classes?
        result += node.classes
        node.classes.each do |n|
          result += get_classes n
        end
      end
      if node.respond_to?(:has_namespaces?) && node.has_namespaces?
        node.namespaces.each do |n|
          result += get_classes n
        end
      end
      return result
    end

    def get_all property
      result = []
      namespaces.each do |namespace|
        result += namespace.send(property)
      end
      classes.each do |clazz|
        result += clazz.send(property)
      end
      return result
    end

    def parse_files
      map_xpath %Q{doxygenindex/compound[@kind='file']} do |compound|
        File.new compound['refid'], self
      end
    end

  end

end