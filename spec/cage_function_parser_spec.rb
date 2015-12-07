require 'spec_helper'

describe "DoxyHaml Cage Function Parser" do

  before(:all) do
    @expected_parameters = ["width", "height", "hasRoof"]
    @expected_types = ["int", "int", "bool"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    cage = class_by_name namespace.classes, "Cage"
    @setDimensions = function_by_name cage.public_functions, "setDimensions"
  end

  it "should have a name" do
    expect(@setDimensions.name).to eq "setDimensions"
  end

  it "should have an html name" do
    expect(@setDimensions.html_name).to match /<a href='classzoo_1_1_cage.html#\w{34}'>setDimensions<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@setDimensions.fully_qualified_name).to eq "zoo::Cage::setDimensions"
  end

  it "should have an html fully qualified name" do
    expect(@setDimensions.html_fully_qualified_name).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='classzoo_1_1_cage.html'>Cage<\/a>::<a href='classzoo_1_1_cage.html#\w{34}'>setDimensions<\/a>/
  end

  it "should have a qualified name" do
    expect(@setDimensions.qualified_name).to eq "Cage::setDimensions"
  end

  it "should have an html qualified name" do
    expect(@setDimensions.html_qualified_name).to match /<a href='classzoo_1_1_cage.html'>Cage<\/a>::<a href='classzoo_1_1_cage.html#\w{34}'>setDimensions<\/a>/
  end

  it "should have an anchor" do
    expect(@setDimensions.anchor).to match /\w{34}/
  end

  it "should have an html anchor" do
    expect(@setDimensions.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a definition" do
    expect(@setDimensions.definition).to eq "void zoo::Cage::setDimensions(int width, int height, bool hasRoof)"
  end

  it "should have a definition" do
    expect(@setDimensions.html_definition).to eq "void <a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_cage.html'>Cage</a>::setDimensions(int width, int height, bool hasRoof)"
  end

  it "should have a brief" do
    expect(@setDimensions.has_brief?).to be true
    expect(@setDimensions.brief).to eq "Sets the Cage dimensions."
  end

  it "should have an html brief" do
    expect(@setDimensions.has_brief?).to be true
    expect(@setDimensions.html_brief).to eq "<span class='para'>Sets the <a href='classzoo_1_1_cage.html'>Cage</a> dimensions.</span>"
  end

  it "should have a description" do
    expect(@setDimensions.has_description?).to be true
    expect(@setDimensions.description).to eq "Sets the dimensions of the Cage for the Animal."
  end

  it "should have an html description" do
    expect(@setDimensions.has_description?).to be true
    expect(@setDimensions.html_description).to eq "<span class='para'>Sets the dimensions of the <a href='classzoo_1_1_cage.html'>Cage</a> for the <a href='classzoo_1_1_animal.html'>Animal</a>.</span>"
  end

  it "should not have a return brief" do
    expect(@setDimensions.has_return_brief?).to be false
  end

  it "should not have a return type" do
    expect(@setDimensions.has_return_type?).to be false
    expect(@setDimensions.return_type.name).to eq "void"
  end

  it "should have an html return type" do
    expect(@setDimensions.return_type.html_name).to eq "void"
  end

  it "should not be pure virtual" do
    expect(@setDimensions.pure_virtual?).to be false
  end

  it "should not be virtual" do
    expect(@setDimensions.virtual?).to be false
  end

  it "should not be const" do
    expect(@setDimensions.const?).to be false
  end

  it "should have parameters" do
    expect(@setDimensions.has_parameters?).to be true
    parameters = map_node @setDimensions.parameters do |parameter| parameter.name end
    expect(parameters).to match @expected_parameters
  end

  it "should have parameter directions" do
    @setDimensions.parameters.each do |parameter|
      expect(parameter.has_direction?).to be true
      expect(parameter.direction).to eq "in"
    end
  end

  it "should have parameter types" do
    types = map_node @setDimensions.parameters do |parameter| parameter.type end
    expect(types.map do |type| type.name end).to match @expected_types
    expect(types.map do |type| type.html_name end).to match @expected_types
  end

  it "should have parameter description" do
    expect(@setDimensions.parameters.first.has_description?).to be true
    expect(@setDimensions.parameters.first.description).to eq "The width of the cage."
  end

  it "should have parameter html description" do
    expect(@setDimensions.parameters.first.has_description?).to be true
    expect(@setDimensions.parameters.first.html_description).to eq "<span class='para'>The width of the cage.</span>"
  end

end