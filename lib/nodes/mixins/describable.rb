module DoxyHaml

  module Describable

    def has_brief?
      not xpath_blank? %Q{briefdescription/para/text()}
    end

    def brief
      @brief ||= parse_doxygen_description xpath_first %Q{briefdescription}
    end

    def html_brief
      @html_brief ||= parse_doxygen_description_to_html xpath_first %Q{briefdescription}
    end

    def is_description_blank?
      xpath_blank? %Q{detaileddescription/para/text()}
    end

    def has_description?
      not is_description_blank? or has_brief?
    end

    def description
      return brief if is_description_blank?
      @description ||= parse_doxygen_description xpath_first %Q{detaileddescription}
    end

    def html_description
      return html_brief if is_description_blank?
      @html_description ||= parse_doxygen_description_to_html xpath_first %Q{detaileddescription}
    end

    def has_author?
      not xpath_empty? %Q{detaileddescription/para/simplesect[@kind='author']}
    end

    def author
      @author ||= (xpath_first_content %Q{detaileddescription/para/simplesect[@kind='author']}).squish
    end

  end

end