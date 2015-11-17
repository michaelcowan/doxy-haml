require 'spec_helper'

describe "DoxyHaml Index Parser" do

  before(:all) do
    @expected_namespaces = ["global", "bob", "bob::robert", "bob::robert::william", "zoo", "zoo::exhibit"]
    @namespaces_beginning_with_z = ["zoo"]
    @expected_classes = ["Animal", "Bar", "Cage", "CagePath", "Monkey", "Organism", "Person", "Rect", "Tent"]
    @classes_beginning_with_c = ["Cage", "CagePath"]
    @expected_function_names = ["Animal", "Animal", "~Animal", "canFly", "canSee", "canSee", "emptyCage", "emptyCagePath", "emptyRect", "feed", "feed", "getAnimal", "getNumberOfLegs", "getNumberOfLegs", "getPathFrom", "_kill", "numberOfMonkeys", "rect32", "setAnimal", "setDimensions", "setName", "setName"]
    @functions_beginning_with_e = ["emptyCage", "emptyCagePath", "emptyRect"]
    @expected_variable_names = ["current", "distance", "height", "minExhibits", "next", "pi", "width", "x", "y"]
    @variables_beginning_with_d = ["distance"]
    @expected_enumerations = ["Direction", "Kind", "State"]
    @enumerations_names_beginning_with_k = ["Kind"]
    @expected_enumerators = ["Amphibian", "Bird", "Closed", "Down", "Fish", "Left", "Mammal", "Open", "Reptile", "Right", "Up"]
    @enumerators_names_beginning_with_r = ["Reptile", "Right"]

    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    @index = parser.index
  end

  it "should have namespace(s)" do
    expect(@index.has_namespaces?).to be true
    namespace_names = map_node @index.namespaces do |namespace| namespace.fully_qualified_name end
    expect(namespace_names).to eq @expected_namespaces
  end

  it "should have grouped namespaces" do
    namespaces_beginning_with_z = map_node @index.indexed_namespaces['z'] do |namespace| namespace.name end
    expect(namespaces_beginning_with_z).to eq @namespaces_beginning_with_z
  end

  it "should have class(es)" do
    expect(@index.has_classes?).to be true
    class_names = map_node @index.classes do |clazz| clazz.name end
    expect(class_names).to eq @expected_classes
  end

  it "should have grouped classes" do
    class_names_beginning_with_c = map_node @index.indexed_classes['c'] do |clazz| clazz.name end
    expect(class_names_beginning_with_c).to eq @classes_beginning_with_c
  end

  it "should have function(s)" do
    public_function_names = map_node @index.functions do |function| function.name end
    expect(public_function_names).to eq @expected_function_names
  end

  it "should have grouped functions" do
    function_names_beginning_with_e = map_node @index.indexed_functions['e'] do |function| function.name end
    expect(function_names_beginning_with_e).to eq @functions_beginning_with_e
  end

  it "should have variable(s)" do
    public_variable_names = map_node @index.variables do |variable| variable.name end
    expect(public_variable_names).to eq @expected_variable_names
  end

  it "should have grouped variables" do
    variable_names_beginning_with_d = map_node @index.indexed_variables['d'] do |variable| variable.name end
    expect(variable_names_beginning_with_d).to eq @variables_beginning_with_d
  end

  it "should have enumerations" do
    enumerations_names = map_node @index.enumerations do |enum| enum.name end
    expect(enumerations_names).to match_array @expected_enumerations
  end

  it "should have grouped enumerations" do
    enumerations_names_beginning_with_k = map_node @index.indexed_enumerations['k'] do |enum| enum.name end
    expect(enumerations_names_beginning_with_k).to eq @enumerations_names_beginning_with_k
  end

  it "should have enumerators" do
    enumerators_names = map_node @index.enumerators do |value| value.name end
    expect(enumerators_names).to match_array @expected_enumerators
  end

  it "should have grouped enumerators" do
    enumerators_names_beginning_with_r = map_node @index.indexed_enumerators['r'] do |enum| enum.name end
    expect(enumerators_names_beginning_with_r).to eq @enumerators_names_beginning_with_r
  end

end