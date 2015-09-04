module DoxyHaml

  class Node
    include HtmlUtilities

    def initialize id, parent, xml = nil
      @parent, @id, @xml = parent, id, xml
    end

    def name
      raise "All nodes must declare a name method"
    end

    def html_name
      link_to_self name
    end

    def html_filename
      "#{@id}.html"
    end

    private

    def map_xpath xpath
      list = []
      @xml.xpath(xpath).each do |node|
        list << (yield node)
      end
      list
    end

    def xpath_first_content xpath
      @xml.xpath(xpath).first.content
    end

    def xpath_first_param xpath, param
      @xml.xpath(xpath).first[param]
    end

    def link_to_self link_name
      link_to link_name, html_filename
    end

  end

end