require 'spec_helper'

describe "DoxyHaml Exhibit Namespace Parser" do

  before(:all) do
    @expected_classes = ["Tent"]

    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    @namespace = namespace.namespaces.first
  end

  it "should have a name" do
    expect(@namespace.name).to eq "exhibit"
    expect(@namespace.html_name).to eq "<a href='namespacezoo_1_1exhibit.html'>exhibit</a>"
  end

  it "should have a qualified name" do
    expect(@namespace.qualified_name).to eq "zoo::exhibit"
    expect(@namespace.html_qualified_name).to eq "<a href='namespacezoo.html'>zoo</a>::<a href='namespacezoo_1_1exhibit.html'>exhibit</a>"
  end

  it "should have a brief" do
    expect(@namespace.has_brief?).to be true
    expect(@namespace.brief).to eq "Exhibit interfaces and implementations."
    expect(@namespace.html_brief).to eq "Exhibit interfaces and implementations."
  end

  it "should have a description" do
    expect(@namespace.has_description?).to be true
    expect(@namespace.description).to eq "The exhibit namespace holds all interfaces and implementations related to exhibits at the zoo."
    expect(@namespace.html_description).to eq "The exhibit namespace holds all interfaces and implementations related to exhibits at the zoo."
  end

  it "should not have an author" do
    expect(@namespace.has_author?).to be false
  end

  it "should have class(es)" do
    expect(@namespace.has_classes?).to be true
    class_names = map_node @namespace.classes do |clazz| clazz.name end
    expect(class_names).to match_array @expected_classes
  end

  it "should not have namespace(s)" do
    expect(@namespace.has_namespaces?).to be false
  end

end