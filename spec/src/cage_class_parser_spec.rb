require 'spec_helper'

describe "DoxyHaml Cage Class Parser" do

  before(:all) do
    @expected_public_methods = ["setAnimal", "getAnimal"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    @classes = parser.index.namespaces.first.classes
    @cage = class_by_name "Cage"
  end

  it "should have a name" do
    expect(@cage.name).to eq "Cage"
    expect(@cage.html_name).to eq "<a href='classzoo_1_1_cage.html'>Cage</a>"
  end

  it "should have a qualified name" do
    expect(@cage.qualified_name).to eq "zoo::Cage"
    expect(@cage.html_qualified_name).to eq "<a href='classzoo_1_1_cage.html'>zoo::Cage</a>"
  end

  it "should not be abstract" do
    expect(@cage.abstract?).to be false
  end

  it "should have public method(s)" do
    expect(@cage.has_public_methods?).to be true
    public_method_names = map_node @cage.public_methods do |method| method.name end
    expect(public_method_names).to match_array @expected_public_methods
  end

  it "should not have public static method(s)" do
    expect(@cage.has_public_static_methods?).to be false
  end

end