require 'spec_helper'

describe "DoxyHaml Monkey numberOfMonkeys Method Parser" do

  before(:all) do
    @expected_parameters = ["volume"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    monkey = class_by_name namespace.classes, "Monkey"
    @numberOfMonkeys = method_by_name monkey.public_static_methods, "numberOfMonkeys"
  end

  it "should have a name" do
    expect(@numberOfMonkeys.name).to eq "numberOfMonkeys"
  end

  it "should have an html name" do
    expect(@numberOfMonkeys.html_name).to match /<a href='classzoo_1_1_monkey.html#\w{34}'>numberOfMonkeys<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@numberOfMonkeys.fully_qualified_name).to eq "zoo::Monkey::numberOfMonkeys"
  end

  it "should have an html fully qualified name" do
    expect(@numberOfMonkeys.html_fully_qualified_name).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='classzoo_1_1_monkey.html'>Monkey<\/a>::<a href='classzoo_1_1_monkey.html#\w{34}'>numberOfMonkeys<\/a>/
  end

  it "should have an anchor" do
    expect(@numberOfMonkeys.anchor).to match /\w{34}/
  end

  it "should have an html anchor" do
    expect(@numberOfMonkeys.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a definition" do
    expect(@numberOfMonkeys.definition).to eq "static int zoo::Monkey::numberOfMonkeys() const"
  end

  it "should have an html definition" do
    expect(@numberOfMonkeys.html_definition).to eq "int <a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_monkey.html'>Monkey</a>::numberOfMonkeys() const"
  end

  it "should have a brief" do
    expect(@numberOfMonkeys.has_brief?).to be true
    expect(@numberOfMonkeys.brief).to eq "Get the Monkey count."
  end

  it "should have an html brief" do
    expect(@numberOfMonkeys.has_brief?).to be true
    expect(@numberOfMonkeys.html_brief).to eq "Get the <a href='classzoo_1_1_monkey.html'>Monkey</a> count."
  end

  it "should have a description" do
    expect(@numberOfMonkeys.has_description?).to be true
    expect(@numberOfMonkeys.description).to eq "Returns the Monkey count for the entire zoo."
  end

  it "should have an html description" do
    expect(@numberOfMonkeys.has_description?).to be true
    expect(@numberOfMonkeys.html_description).to eq "Returns the <a href='classzoo_1_1_monkey.html'>Monkey</a> count for the entire zoo."
  end

  it "should have a return brief" do
    expect(@numberOfMonkeys.has_return_brief?).to be true
    expect(@numberOfMonkeys.return_brief).to eq "the Monkey count for the zoo."
  end

  it "should have a return type" do
    expect(@numberOfMonkeys.has_return_type?).to be true
    expect(@numberOfMonkeys.return_type.name).to eq "int"
  end

  it "should have an html return type" do
    expect(@numberOfMonkeys.return_type.html_name).to eq "int"
  end

  it "should not be pure virtual" do
    expect(@numberOfMonkeys.pure_virtual?).to be false
  end

  it "should not be virtual" do
    expect(@numberOfMonkeys.virtual?).to be false
  end

  it "should not be const" do
    expect(@numberOfMonkeys.const?).to be true
  end

  it "should be static" do
    expect(@numberOfMonkeys.static?).to be true
  end

  it "should not have parameters" do
    expect(@numberOfMonkeys.has_parameters?).to be false
  end

  it "should not implement from parent" do
    expect(@numberOfMonkeys.reimplements?).to be false
  end

end