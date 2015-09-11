require 'spec_helper'

describe "DoxyHaml Monkey feed Method Parser" do

  before(:all) do
    @expected_parameters = ["volume"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    classes = parser.index.namespaces.first.classes
    monkey = class_by_name classes, "Monkey"
    @feed = method_by_name monkey.public_methods, "feed"
  end

  it "should have a name" do
    expect(@feed.name).to eq "feed"
    expect(@feed.html_name).to match /<a href='classzoo_1_1_monkey.html#\w{34}'>feed<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@feed.qualified_name).to eq "zoo::Monkey::feed"
    expect(@feed.html_qualified_name).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='classzoo_1_1_monkey.html'>Monkey<\/a>::<a href='classzoo_1_1_monkey.html#\w{34}'>feed<\/a>/
  end

  it "should have an anchor" do
    expect(@feed.anchor).to match /\w{34}/
    expect(@feed.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a definition" do
    expect(@feed.definition).to eq "virtual void zoo::Monkey::feed(const int volume)"
    expect(@feed.html_definition).to eq "virtual void <a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_monkey.html'>Monkey</a>::feed(const int volume)"
  end

  it "should have a brief" do
    expect(@feed.brief).to eq "Feed the Monkey."
    expect(@feed.html_brief).to eq "Feed the <a href='classzoo_1_1_monkey.html'>Monkey</a>."
  end

  it "should have a description" do
    expect(@feed.description).to eq "Feeds the Monkey."
    expect(@feed.html_description).to eq "Feeds the <a href='classzoo_1_1_monkey.html'>Monkey</a>."
  end

  it "should not have a return brief" do
    expect(@feed.has_return_brief?).to be false
  end

  it "should have a return type" do
    expect(@feed.return_type.name).to eq "void"
    expect(@feed.return_type.html_name).to eq "void"
  end

  it "should be pure virtual" do
    expect(@feed.pure_virtual?).to be false
  end

  it "should not be virtual" do
    expect(@feed.virtual?).to be true
  end

  it "should be const" do
    expect(@feed.const?).to be false
  end

  it "should have parameters" do
    expect(@feed.has_parameters?).to be true
    parameters = map_node @feed.parameters do |parameter| parameter.name end
    expect(parameters).to match @expected_parameters
  end

end