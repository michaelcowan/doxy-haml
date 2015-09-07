module DoxyHaml

  class Node
    include HtmlUtilities

    attr_reader :id

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

    def xpath_first xpath
      @xml.xpath(xpath).first
    end

    def xpath_first_param xpath, param
      xpath_first(xpath)[param]
    end

    def xpath_first_content xpath
      xpath_first(xpath).content
    end

    def content
      @xml.content
    end

  end

end