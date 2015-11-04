module DoxyHaml

  class Enum < Definition

    def public_values
      global = !has_qualifying_parent?
      @public_values ||= map_xpath %Q{enumvalue[@prot="public"]} do |value|
        id = global ? replace_file_in_id(value['id'], "global") : value['id']
        Value.new id, self, value
      end
    end

  end

end