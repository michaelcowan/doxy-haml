require 'spec_helper'

describe "DoxyHaml Cage setAnimal Method Parser" do

  before(:all) do
    @expected_parameters = ["animal", "mate"]
    @expected_types = ["Animal *", "Animal *"]
    @expected_html_types = ["<a href='classzoo_1_1_animal.html'>Animal</a> *", "<a href='classzoo_1_1_animal.html'>Animal</a> *"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    classes = parser.index.namespaces.first.classes
    cage = class_by_name classes, "Cage"
    @setAnimal = method_by_name cage.public_methods, "setAnimal"
  end

  it "should have a name" do
    expect(@setAnimal.name).to eq "setAnimal"
    expect(@setAnimal.html_name).to match /<a href='classzoo_1_1_cage.html#\w{34}'>setAnimal<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@setAnimal.qualified_name).to eq "zoo::Cage::setAnimal"
    expect(@setAnimal.html_qualified_name).to eq "<a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_cage.html'>Cage</a>::<a href='classzoo_1_1_cage.html#1ac6017d49490b925fc07a59b9d19d7ec4'>setAnimal</a>"
  end

  it "should have an anchor" do
    expect(@setAnimal.anchor).to match /\w{34}/
    expect(@setAnimal.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a definition" do
    expect(@setAnimal.definition).to eq "bool zoo::Cage::setAnimal(Animal *animal, Animal *mate=NULL)"
    expect(@setAnimal.html_definition).to eq "bool <a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_cage.html'>Cage</a>::setAnimal(<a href='classzoo_1_1_animal.html'>Animal</a> * animal, <a href='classzoo_1_1_animal.html'>Animal</a> * mate=NULL)"
  end

  it "should have a brief" do
    expect(@setAnimal.brief).to eq "Sets the Animal."
    expect(@setAnimal.html_brief).to eq "Sets the <a href='classzoo_1_1_animal.html'>Animal</a>."
  end

  it "should have a description" do
    expect(@setAnimal.description).to eq "Puts an Animal in this Cage."
    expect(@setAnimal.html_description).to eq "Puts an <a href='classzoo_1_1_animal.html'>Animal</a> in this <a href='classzoo_1_1_cage.html'>Cage</a>."
  end

  it "should have a return brief" do
    expect(@setAnimal.has_return_brief?).to be true
    expect(@setAnimal.return_brief).to eq "true if the Animal can be put in this cage."
    expect(@setAnimal.html_return_brief).to eq "true if the <a href='classzoo_1_1_animal.html'>Animal</a> can be put in this cage."
  end

  it "should have a return type" do
    expect(@setAnimal.return_type.name).to eq "bool"
    expect(@setAnimal.return_type.html_name).to eq "bool"
  end

  it "should not be pure virtual" do
    expect(@setAnimal.pure_virtual?).to be false
  end

  it "should not be virtual" do
    expect(@setAnimal.virtual?).to be false
  end

  it "should not be const" do
    expect(@setAnimal.const?).to be false
  end

  it "should have parameters" do
    expect(@setAnimal.has_parameters?).to be true
    parameters = map_node @setAnimal.parameters do |parameter| parameter.name end
    expect(parameters).to match @expected_parameters
  end

  it "should not have parameter directions" do
    @setAnimal.parameters.each do |parameter|
      expect(parameter.has_direction?).to be false
      expect(parameter.direction).to eq nil
    end
  end

  it "should have parameter types" do
    types = map_node @setAnimal.parameters do |parameter| parameter.type end
    expect(types.map do |type| type.name end).to match @expected_types
    expect(types.map do |type| type.html_name end).to match @expected_html_types
  end

  it "should have one default parameter" do
    expect(@setAnimal.parameters[0].has_default_value?).to be false
    expect(@setAnimal.parameters[1].has_default_value?).to be true
    expect(@setAnimal.parameters[1].default_value).to eq "NULL"
  end

end