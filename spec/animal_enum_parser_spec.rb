require 'spec_helper'

describe "DoxyHaml Animal Enum Parser" do

  before(:all) do
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    classes = parser.index.namespaces.first.classes
    animal = class_by_name classes, "Animal"
    @kind = enum_by_name animal.public_enums, "Kind"
  end

  it "should have a name" do
    expect(@kind.name).to eq "Kind"
    expect(@kind.html_name).to match /<a href='classzoo_1_1_animal.html#\w{34}'>Kind<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@kind.qualified_name).to eq "zoo::Animal::Kind"
    expect(@kind.html_qualified_name).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='classzoo_1_1_animal.html'>Animal<\/a>::<a href='classzoo_1_1_animal.html#\w{34}'>Kind<\/a>/
  end

  it "should have an anchor" do
    expect(@kind.anchor).to match /\w{34}/
    expect(@kind.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a brief" do
    expect(@kind.brief).to eq "Kinds of vertebrate Animal."
    expect(@kind.html_brief).to eq "Kinds of vertebrate <a href='classzoo_1_1_animal.html'>Animal</a>."
  end

  it "should have a description" do
    expect(@kind.description).to eq "The most common types of vertebrate Animal kept at the zoo."
    expect(@kind.html_description).to eq "The most common types of vertebrate <a href='classzoo_1_1_animal.html'>Animal</a> kept at the zoo."
  end

  it "should have public values" do
    expect(@kind.public_values.empty?).to be false
  end

end