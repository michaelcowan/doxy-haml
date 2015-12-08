require 'spec_helper'

describe "DoxyHaml Animal Enum Value Parser" do

  before(:all) do
    parser = DoxyHaml::Parser.new "spec/doxygen/xml", "spec/src"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    animal = class_by_name namespace.classes, "Animal"
    kind = enum_by_name animal.public_enums, "Kind"
    @value = kind.public_values.first
  end

  it "should have a name" do
    expect(@value.name).to eq "Mammal"
  end

  it "should have an html name" do
    expect(@value.html_name).to match /<a href='classzoo_1_1_animal.html#\w{67}'>Mammal<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@value.fully_qualified_name).to eq "zoo::Animal::Kind::Mammal"
  end

  it "should have an html fully qualified name" do
    expect(@value.html_fully_qualified_name).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='classzoo_1_1_animal.html'>Animal<\/a>::<a href='classzoo_1_1_animal.html#\w{34}'>Kind<\/a>::<a href='classzoo_1_1_animal.html#\w{67}'>Mammal<\/a>/
  end

  it "should have an anchor" do
    expect(@value.anchor).to match /\w{67}/
  end

  it "should have an html anchor" do
    expect(@value.html_anchor).to match /<a id='\w{67}'\/>/
  end

  it "should have a brief" do
    expect(@value.has_brief?).to be true
    expect(@value.brief).to eq "Mammal Animal."
  end

  it "should have an html brief" do
    expect(@value.has_brief?).to be true
    expect(@value.html_brief).to eq "<span class='para'>Mammal <a href='classzoo_1_1_animal.html'>Animal</a>.</span>"
  end

  it "should have a description" do
    expect(@value.has_description?).to be true
    expect(@value.description).to eq "Mammal is a Kind of Animal in the zoo."
  end

  it "should have an html description" do
    expect(@value.has_description?).to be true
    expect(@value.html_description).to eq "<span class='para'>Mammal is a Kind of <a href='classzoo_1_1_animal.html'>Animal</a> in the zoo.</span>"
  end

end