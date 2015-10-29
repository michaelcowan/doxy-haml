require 'spec_helper'

describe "DoxyHaml Struct Parser" do

  before(:all) do
    @expected_public_variables = ["current", "distance", "next"]
    @expected_public_static_variables = ["first"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    @cage_path = class_by_name namespace.classes, "CagePath"
  end

  it "should be a struct" do
    expect(@cage_path.is_struct?).to be true
  end

  it "should have a name" do
    expect(@cage_path.name).to eq "CagePath"
  end

  it "should have an html name" do
    expect(@cage_path.html_name).to eq "<a href='structzoo_1_1_cage_path.html'>CagePath</a>"
  end

  it "should have a qualified name" do
    expect(@cage_path.fully_qualified_name).to eq "zoo::CagePath"
  end

  it "should have an html qualified name" do
    expect(@cage_path.html_fully_qualified_name).to eq "<a href='namespacezoo.html'>zoo</a>::<a href='structzoo_1_1_cage_path.html'>CagePath</a>"
  end

  it "should have a brief" do
    expect(@cage_path.has_brief?).to be true
    expect(@cage_path.brief).to eq "Represents a path between Cage instances."
  end

  it "should have an html brief" do
    expect(@cage_path.has_brief?).to be true
    expect(@cage_path.html_brief).to eq "Represents a path between <a href='classzoo_1_1_cage.html'>Cage</a> instances."
  end

  it "should have a description" do
    expect(@cage_path.has_description?).to be true
    expect(@cage_path.description).to eq "The struct CagePath is used to create paths between instances of Cage."
  end

  it "should have an html description" do
    expect(@cage_path.has_description?).to be true
    expect(@cage_path.html_description).to eq "The struct <a href='structzoo_1_1_cage_path.html'>CagePath</a> is used to create paths between instances of <a href='classzoo_1_1_cage.html'>Cage</a>."
  end

  it "should have an author" do
    expect(@cage_path.author).to eq "Michael Cowan"
  end

  it "should have public variable(s)" do
    expect(@cage_path.has_public_variables?).to be true
    public_variable_names = map_node @cage_path.public_variables do |variable| variable.name end
    expect(public_variable_names).to eq @expected_public_variables
    expect(@cage_path.public_variables.all? { |v| v.static? }).to be false
  end

  it "should have public static variable(s)" do
    expect(@cage_path.has_public_static_variables?).to be true
    public_static_variable_names = map_node @cage_path.public_static_variables do |variable| variable.name end
    expect(public_static_variable_names).to match_array @expected_public_static_variables
    expect(@cage_path.public_static_variables.all? { |v| v.static? }).to be true
  end

end