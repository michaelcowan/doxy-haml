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

end