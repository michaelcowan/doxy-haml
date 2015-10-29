require 'spec_helper'

describe "DoxyHaml Animal getPathFrom Method Parser" do

  before(:all) do
    @expected_parameters = ["cage", ""]
    @expected_types = ["Cage *", "bool"]
    @expected_html_types = ["<a href='classzoo_1_1_cage.html'>Cage</a> *", "bool"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    animal = class_by_name namespace.classes, "Animal"
    @getPathFrom = method_by_name animal.public_methods, "getPathFrom"
  end

  it "should have a name" do
    expect(@getPathFrom.name).to eq "getPathFrom"
  end

  it "should have an html name" do
    expect(@getPathFrom.html_name).to match /<a href='classzoo_1_1_animal.html#\w{34}'>getPathFrom<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@getPathFrom.fully_qualified_name).to eq "zoo::Animal::getPathFrom"
  end

  it "should have an html fully qualified name" do
    expect(@getPathFrom.html_fully_qualified_name).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='classzoo_1_1_animal.html'>Animal<\/a>::<a href='classzoo_1_1_animal.html#\w{34}'>getPathFrom<\/a>/
  end

  it "should have a qualified name" do
    expect(@getPathFrom.qualified_name).to eq "Animal::getPathFrom"
  end

  it "should have an html qualified name" do
    expect(@getPathFrom.html_qualified_name).to match /<a href='classzoo_1_1_animal.html'>Animal<\/a>::<a href='classzoo_1_1_animal.html#\w{34}'>getPathFrom<\/a>/
  end

  it "should have an anchor" do
    expect(@getPathFrom.anchor).to match /\w{34}/
  end

  it "should have an html anchor" do
    expect(@getPathFrom.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a definition" do
    expect(@getPathFrom.definition).to eq "CagePath* zoo::Animal::getPathFrom(Cage *cage, bool)"
  end

  it "should have an html definition" do
    expect(@getPathFrom.html_definition).to eq "<a href='structzoo_1_1_cage_path.html'>CagePath</a> * <a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_animal.html'>Animal</a>::getPathFrom(<a href='classzoo_1_1_cage.html'>Cage</a> * cage, bool)"
  end

  it "should not have a brief" do
    expect(@getPathFrom.has_brief?).to be false
  end

  it "should not have a description" do
    expect(@getPathFrom.has_description?).to be false
  end

  it "should not have a return brief" do
    expect(@getPathFrom.has_return_brief?).to be false
  end

  it "should have a return type" do
    expect(@getPathFrom.has_return_type?).to be true
    expect(@getPathFrom.return_type.name).to eq "CagePath *"
  end

  it "should have an html return type" do
    expect(@getPathFrom.return_type.html_name).to eq "<a href='structzoo_1_1_cage_path.html'>CagePath</a> *"
  end

  it "should not be a constructor" do
    expect(@getPathFrom.constructor?).to be false
  end

  it "should not be a destructor" do
    expect(@getPathFrom.destructor?).to be false
  end

  it "should not be pure virtual" do
    expect(@getPathFrom.pure_virtual?).to be false
  end

  it "should not be virtual" do
    expect(@getPathFrom.virtual?).to be false
  end

  it "should not be const" do
    expect(@getPathFrom.const?).to be false
  end

  it "should have parameters" do
    expect(@getPathFrom.has_parameters?).to be true
    parameters = map_node @getPathFrom.parameters do |parameter| parameter.name end
    expect(parameters).to match @expected_parameters
  end

  it "should not implement from parent" do
    expect(@getPathFrom.reimplements?).to be false
  end

  it "should not have parameter directions" do
    @getPathFrom.parameters.each do |parameter|
      expect(parameter.has_direction?).to be false
      expect(parameter.direction).to eq nil
    end
  end

  it "should have parameter types" do
    types = map_node @getPathFrom.parameters do |parameter| parameter.type end
    expect(types.map do |type| type.name end).to match @expected_types
    expect(types.map do |type| type.html_name end).to match @expected_html_types
  end

  it "should not have default parameters" do
    @getPathFrom.parameters.each do |parameter|
      expect(parameter.has_default_value?).to be false
    end
  end

  it "should not have parameter description" do
    expect(@getPathFrom.parameters.first.has_description?).to be false
  end

end
