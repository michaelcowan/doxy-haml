require 'spec_helper'

describe "DoxyHaml Animal Enum Value Parser" do

  before(:all) do
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    classes = parser.index.namespaces.first.classes
    animal = class_by_name classes, "Animal"
    kind = enum_by_name animal.public_enums, "Kind"
    @value = kind.public_values.first
  end

  it "should have a name" do
    expect(@value.name).to eq "Mammal"
    expect(@value.html_name).to match /<a href='classzoo_1_1_animal.html#\w{67}'>Mammal<\/a>/
  end

  it "should have an anchor" do
    expect(@value.anchor).to match /\w{67}/
    expect(@value.html_anchor).to match /<a id='\w{67}'\/>/
  end

  it "should have a brief" do
    expect(@value.has_brief?).to be true
    expect(@value.brief).to eq "Mammal Animal."
    expect(@value.html_brief).to eq "Mammal <a href='classzoo_1_1_animal.html'>Animal</a>."
  end

  it "should have a description" do
    expect(@value.has_description?).to be true
    expect(@value.description).to eq "Mammal is a Kind of Animal in the zoo."
    expect(@value.html_description).to eq "Mammal is a Kind of <a href='classzoo_1_1_animal.html'>Animal</a> in the zoo."
  end

end