module DoxyHaml

  module HtmlUtilities

    def link_to *args, &block
      if block_given?
        url = args[0]
        # TODO
      else
        name, url = args[0], args[1]
        "<a href='#{url}'>#{name}</a>"
      end
    end

    def remove_namespace name
      name.split("::").last
    end

  end

end