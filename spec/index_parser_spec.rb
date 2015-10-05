require 'spec_helper'

describe "DoxyHaml Index Parser" do

  before(:all) do
    @expected_namespaces = ["global", "zoo", "zoo::exhibit"]
    @expected_classes = ["Animal", "Cage", "Monkey", "Person", "Tent", "CagePath"]
    
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    @index = parser.index
  end

  it "should have namespace(s)" do
    namespace_names = map_node @index.namespaces do |namespace| namespace.qualified_name end
    expect(namespace_names).to match_array @expected_namespaces
  end

  it "should have class(es)" do
    class_names = map_node @index.classes do |clazz| clazz.name end
    expect(class_names).to match_array @expected_classes
  end

end