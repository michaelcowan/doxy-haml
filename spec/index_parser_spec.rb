require 'spec_helper'

describe "DoxyHaml Index Parser" do

  before(:all) do
    @expected_namespaces = ["global", "bob", "bob::robert", "bob::robert::william", "zoo", "zoo::exhibit"]
    @expected_classes = ["Animal", "Cage", "CagePath", "Monkey", "Organism", "Person", "Tent"]
    @classes_beginning_with_c = ["Cage", "CagePath"]
    
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    @index = parser.index
  end

  it "should have namespace(s)" do
    expect(@index.has_namespaces?).to be true
    namespace_names = map_node @index.namespaces do |namespace| namespace.qualified_name end
    expect(namespace_names).to eq @expected_namespaces
  end

  it "should have class(es)" do
    expect(@index.has_classes?).to be true
    class_names = map_node @index.classes do |clazz| clazz.name end
    expect(class_names).to eq @expected_classes
  end

  it "should have grouped classes" do
    class_names_beginning_with_c = map_node @index.grouped_classes['c'] do |clazz| clazz.name end
    expect(class_names_beginning_with_c).to eq @classes_beginning_with_c
  end

end