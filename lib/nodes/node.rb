require 'nokogiri'
require 'html_utilities'

module DoxyHaml

  class Node
    include HtmlUtilities

    attr_reader :id
    attr_reader :parent

    def initialize id, parent, xml = nil
      @parent, @id, @xml = parent, id, xml
    end

    def name
      raise "All nodes must declare a name method"
    end

    def has_compound_parent?
      parent != nil and parent.is_a? DoxyHaml::Compound
    end

    def compound_parent
      return parent if has_compound_parent?
    end

    private

    def map_xpath x
      map_xpath_with_index x do |node, index|
        yield node
      end
    end

    def map_xpath_with_index x
      list = []
      index = 0;
      @xml.xpath(x).each do |node|
        list << (yield node, index)
        index += 1
      end
      list
    end

    def xpath xml=@xml, path
      xml.xpath(path)
    end

    def xpath_first xml=@xml, xpath
      xpath(xml, xpath).first
    end

    def xpath_first_param xml=@xml, xpath, param
      xpath_first(xml, xpath)[param]
    end

    def xpath_first_content xml=@xml, xpath
      xpath_first(xml, xpath).content
    end

    def xpath_empty? xml=@xml, xpath
      xpath(xml, xpath).empty? or xpath_first_content(xml, xpath).empty?
    end

    def content
      @xml.content
    end

    def xpath_param param
      @xml[param]
    end

    def parse_xml
      File.open id_xml_filepath do |xml_file|
        @xml = Nokogiri::XML xml_file
      end
    end

    def id_xml_filepath
      File.join Parser.xml_folder, "#{@id}.xml"
    end

  end

end