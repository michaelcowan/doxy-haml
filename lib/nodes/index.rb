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

    def indexed_namespaces
      @indexed_namespaces ||= index_by_name namespaces
    end

    def has_classes?
      not classes.empty?
    end

    def classes
      @classes ||= sort_by_name(get_classes @global)
    end

    def indexed_classes
      @indexed_classes ||= index_by_name classes
    end

    def functions
      @functions ||= sort_by_name(get_all("public_functions") + get_all("public_static_functions"))
    end

    def indexed_functions
      @indexed_functions ||= index_by_name functions
    end

    def variables
      @variables ||= sort_by_name(get_all "public_variables")
    end

    def indexed_variables
      @indexed_variables ||= index_by_name variables
    end

    def enumerations
      @enumerations ||= sort_by_name(get_all "public_enums")
    end

    def indexed_enumerations
      @indexed_enumerations ||= index_by_name enumerations
    end

    def enumerators
      @enumerators ||= sort_by_name(get_enumerators(enumerations))
    end

    def indexed_enumerators
      @indexed_enumerators ||= index_by_name enumerators
    end

    def files
      @files ||= sort_by_name parse_files
    end

    private

    def create_all_nodes
      namespaces
      classes.each do |clazz|
        clazz.public_functions
        clazz.public_static_functions
        clazz.public_enums
        clazz.public_variables
        clazz.public_static_variables
      end
      files
    end

    def index_by_name objects
      objects.group_by { |o| first_alpha_character(o.name).downcase }
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

    def get_enumerators enumerations
      result = []
      enumerations.each do |e|
        result += e.public_values
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