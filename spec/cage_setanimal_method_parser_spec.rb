require 'spec_helper'

describe "DoxyHaml Cage setAnimal Method Parser" do

  before(:all) do
    @expected_parameters = ["animal", "mate"]
    @expected_types = ["Animal *", "Animal *"]
    @expected_html_types = ["<a href='classzoo_1_1_animal.html'>Animal</a> *", "<a href='classzoo_1_1_animal.html'>Animal</a> *"]
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    namespace = namespace_by_name parser.index.namespaces, "zoo"
    cage = class_by_name namespace.classes, "Cage"
    @setAnimal = method_by_name cage.public_methods, "setAnimal"
  end

  it "should have a name" do
    expect(@setAnimal.name).to eq "setAnimal"
  end

  it "should have an html name" do
    expect(@setAnimal.html_name).to match /<a href='classzoo_1_1_cage.html#\w{34}'>setAnimal<\/a>/
  end

  it "should have a fully qualified name" do
    expect(@setAnimal.fully_qualified_name).to eq "zoo::Cage::setAnimal"
  end

  it "should have an html fully qualified name" do
    expect(@setAnimal.html_fully_qualified_name).to match /<a href='namespacezoo.html'>zoo<\/a>::<a href='classzoo_1_1_cage.html'>Cage<\/a>::<a href='classzoo_1_1_cage.html#\w{34}'>setAnimal<\/a>/
  end

  it "should have an anchor" do
    expect(@setAnimal.anchor).to match /\w{34}/
  end

  it "should have an html anchor" do
    expect(@setAnimal.html_anchor).to match /<a id='\w{34}'\/>/
  end

  it "should have a definition" do
    expect(@setAnimal.definition).to eq "bool zoo::Cage::setAnimal(Animal *animal, Animal *mate=NULL)"
  end

  it "should have an html definition" do
    expect(@setAnimal.html_definition).to eq "bool <a href='namespacezoo.html'>zoo</a>::<a href='classzoo_1_1_cage.html'>Cage</a>::setAnimal(<a href='classzoo_1_1_animal.html'>Animal</a> * animal, <a href='classzoo_1_1_animal.html'>Animal</a> * mate=NULL)"
  end

  it "should have a brief" do
    expect(@setAnimal.has_brief?).to be true
    expect(@setAnimal.brief).to eq "Sets the Animal."
  end

  it "should have an html brief" do
    expect(@setAnimal.has_brief?).to be true
    expect(@setAnimal.html_brief).to eq "Sets the <a href='classzoo_1_1_animal.html'>Animal</a>."
  end

  it "should have a description" do
    expect(@setAnimal.has_description?).to be true
    expect(@setAnimal.description).to eq "Puts an Animal in this Cage."
  end

  it "should have an html description" do
    expect(@setAnimal.has_description?).to be true
    expect(@setAnimal.html_description).to eq "Puts an <a href='classzoo_1_1_animal.html'>Animal</a> in this <a href='classzoo_1_1_cage.html'>Cage</a>."
  end

  it "should have a return brief" do
    expect(@setAnimal.has_return_brief?).to be true
    expect(@setAnimal.return_brief).to eq "true if the Animal can be put in this cage."
  end

  it "should have an html return brief" do
    expect(@setAnimal.has_return_brief?).to be true
    expect(@setAnimal.html_return_brief).to eq "true if the <a href='classzoo_1_1_animal.html'>Animal</a> can be put in this cage."
  end

  it "should have a return type" do
    expect(@setAnimal.has_return_type?).to be true
    expect(@setAnimal.return_type.name).to eq "bool"
  end

  it "should have an html return type" do
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

  it "should have parameter description" do
    expect(@setAnimal.parameters.first.has_description?).to be true
    expect(@setAnimal.parameters.first.description).to eq "The Animal to put in this Cage."
  end

  it "should have parameter html description" do
    expect(@setAnimal.parameters.first.has_description?).to be true
    expect(@setAnimal.parameters.first.html_description).to eq "The <a href='classzoo_1_1_animal.html'>Animal</a> to put in this <a href='classzoo_1_1_cage.html'>Cage</a>."
  end

  it "should not implement from parent" do
    expect(@setAnimal.reimplements?).to be false
  end

  it "should not be reimplemented by" do
    expect(@setAnimal.reimplementedby?).to be false
  end

end