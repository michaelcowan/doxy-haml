module DoxyHaml

  class Namespace < Compound

    def has_namespaces?
      not xpath_empty? %Q{innernamespace}
    end

    def namespaces
      @namespaces ||= map_xpath %Q{innernamespace} do |namespace|
        Namespace.new namespace['refid'], self
      end
    end
    
  end

end