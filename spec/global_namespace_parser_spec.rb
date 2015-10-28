require 'spec_helper'

describe "DoxyHaml Global Namespace Parser" do

  before(:all) do
    @expected_public_methods = ["rect32"]
    @expected_classes = ["Person", "Rect"]
    @expected_namespaces = ["bob", "zoo"]

    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    @namespace = namespace_by_name parser.index.namespaces, "global"
  end

  it "should not have a compound parent" do
    expect(@namespace.has_compound_parent?).to be false
  end

  it "should have a name" do
    expect(@namespace.name).to eq "global"
  end

  it "should have an html name" do
    expect(@namespace.html_name).to eq "<a href='global.html'>global</a>"
  end

  it "should have a qualified name" do
    expect(@namespace.qualified_name).to eq "global"
  end

  it "should have an html qualified name" do
    expect(@namespace.html_qualified_name).to eq "<a href='global.html'>global</a>"
  end

  it "should have class(es)" do
    expect(@namespace.has_classes?).to be true
    class_names = map_node @namespace.classes do |clazz| clazz.name end
    expect(class_names).to match_array @expected_classes
  end

  it "should have namespace(s)" do
    expect(@namespace.has_namespaces?).to be true
    namespace_names = map_node @namespace.namespaces do |namespace| namespace.name end
    expect(namespace_names).to match_array @expected_namespaces
  end

  it "should have public method(s)" do
    expect(@namespace.has_public_methods?).to be true
    public_method_names = map_node @namespace.public_methods do |method| method.name end
    expect(public_method_names).to eq @expected_public_methods
  end

end