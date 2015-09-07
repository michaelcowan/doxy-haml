module DoxyHaml

  class Node
    include HtmlUtilities

    def initialize id, parent, xml = nil
      @parent, @id, @xml = parent, id, xml
    end

    def name
      raise "All nodes must declare a name method"
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

  end

end