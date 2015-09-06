require 'spec_helper'

describe "DoxyHaml Namespace Parser" do

  before(:all) do
    @expected_classes = ["Animal", "Cage", "Monkey"]

    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    @namespace = parser.index.namespaces.first
  end

  it "should have a name" do
    expect(@namespace.name).to eq "zoo"
    expect(@namespace.html_name).to eq "<a href='namespacezoo.html'>zoo</a>"
  end

  it "should have class(es)" do
    class_names = map_node @namespace.classes do |clazz| clazz.name end
    expect(class_names).to match_array @expected_classes
  end

end