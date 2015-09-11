module DoxyHaml

  class Enum < Member

    def public_values
      @public_values ||= map_xpath %Q{enumvalue[@prot="public"]} do |value|
        Value.new value['id'], self, value
      end
    end

  end

end