require 'spec_helper'

describe "DoxyHaml Parameter Parser" do

  before(:all) do
    @expected_public_functions = ["setAnimal", "getAnimal", "setDimensions"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml", "spec/src"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    cage = class_by_name namespace.classes, "Cage"
    setAnimal = function_by_name cage.public_functions, "setAnimal"
    @param = setAnimal.parameters[1]
  end

  it "should have a name" do
    expect(@param.name).to eq "mate"
  end

  it "should have a default value" do
    expect(@param.has_default_value?).to be true
    expect(@param.default_value).to eq "NULL"
  end

  it "should not have a direction" do
    expect(@param.has_direction?).to be false
  end

  it "should have a definition" do
    expect(@param.definition).to eq "Animal * mate=NULL"
  end

  it "should have an html definition" do
    expect(@param.html_definition).to eq "<a href='classzoo_1_1_animal.html'>Animal</a> * mate=NULL"
  end

  it "should have a type name" do
    expect(@param.type.name).to eq "Animal *"
  end

  it "should have a type html name" do
    expect(@param.type.html_name).to eq "<a href='classzoo_1_1_animal.html'>Animal</a> *"
  end

end