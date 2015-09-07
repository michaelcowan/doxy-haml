require 'spec_helper'

describe "DoxyHaml Animal Method Parser" do

  before(:all) do
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    classes = parser.index.namespaces.first.classes
    animal = class_by_name classes, "Animal"
    @getNumberOfLegs = method_by_name animal.public_methods, "getNumberOfLegs"
  end

  it "should have a name" do
    expect(@getNumberOfLegs.name).to eq "getNumberOfLegs"
  end

  it "should have an anchor" do
    expect(@getNumberOfLegs.anchor).to match /classzoo_1_1_animal_\w{34}/
    expect(@getNumberOfLegs.html_anchor).to match /<a href='#classzoo_1_1_animal_\w{34}'>getNumberOfLegs<\/a>/
  end

  it "should have a definition" do
    expect(@getNumberOfLegs.definition).to eq "virtual int zoo::Animal::getNumberOfLegs"
  end

  it "should have a brief" do
    expect(@getNumberOfLegs.brief).to eq "Get the leg count of this Animal."
    expect(@getNumberOfLegs.html_brief).to eq "Get the leg count of this <a href='classzoo_1_1_animal.html'>Animal</a>."
  end

  it "should have a description" do
    expect(@getNumberOfLegs.description).to eq "Returns how many legs this Animal has."
    expect(@getNumberOfLegs.html_description).to eq "Returns how many legs this <a href='classzoo_1_1_animal.html'>Animal</a> has."
  end

  it "should have a return brief" do
    expect(@getNumberOfLegs.return_brief).to eq "the number of legs for this Animal."
    expect(@getNumberOfLegs.html_return_brief).to eq "the number of legs for this <a href='classzoo_1_1_animal.html'>Animal</a>."
  end

  it "should have a return type" do
    expect(@getNumberOfLegs.returns.name).to eq "int"
    expect(@getNumberOfLegs.returns.html_name).to eq "int"
  end

end