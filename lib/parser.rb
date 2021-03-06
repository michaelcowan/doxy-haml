require 'nodes/node'
require 'nodes/member'
require 'nodes/compound'
require 'nodes/value'
require 'nodes/definition'
require 'nodes/namespace'

%w(nodes).each do |r|
  Dir[::File.join(::File.dirname(__FILE__), r, "*.rb")].each {|f| require f}
end

module DoxyHaml

  class Parser

    attr_reader :index

    def initialize xml_folder, src_folder
      @@xml_folder, @@src_folder = xml_folder, src_folder
      Node.clear
      @index = Index.new
    end

    def self.xml_folder
      @@xml_folder
    end

    def self.src_folder
      @@src_folder
    end
  end

end