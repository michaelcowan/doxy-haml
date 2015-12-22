require 'spec_helper'

describe "DoxyHaml Global namespace Function Parser" do

  before(:all) do
    parser = DoxyHaml::Parser.new "spec/doxygen/xml", "spec/src"
    namespace = namespace_by_name parser.index.namespaces, "global"
    @rect32 = function_by_name namespace.public_functions, "rect32"
  end

  it "should have a name" do
    expect(@rect32.name).to eq "rect32"
  end

  it "should have an html name" do
    expect(@rect32.html_name).to match /<a href='global.html#\w{34}'>rect32<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@rect32.fully_qualified_name).to eq "rect32"
  end

  it "should have an html fully qualified name" do
    expect(@rect32.html_fully_qualified_name).to match /<a href='global.html#\w{34}'>rect32<\/a>/
  end

  it "should have a qualified name" do
    expect(@rect32.qualified_name).to eq "rect32"
  end

  it "should have an html qualified name" do
    expect(@rect32.html_qualified_name).to match /<a href='global.html#\w{34}'>rect32<\/a>/
  end

  it "should have an anchor" do
    expect(@rect32.anchor).to match /\w{34}/
  end

  it "should have an html anchor" do
    expect(@rect32.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a definition" do
    expect(@rect32.definition).to eq "Rect* rect32()"
  end

  it "should have an html definition" do
    expect(@rect32.html_definition).to eq "<a href='struct_rect.html'>Rect</a> * rect32()"
  end

  it "should have a brief" do
    expect(@rect32.has_brief?).to be true
    expect(@rect32.brief).to eq "Create a Rect of 32x32 at origin."
  end

  it "should have an html brief" do
    expect(@rect32.has_brief?).to be true
    expect(@rect32.html_brief).to eq "<span class='para'>Create a <a href='struct_rect.html'>Rect</a> of 32x32 at origin.</span>"
  end

  it "should use brief as a description" do
    expect(@rect32.has_description?).to be true
    expect(@rect32.description).to eq @rect32.brief
  end

  it "should use html brief as an html description" do
    expect(@rect32.has_description?).to be true
    expect(@rect32.html_description).to eq @rect32.html_brief
  end

  it "should not have a return brief" do
    expect(@rect32.has_return_brief?).to be false
  end

  it "should not have an html return brief" do
    expect(@rect32.has_return_brief?).to be false
  end

  it "should have a return type" do
    expect(@rect32.has_return_type?).to be true
    expect(@rect32.return_type.name).to eq "Rect *"
  end

  it "should have an html return type" do
    expect(@rect32.return_type.html_name).to eq "<a href='struct_rect.html'>Rect</a> *"
  end

  it "should not be a constructor" do
    expect(@rect32.constructor?).to be false
  end

  it "should not be a destructor" do
    expect(@rect32.destructor?).to be false
  end

  it "should not be pure virtual" do
    expect(@rect32.pure_virtual?).to be false
  end

  it "should not be virtual" do
    expect(@rect32.virtual?).to be false
  end

  it "should not be const" do
    expect(@rect32.const?).to be false
  end

  it "should not have any parameters" do
    expect(@rect32.has_parameters?).to be false
  end

  it "should not implement from parent" do
    expect(@rect32.reimplements?).to be false
  end

end
