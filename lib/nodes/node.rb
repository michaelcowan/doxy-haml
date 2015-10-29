require 'nokogiri'
require 'html_utilities'

module DoxyHaml

  class Node
    include HtmlUtilities

    attr_accessor :id
    attr_reader :parent

    def self.clear
      @@nodes = {}
    end

    def initialize id, parent, xml = nil
      @parent, @id, @xml = parent, id, xml
      unless id.nil? or id.empty?
        raise "Node Id '#{id}' should be unique" if @@nodes.has_key? id
        @@nodes[id] = self
        parse_xml if xml.nil?
      end
    end

    def name
      raise "All nodes must declare a name method"
    end

    def has_qualifying_parent?
      not parent.nil? and not parent.is_a? DoxyHaml::File and not parent.is_a? DoxyHaml::Global and parent.is_a? DoxyHaml::Compound
    end

    def qualifying_parent
      return parent if has_qualifying_parent?
    end

    def find_node_by_id id
      @@nodes[id]
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
      xml.xpath(path) unless xml.nil?
    end

    def xpath_first xml=@xml, xpath
      xpath(xml, xpath).first unless xml.nil?
    end

    def xpath_first_param xml=@xml, xpath, param
      xpath_first(xml, xpath)[param] unless xml.nil?
    end

    def xpath_first_content xml=@xml, xpath
      return "" if xpath(xml, xpath).empty?
      xpath_first(xml, xpath).content unless xml.nil?
    end

    def xpath_empty? xml=@xml, xpath
      return true if xml.nil?
      xpath(xml, xpath).empty? or xpath_first_content(xml, xpath).empty?
    end

    def content
      @xml.content
    end

    def xpath_param param
      @xml[param]
    end

    def parse_xml
      ::File.open id_xml_filepath do |xml_file|
        @xml = Nokogiri::XML xml_file
      end
    end

    def id_xml_filepath
      ::File.join Parser.xml_folder, "#{@id}.xml"
    end

  end

end