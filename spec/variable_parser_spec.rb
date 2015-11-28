require 'spec_helper'

describe "DoxyHaml Public Variable Parser" do

  before(:all) do
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    cage_path = class_by_name namespace.classes, "CagePath"
    @variable = cage_path.public_variables.first
  end

  it "should have a name" do
    expect(@variable.name).to eq "current"
  end

  it "should have an html name" do
    expect(@variable.html_name).to match /<a href='structzoo_1_1_cage_path.html#\w{34}'>current<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@variable.fully_qualified_name).to eq "zoo::CagePath::current"
  end

  it "should have an html fully qualified name" do
    expect(@variable.html_fully_qualified_name).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='structzoo_1_1_cage_path.html'>CagePath<\/a>::<a href='structzoo_1_1_cage_path.html#\w{34}'>current<\/a>/
  end

  it "should have an html fully qualified name without self" do
    expect(@variable.html_fully_qualified_name_except_self).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='structzoo_1_1_cage_path.html'>CagePath<\/a>::current/
  end

  it "should have a qualified name" do
    expect(@variable.qualified_name).to eq "CagePath::current"
  end

  it "should have an html qualified name" do
    expect(@variable.html_qualified_name).to match /<a href='structzoo_1_1_cage_path.html'>CagePath<\/a>::<a href='structzoo_1_1_cage_path.html#\w{34}'>current<\/a>/
  end

  it "should have an html qualified name without self" do
    expect(@variable.html_qualified_name_except_self).to match /<a href='structzoo_1_1_cage_path.html'>CagePath<\/a>::current/
  end

  it "should have a type" do
    expect(@variable.type.name).to eq "Cage *"
  end

  it "should have a type with an html_name" do
    expect(@variable.type.html_name).to eq "<a href='classzoo_1_1_cage.html'>Cage</a> *"
  end

  it "should have an anchor" do
    expect(@variable.anchor).to match /\w{34}/
  end

  it "should have an html anchor" do
    expect(@variable.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a brief" do
    expect(@variable.has_brief?).to be true
    expect(@variable.brief).to eq "Current Cage."
  end

  it "should have an html brief" do
    expect(@variable.has_brief?).to be true
    expect(@variable.html_brief).to eq "Current <a href='classzoo_1_1_cage.html'>Cage</a>."
  end

  it "should have a description" do
    expect(@variable.has_description?).to be true
    expect(@variable.description).to eq "Cage to start path from."
  end

  it "should have an html description" do
    expect(@variable.has_description?).to be true
    expect(@variable.html_description).to eq "<a href='classzoo_1_1_cage.html'>Cage</a> to start path from."
  end

end