require 'spec_helper'

describe "DoxyHaml Class Parser" do

  before(:all) do
    @expected_public_methods = ["renderable", "blend", "blend", "colorMask", "colorMask", "depthStencil", "depthStencil", "rasterizer", "rasterizer", "viewport", "viewport", "scissor", "scissor", "clear", "clear", "clear", "render", "render", "render", "render", "render", "render", "render", "render"]
    parser = DoxyHaml::Parser.new "spec/xml"
    @classes = parser.index.namespaces.first.classes
    @graphics = class_by_name "Graphics"
  end

  it "should have a name" do
    expect(@graphics.name).to eq "Graphics"
    expect(@graphics.html_name).to eq "<a href='classeve_1_1Graphics.html'>Graphics</a>"
  end

  it "should have a qualified name" do
    expect(@graphics.qualified_name).to eq "eve::Graphics"
    expect(@graphics.html_qualified_name).to eq "<a href='classeve_1_1Graphics.html'>eve::Graphics</a>"
  end

  it "should be abstract" do
    expect(@graphics.abstract?).to be true
  end

  it "should have public method(s)" do
    public_method_names = map_node @graphics.public_methods do |method| method.name end
    expect(public_method_names).to match_array @expected_public_methods
  end

end