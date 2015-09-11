module DoxyHaml

  class Class < Compound

    def name
      remove_namespace qualified_name
    end

    def qualified_name
      @qualified_name ||= xpath_first_content %Q{/doxygen/compounddef/compoundname}
    end

    def html_qualified_name
      html_qualify self
    end

    def brief
      @brief ||= (xpath_first_content %Q{/doxygen/compounddef/briefdescription/para}).squish
    end

    def html_brief
      @html_brief ||= link_to_refs xpath_first %Q{/doxygen/compounddef/briefdescription/para}
    end

    def description
      @description ||= (xpath_first_content %Q{/doxygen/compounddef/detaileddescription/para}).squish
    end

    def html_description
      @html_description ||= link_to_refs xpath_first %Q{/doxygen/compounddef/detaileddescription/para}
    end

    def author
      @author ||= (xpath_first_content %Q{/doxygen/compounddef/detaileddescription/para/simplesect[@kind="author"]}).squish
    end
    
    def abstract?
      @abstract ||= (xpath_first_param %Q{/doxygen/compounddef}, 'abstract') == 'yes'
    end

    def public_methods
      @public_methods ||= map_xpath memberdef_xpath("public-func", "function", "no") do |method|
        Method.new method['id'], self, method
      end
    end

    def has_public_methods?
      not public_methods.empty?
    end

    def public_static_methods
      @public_static_methods ||= map_xpath memberdef_xpath("public-static-func", "function", "yes") do |method|
        Method.new method['id'], self, method
      end
    end

    def has_public_static_methods?
      not public_static_methods.empty?
    end

    def public_enums
      @public_enums ||= map_xpath memberdef_xpath("public-type", "enum", "no") do |enum|
        Enum.new enum['id'], self, enum
      end
    end

    def has_public_enums?
      not public_enums.empty?
    end

    private

    def memberdef_xpath access_level, kind, static
      "/doxygen/compounddef/sectiondef[@kind='#{access_level}']/memberdef[@kind='#{kind}' and @static='#{static}']"
    end

  end

end