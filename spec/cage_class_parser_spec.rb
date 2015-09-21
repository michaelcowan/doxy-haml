require 'spec_helper'

describe "DoxyHaml Cage Class Parser" do

  before(:all) do
    @expected_public_methods = ["setAnimal", "getAnimal", "setDimensions"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    @cage = class_by_name namespace.classes, "Cage"
  end

  it "should have a name" do
    expect(@cage.name).to eq "Cage"
  end

  it "should have an html name" do
    expect(@cage.html_name).to eq "<a href='classzoo_1_1_cage.html'>Cage</a>"
  end

  it "should have a qualified name" do
    expect(@cage.qualified_name).to eq "zoo::Cage"
  end

  it "should have an html qualified name" do
    expect(@cage.html_qualified_name).to eq "<a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_cage.html'>Cage</a>"
  end

  it "should have a brief" do
    expect(@cage.has_brief?).to be true
    expect(@cage.brief).to eq "Represents a Cage at the zoo."
  end

  it "should have an html brief" do
    expect(@cage.has_brief?).to be true
    expect(@cage.html_brief).to eq "Represents a <a href='classzoo_1_1_cage.html'>Cage</a> at the zoo."
  end

  it "should have a description" do
    expect(@cage.has_description?).to be true
    expect(@cage.description).to eq "The class Cage contains an Animal at the zoo."
  end

  it "should have an html description" do
    expect(@cage.has_description?).to be true
    expect(@cage.html_description).to eq "The class <a href='classzoo_1_1_cage.html'>Cage</a> contains an <a href='classzoo_1_1_animal.html'>Animal</a> at the zoo."
  end

  it "should have an author" do
    expect(@cage.author).to eq "Michael Cowan"
  end

  it "should not be abstract" do
    expect(@cage.abstract?).to be false
  end

  it "should have public method(s)" do
    expect(@cage.has_public_methods?).to be true
    public_method_names = map_node @cage.public_methods do |method| method.name end
    expect(public_method_names).to match_array @expected_public_methods
  end

  it "should not have public static method(s)" do
    expect(@cage.has_public_static_methods?).to be false
  end

end