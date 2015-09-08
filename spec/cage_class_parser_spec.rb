require 'spec_helper'

describe "DoxyHaml Cage Class Parser" do

  before(:all) do
    @expected_public_methods = ["setAnimal", "getAnimal", "setDimensions"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    classes = parser.index.namespaces.first.classes
    @cage = class_by_name classes, "Cage"
  end

  it "should have a name" do
    expect(@cage.name).to eq "Cage"
    expect(@cage.html_name).to eq "<a href='classzoo_1_1_cage.html'>Cage</a>"
  end

  it "should have a qualified name" do
    expect(@cage.qualified_name).to eq "zoo::Cage"
    expect(@cage.html_qualified_name).to eq "<a href='classzoo_1_1_cage.html'>zoo::Cage</a>"
  end

  it "should have a brief" do
    expect(@cage.brief).to eq "Represents a Cage at the zoo."
    expect(@cage.html_brief).to eq "Represents a <a href='classzoo_1_1_cage.html'>Cage</a> at the zoo."
  end

  it "should have a description" do
    expect(@cage.description).to eq "The class Cage contains an Animal at the zoo."
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