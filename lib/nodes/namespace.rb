module DoxyHaml

  class Namespace < Compound

    def has_namespaces?
      not xpath_empty? %Q{innernamespace}
    end

    def namespaces
      @namespaces ||= sort_by_name parse_namespaces
    end

    private

    def parse_namespaces
      map_xpath %Q{innernamespace} do |namespace|
        Namespace.new namespace['refid'], self
      end
    end
    
  end

end