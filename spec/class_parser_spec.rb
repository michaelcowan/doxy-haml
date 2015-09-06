require 'spec_helper'

describe "DoxyHaml Class Parser" do

  before(:all) do
    @expected_public_methods = ["Animal", "canFly", "getNumberOfLegs"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    @classes = parser.index.namespaces.first.classes
    @animal = class_by_name "Animal"
  end

  it "should have a name" do
    expect(@animal.name).to eq "Animal"
    expect(@animal.html_name).to match "<a href='classzoo_1_1_?[aA]nimal.html'>Animal</a>"
  end

  it "should have a qualified name" do
    expect(@animal.qualified_name).to eq "zoo::Animal"
    expect(@animal.html_qualified_name).to match "<a href='classzoo_1_1_?[aA]nimal.html'>zoo::Animal</a>"
  end

  it "should be abstract" do
    expect(@animal.abstract?).to be true
  end

  it "should have public method(s)" do
    expect(@animal.has_public_methods?).to be true
    public_method_names = map_node @animal.public_methods do |method| method.name end
    expect(public_method_names).to match_array @expected_public_methods
  end

  it "should not have public static method(s)" do
    expect(@animal.has_public_static_methods?).to be false
  end

end