module DoxyHaml

  module Describable

    def has_brief?
      not xpath_empty? %Q{briefdescription/para}
    end

    def brief
      @brief ||= (xpath_first_content %Q{briefdescription/para}).squish
    end

    def html_brief
      @html_brief ||= doxygen_markup_to_html xpath_first %Q{briefdescription/para}
    end

    def has_description?
      not xpath_empty? %Q{detaileddescription/para}
    end

    def description
      @description ||= (xpath_first_content %Q{detaileddescription/para}).squish
    end

    def html_description
      @html_description ||= doxygen_markup_to_html xpath_first %Q{detaileddescription/para}
    end

    def has_author?
      not xpath_empty? %Q{detaileddescription/para/simplesect[@kind='author']}
    end

    def author
      @author ||= (xpath_first_content %Q{detaileddescription/para/simplesect[@kind='author']}).squish
    end

  end

end