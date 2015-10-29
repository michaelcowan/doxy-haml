require 'spec_helper'

describe "DoxyHaml Animal getNumberOfLegs Method Parser" do

  before(:all) do
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    animal = class_by_name namespace.classes, "Animal"
    @getNumberOfLegs = method_by_name animal.public_methods, "getNumberOfLegs"
  end

  it "should have a name" do
    expect(@getNumberOfLegs.name).to eq "getNumberOfLegs"
  end

  it "should have an html name" do
    expect(@getNumberOfLegs.html_name).to match /<a href='classzoo_1_1_animal.html#\w{34}'>getNumberOfLegs<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@getNumberOfLegs.fully_qualified_name).to eq "zoo::Animal::getNumberOfLegs"
  end

  it "should have an html fully qualified name" do
    expect(@getNumberOfLegs.html_fully_qualified_name).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='classzoo_1_1_animal.html'>Animal<\/a>::<a href='classzoo_1_1_animal.html#\w{34}'>getNumberOfLegs<\/a>/
  end

  it "should have a qualified name" do
    expect(@getNumberOfLegs.qualified_name).to eq "Animal::getNumberOfLegs"
  end

  it "should have an html qualified name" do
    expect(@getNumberOfLegs.html_qualified_name).to match /<a href='classzoo_1_1_animal.html'>Animal<\/a>::<a href='classzoo_1_1_animal.html#\w{34}'>getNumberOfLegs<\/a>/
  end

  it "should have an anchor" do
    expect(@getNumberOfLegs.anchor).to match /\w{34}/
  end

  it "should have an html anchor" do
    expect(@getNumberOfLegs.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a definition" do
    expect(@getNumberOfLegs.definition).to eq "virtual int zoo::Animal::getNumberOfLegs() const =0"
  end

  it "should have an html definition" do
    expect(@getNumberOfLegs.html_definition).to eq "virtual int <a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_animal.html'>Animal</a>::getNumberOfLegs() const =0"
  end

  it "should have a brief" do
    expect(@getNumberOfLegs.has_brief?).to be true
    expect(@getNumberOfLegs.brief).to eq "Get the leg count of this Animal."
  end

  it "should have an html brief" do
    expect(@getNumberOfLegs.has_brief?).to be true
    expect(@getNumberOfLegs.html_brief).to eq "Get the leg count of this <a href='classzoo_1_1_animal.html'>Animal</a>."
  end

  it "should have a description" do
    expect(@getNumberOfLegs.has_description?).to be true
    expect(@getNumberOfLegs.description).to eq "Returns how many legs this Animal has."
  end

  it "should have an html description" do
    expect(@getNumberOfLegs.has_description?).to be true
    expect(@getNumberOfLegs.html_description).to eq "Returns how many legs this <a href='classzoo_1_1_animal.html'>Animal</a> has."
  end

  it "should have a return brief" do
    expect(@getNumberOfLegs.has_return_brief?).to be true
    expect(@getNumberOfLegs.return_brief).to eq "the number of legs for this Animal."
  end

  it "should have an html return brief" do
    expect(@getNumberOfLegs.has_return_brief?).to be true
    expect(@getNumberOfLegs.html_return_brief).to eq "the number of legs for this <a href='classzoo_1_1_animal.html'>Animal</a>."
  end

  it "should have a return type" do
    expect(@getNumberOfLegs.has_return_type?).to be true
    expect(@getNumberOfLegs.return_type.name).to eq "int"
  end

  it "should have an html return type" do
    expect(@getNumberOfLegs.return_type.html_name).to eq "int"
  end

  it "should not be a constructor" do
    expect(@getNumberOfLegs.constructor?).to be false
  end

  it "should not be a destructor" do
    expect(@getNumberOfLegs.destructor?).to be false
  end

  it "should be pure virtual" do
    expect(@getNumberOfLegs.pure_virtual?).to be true
  end

  it "should not be virtual" do
    expect(@getNumberOfLegs.virtual?).to be false
  end

  it "should be const" do
    expect(@getNumberOfLegs.const?).to be true
  end

  it "should not have any parameters" do
    expect(@getNumberOfLegs.has_parameters?).to be false
  end

  it "should not implement from parent" do
    expect(@getNumberOfLegs.reimplements?).to be false
  end

end