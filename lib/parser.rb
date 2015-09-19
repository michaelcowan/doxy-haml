require 'nokogiri'

require_relative 'html_utilities'
require_relative 'nodes/node'
require_relative 'nodes/entity'
require_relative 'nodes/member'
require_relative 'nodes/compound'
require_relative 'nodes/value'
require_relative 'nodes/definition'
require_relative 'nodes/namespace'

%w(nodes).each do |r|
  Dir[File.join(File.dirname(__FILE__), r, "*.rb")].each {|f| require f}
end

module DoxyHaml

  class Parser

    attr_reader :index

    def initialize xml_folder
      @@xml_folder = xml_folder
      @index = Index.new
    end

    def self.xml_folder
      @@xml_folder
    end
  end

end