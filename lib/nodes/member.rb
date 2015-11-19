require 'nodes/mixins/describable'
require 'nodes/mixins/qualifiable'

module DoxyHaml

  class Member < Node
    include Describable
    include Qualifiable

    def name
      xpath_first_content %Q{name}
    end

    def html_name
      link_to name, id_to_href_anchor(id)
    end

    def anchor
      id_to_a_id id
    end

    def html_anchor
      anchor_for id_to_a_id(id)
    end

  end

end