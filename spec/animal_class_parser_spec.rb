require 'spec_helper'

describe "DoxyHaml Animal Class Parser" do

  before(:all) do
    @expected_public_methods = ["Animal", "canFly", "getNumberOfLegs", "feed"]
    @expected_public_static_methods = ["numberOfMonkeys"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    classes = parser.index.namespaces.first.classes
    @animal = class_by_name classes, "Animal"
  end

  it "should have a name" do
    expect(@animal.name).to eq "Animal"
    expect(@animal.html_name).to eq "<a href='classzoo_1_1_animal.html'>Animal</a>"
  end

  it "should have a qualified name" do
    expect(@animal.qualified_name).to eq "zoo::Animal"
    expect(@animal.html_qualified_name).to eq "<a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_animal.html'>Animal</a>"
  end

  it "should have a brief" do
    expect(@animal.brief).to eq "Represents an Animal in the zoo."
    expect(@animal.html_brief).to eq "Represents an <a href='classzoo_1_1_animal.html'>Animal</a> in the zoo."
  end

  it "should have a description" do
    expect(@animal.description).to eq "The class Animal contains information and functions related to all animals in the zoo."
    expect(@animal.html_description).to eq "The class <a href='classzoo_1_1_animal.html'>Animal</a> contains information and functions related to all animals in the zoo."
  end

  it "should have an author" do
    expect(@animal.author).to eq "Michael Cowan"
  end

  it "should be abstract" do
    expect(@animal.abstract?).to be true
  end

  it "should have public method(s)" do
    expect(@animal.has_public_methods?).to be true
    public_method_names = map_node @animal.public_methods do |method| method.name end
    expect(public_method_names).to match_array @expected_public_methods
  end

  it "should not have public static method(s)" do
    expect(@animal.has_public_static_methods?).to be false
  end

end