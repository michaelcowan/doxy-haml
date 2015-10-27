require 'spec_helper'

describe "DoxyHaml Namespace Parser" do

  before(:all) do
    @expected_public_methods = ["emptyCagePath"]
    @expected_classes = ["Animal", "Cage", "Monkey", "CagePath", "Organism"]
    @expected_namespaces = ["exhibit"]

    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    @namespace = namespace_by_name parser.index.namespaces, "zoo"
  end

  it "should have a name" do
    expect(@namespace.name).to eq "zoo"
  end

  it "should have an html name" do
    expect(@namespace.html_name).to eq "<a href='namespacezoo.html'>zoo</a>"
  end

  it "should have a qualified name" do
    expect(@namespace.qualified_name).to eq "zoo"
  end

  it "should have an html qualified name" do
    expect(@namespace.html_qualified_name).to eq "<a href='namespacezoo.html'>zoo</a>"
  end

  it "should have class(es)" do
    expect(@namespace.has_classes?).to be true
    class_names = map_node @namespace.classes do |clazz| clazz.name end
    expect(class_names).to match_array @expected_classes
  end

  it "should have a brief" do
    expect(@namespace.has_brief?).to be true
    expect(@namespace.brief).to eq "Zoo interfaces and implementations."
  end

  it "should have an html brief" do
    expect(@namespace.has_brief?).to be true
    expect(@namespace.html_brief).to eq "Zoo interfaces and implementations."
  end

  it "should have a description" do
    expect(@namespace.has_description?).to be true
    expect(@namespace.description).to eq "The zoo namespace holds all interfaces and implementations related to the zoo. This includes Animal, Cage and Monkey."
  end

  it "should have an html description" do
    expect(@namespace.has_description?).to be true
    expect(@namespace.html_description).to eq "The zoo namespace holds all interfaces and implementations related to the zoo. This includes <a href='classzoo_1_1_animal.html'>Animal</a>, <a href='classzoo_1_1_cage.html'>Cage</a> and <a href='classzoo_1_1_monkey.html'>Monkey</a>."
  end

  it "should have an author" do
    expect(@namespace.has_author?).to be true
    expect(@namespace.author).to eq "Michael Cowan"
  end

  it "should have namespace(s)" do
    expect(@namespace.has_namespaces?).to be true
    namespace_names = map_node @namespace.namespaces do |namespace| namespace.name end
    expect(namespace_names).to match_array @expected_namespaces
  end

  it "should have public method(s)" do
    expect(@namespace.has_public_methods?).to be true
    public_method_names = map_node @namespace.public_methods do |method| method.name end
    expect(public_method_names).to eq @expected_public_methods
  end

end