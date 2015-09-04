module DoxyHaml

  class Compound < Node
    
    def initialize id, parent
      super id, parent
      parse_xml
    end

    private

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