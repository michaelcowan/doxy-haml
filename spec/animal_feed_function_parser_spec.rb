require 'spec_helper'

describe "DoxyHaml Animal feed Function Parser" do

  before(:all) do
    @expected_parameters = ["volume"]
    @expected_reimplementedby = ["zoo::Monkey::feed"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml", "spec/src"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    animal = class_by_name namespace.classes, "Animal"
    @feed = function_by_name animal.public_functions, "feed"
  end

  it "should have a name" do
    expect(@feed.name).to eq "feed"
  end

  it "should have an html name" do
    expect(@feed.html_name).to match /<a href='classzoo_1_1_animal.html#\w{34}'>feed<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@feed.fully_qualified_name).to eq "zoo::Animal::feed"
  end

  it "should have an html fully qualified name" do
    expect(@feed.html_fully_qualified_name).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='classzoo_1_1_animal.html'>Animal<\/a>::<a href='classzoo_1_1_animal.html#\w{34}'>feed<\/a>/
  end

  it "should have a qualified name" do
    expect(@feed.qualified_name).to eq "Animal::feed"
  end

  it "should have an html qualified name" do
    expect(@feed.html_qualified_name).to match /<a href='classzoo_1_1_animal.html'>Animal<\/a>::<a href='classzoo_1_1_animal.html#\w{34}'>feed<\/a>/
  end

  it "should have an anchor" do
    expect(@feed.anchor).to match /\w{34}/
  end

  it "should have an html anchor" do
    expect(@feed.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a definition" do
    expect(@feed.definition).to eq "virtual void zoo::Animal::feed(const int volume)=0"
  end

  it "should have an html definition" do
    expect(@feed.html_definition).to eq "virtual void <a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_animal.html'>Animal</a>::feed(const int volume)=0"
  end

  it "should have a brief" do
    expect(@feed.has_brief?).to be true
    expect(@feed.brief).to eq "Feed the Animal."
  end

  it "should have an html brief" do
    expect(@feed.has_brief?).to be true
    expect(@feed.html_brief).to eq "<span class='para'>Feed the <a href='classzoo_1_1_animal.html'>Animal</a>.</span>"
  end

  it "should have a description" do
    expect(@feed.has_description?).to be true
    expect(@feed.description).to eq "Feeds the Animal. The volume is specific to each Animal Kind.\nThis does not mean the Animal is eating."
  end

  it "should have an html description" do
    expect(@feed.has_description?).to be true
    expect(@feed.html_description).to eq "<span class='para'>Feeds the <a href='classzoo_1_1_animal.html'>Animal</a>. The volume is specific to each <a href='classzoo_1_1_animal.html'>Animal</a> Kind.</span><span class='para'>This does not mean the <a href='classzoo_1_1_animal.html'>Animal</a> is eating.</span>"
  end

  it "should not have a return brief" do
    expect(@feed.has_return_brief?).to be false
  end

  it "should not have a return type" do
    expect(@feed.has_return_type?).to be false
    expect(@feed.return_type.name).to eq "void"
  end

  it "should have an html return type" do
    expect(@feed.return_type.html_name).to eq "void"
  end

  it "should be pure virtual" do
    expect(@feed.pure_virtual?).to be true
  end

  it "should not be virtual" do
    expect(@feed.virtual?).to be false
  end

  it "should be const" do
    expect(@feed.const?).to be false
  end

  it "should have parameters" do
    expect(@feed.has_parameters?).to be true
    parameters = map_node @feed.parameters do |parameter| parameter.name end
    expect(parameters).to match @expected_parameters
  end

  it "should not implement from parent" do
    expect(@feed.reimplements?).to be false
  end

  it "should be reimplemented by" do
    expect(@feed.reimplementedby?).to be true
    reimplementedby = map_node @feed.reimplementedby do |function| function.fully_qualified_name end
    expect(reimplementedby).to match @expected_reimplementedby
  end

end