require 'spec_helper'

describe "DoxyHaml Monkey Class Parser" do

  before(:all) do
    @expected_public_functions = ["canSee", "feed", "getNumberOfLegs"]
    @expected_public_static_functions = ["numberOfMonkeys"]
    @expected_public_super_classes = ["Animal"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    @monkey = class_by_name namespace.classes, "Monkey"
  end

  it "should have a name" do
    expect(@monkey.name).to eq "Monkey"
  end

  it "should have an html name" do
    expect(@monkey.html_name).to eq "<a href='classzoo_1_1_monkey.html'>Monkey</a>"
  end

  it "should have a fully qualified name" do
    expect(@monkey.fully_qualified_name).to eq "zoo::Monkey"
  end

  it "should have an html fully qualified name" do
    expect(@monkey.html_fully_qualified_name).to eq "<a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_monkey.html'>Monkey</a>"
  end

  it "should have a qualified name" do
    expect(@monkey.qualified_name).to eq "zoo::Monkey"
  end

  it "should have an html qualified name" do
    expect(@monkey.html_qualified_name).to eq "<a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_monkey.html'>Monkey</a>"
  end

  it "should have a brief" do
    expect(@monkey.has_brief?).to be true
    expect(@monkey.brief).to eq "Represents a Monkey in the zoo."
  end

  it "should have an html brief" do
    expect(@monkey.has_brief?).to be true
    expect(@monkey.html_brief).to eq "Represents a <a href='classzoo_1_1_monkey.html'>Monkey</a> in the zoo."
  end

  it "should have a description" do
    expect(@monkey.has_description?).to be true
    expect(@monkey.description).to eq "The class Monkey extends Animal with specifics about monkeys in the zoo."
  end

  it "should have an html description" do
    expect(@monkey.has_description?).to be true
    expect(@monkey.html_description).to eq "The class <a href='classzoo_1_1_monkey.html'>Monkey</a> extends <a href='classzoo_1_1_animal.html'>Animal</a> with specifics about monkeys in the zoo."
  end

  it "should have an author" do
    expect(@monkey.author).to eq "Michael Cowan"
  end

  it "should not be abstract" do
    expect(@monkey.abstract?).to be false
  end

  it "should have public function(s)" do
    expect(@monkey.has_public_functions?).to be true
    public_function_names = map_node @monkey.public_functions do |function| function.name end
    expect(public_function_names).to eq @expected_public_functions
  end

  it "should have public static function(s)" do
    expect(@monkey.has_public_static_functions?).to be true
    public_static_function_names = map_node @monkey.public_static_functions do |function| function.name end
    expect(public_static_function_names).to match_array @expected_public_static_functions
  end

  it "should have public super class(es)" do
    expect(@monkey.has_public_super_classes?).to be true
    public_super_classes_names = map_node @monkey.public_super_classes do |clazz| clazz.name end
    expect(public_super_classes_names).to eq @expected_public_super_classes
  end

  it "should not have public derived class(es)" do
    expect(@monkey.has_public_derived_classes?).to be false
  end

end