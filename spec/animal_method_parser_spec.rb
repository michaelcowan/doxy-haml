require 'spec_helper'

describe "DoxyHaml Animal Method Parser" do

  before(:all) do
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    classes = parser.index.namespaces.first.classes
    animal = class_by_name classes, "Animal"
    @getNumberOfLegs = method_by_name animal.public_methods, "getNumberOfLegs"
  end

  it "should have a name" do
    expect(@getNumberOfLegs.name).to eq "getNumberOfLegs"
  end

  it "should have an anchor" do
    expect(@getNumberOfLegs.anchor).to match /classzoo_1_1_animal_\w{34}/
    expect(@getNumberOfLegs.html_anchor).to match /<a href='#classzoo_1_1_animal_\w{34}'>getNumberOfLegs<\/a>/
  end

end