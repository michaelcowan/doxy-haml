require 'spec_helper'

describe "DoxyHaml Monkey Class Parser" do

  before(:all) do
    @expected_public_methods = ["getNumberOfLegs", "feed"]
    @expected_public_static_methods = ["numberOfMonkeys"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    classes = parser.index.namespaces.first.classes
    @monkey = class_by_name classes, "Monkey"
  end

  it "should have a name" do
    expect(@monkey.name).to eq "Monkey"
    expect(@monkey.html_name).to eq "<a href='classzoo_1_1_monkey.html'>Monkey</a>"
  end

  it "should have a qualified name" do
    expect(@monkey.qualified_name).to eq "zoo::Monkey"
    expect(@monkey.html_qualified_name).to eq "<a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_monkey.html'>Monkey</a>"
  end

  it "should have a brief" do
    expect(@monkey.has_brief?).to be true
    expect(@monkey.brief).to eq "Represents a Monkey in the zoo."
    expect(@monkey.html_brief).to eq "Represents a <a href='classzoo_1_1_monkey.html'>Monkey</a> in the zoo."
  end

  it "should have a description" do
    expect(@monkey.has_description?).to be true
    expect(@monkey.description).to eq "The class Monkey extends Animal with specifics about monkeys in the zoo."
    expect(@monkey.html_description).to eq "The class <a href='classzoo_1_1_monkey.html'>Monkey</a> extends <a href='classzoo_1_1_animal.html'>Animal</a> with specifics about monkeys in the zoo."
  end

  it "should have an author" do
    expect(@monkey.author).to eq "Michael Cowan"
  end

  it "should not be abstract" do
    expect(@monkey.abstract?).to be false
  end

  it "should have public method(s)" do
    expect(@monkey.has_public_methods?).to be true
    public_method_names = map_node @monkey.public_methods do |method| method.name end
    expect(public_method_names).to match_array @expected_public_methods
  end

  it "should have public static method(s)" do
    expect(@monkey.has_public_static_methods?).to be true
    public_static_method_names = map_node @monkey.public_static_methods do |method| method.name end
    expect(public_static_method_names).to match_array @expected_public_static_methods
  end

end