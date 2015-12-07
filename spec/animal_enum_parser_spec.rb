require 'spec_helper'

describe "DoxyHaml Animal Enum Parser" do

  before(:all) do
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    animal = class_by_name namespace.classes, "Animal"
    @kind = enum_by_name animal.public_enums, "Kind"
  end

  it "should have a name" do
    expect(@kind.name).to eq "Kind"
  end

  it "should have an html name" do
    expect(@kind.html_name).to match /<a href='classzoo_1_1_animal.html#\w{34}'>Kind<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@kind.fully_qualified_name).to eq "zoo::Animal::Kind"
  end

  it "should have an html fully qualified name" do
    expect(@kind.html_fully_qualified_name).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='classzoo_1_1_animal.html'>Animal<\/a>::<a href='classzoo_1_1_animal.html#\w{34}'>Kind<\/a>/
  end

  it "should have an html fully qualified name without self" do
    expect(@kind.html_fully_qualified_name_except_self).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='classzoo_1_1_animal.html'>Animal<\/a>::Kind/
  end

  it "should have a qualified name" do
    expect(@kind.qualified_name).to eq "Animal::Kind"
  end

  it "should have an html qualified name" do
    expect(@kind.html_qualified_name).to match /<a href='classzoo_1_1_animal.html'>Animal<\/a>::<a href='classzoo_1_1_animal.html#\w{34}'>Kind<\/a>/
  end

  it "should have an html qualified name without self" do
    expect(@kind.html_qualified_name_except_self).to match /<a href='classzoo_1_1_animal.html'>Animal<\/a>::Kind/
  end

  it "should have an anchor" do
    expect(@kind.anchor).to match /\w{34}/
  end

  it "should have an html anchor" do
    expect(@kind.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a brief" do
    expect(@kind.has_brief?).to be true
    expect(@kind.brief).to eq "Kinds of vertebrate Animal."
  end

  it "should have an html brief" do
    expect(@kind.has_brief?).to be true
    expect(@kind.html_brief).to eq "<span class='para'>Kinds of vertebrate <a href='classzoo_1_1_animal.html'>Animal</a>.</span>"
  end

  it "should have a description" do
    expect(@kind.has_description?).to be true
    expect(@kind.description).to eq "The most common types of vertebrate Animal kept at the zoo."
  end

  it "should have an html description" do
    expect(@kind.has_description?).to be true
    expect(@kind.html_description).to eq "<span class='para'>The most common types of vertebrate <a href='classzoo_1_1_animal.html'>Animal</a> kept at the zoo.</span>"
  end

  it "should have public values" do
    expect(@kind.public_values.empty?).to be false
  end

end