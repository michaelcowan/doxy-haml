require 'spec_helper'

describe "DoxyHaml Global Namespace Parser" do

  before(:all) do
    @expected_public_functions = ["rect32"]
    @expected_public_static_functions = ["emptyRect"]
    @expected_classes = ["Person", "Rect"]
    @expected_namespaces = ["bob", "zoo"]
    @expected_public_enums = ["Direction"]
    @expected_public_variables = ["pi"]
    @expected_public_static_variables = ["e"]

    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    @namespace = namespace_by_name parser.index.namespaces, "global"
  end

  it "should not have a qualifying parent" do
    expect(@namespace.has_qualifying_parent?).to be false
  end

  it "should have a name" do
    expect(@namespace.name).to eq "global"
  end

  it "should have an html name" do
    expect(@namespace.html_name).to eq "<a href='global.html'>global</a>"
  end

  it "should have a fully qualified name" do
    expect(@namespace.fully_qualified_name).to eq "global"
  end

  it "should have an html fully qualified name" do
    expect(@namespace.html_fully_qualified_name).to eq "<a href='global.html'>global</a>"
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

  it "should have public function(s)" do
    expect(@namespace.has_public_functions?).to be true
    public_function_names = map_node @namespace.public_functions do |function| function.name end
    expect(public_function_names).to eq @expected_public_functions
  end

  it "should have public static function(s)" do
    expect(@namespace.has_public_static_functions?).to be true
    public_static_function_names = map_node @namespace.public_static_functions do |function| function.name end
    expect(public_static_function_names).to match_array @expected_public_static_functions
  end

  it "should have public enum(s)" do
    expect(@namespace.has_public_enums?).to be true
    public_enum_names = map_node @namespace.public_enums do |enum| enum.name end
    expect(public_enum_names).to match_array @expected_public_enums
  end

  it "should have public enum(s) with html name" do
    expect(@namespace.public_enums.first.html_name).to match /<a href='global.html#\w{34}'>Direction<\/a>/
  end

  it "should have public enumertor(s) with html name" do
    expect(@namespace.public_enums.first.public_values.first.html_name).to match /<a href='global.html#\w{67}'>Up<\/a>/
  end

  it "should have public variable(s)" do
    expect(@namespace.has_public_variables?).to be true
    public_variable_names = map_node @namespace.public_variables do |variable| variable.name end
    expect(public_variable_names).to eq @expected_public_variables
    expect(@namespace.public_variables.all? { |v| v.static? }).to be false
  end

  it "should have public static variable(s)" do
    expect(@namespace.has_public_static_variables?).to be true
    public_static_variable_names = map_node @namespace.public_static_variables do |variable| variable.name end
    expect(public_static_variable_names).to match_array @expected_public_static_variables
    expect(@namespace.public_static_variables.all? { |v| v.static? }).to be true
  end

end