require 'spec_helper'

describe "DoxyHaml Namespace Parser" do

  before(:all) do
    @expected_classes = [ "Application", "Array", "BasicEffect", "Blend", "ByteArrayInputStream", "Color", "ColorMask", "DepthStencil", "FileInputStream", "Graphics", "IndexBuffer", "IndexBufferSafe", "InputStream", "Integer", "Log", "Math", "Matrix", "Rasterizer", "Rect", "Renderable", "RenderableFormat", "Screen", "Shader", "ShaderInfo", "ShaderSource", "String", "Texture", "TextureHint", "TextureInfo", "UniformMetaData", "UniformType", "Vector2", "Vector3", "Version", "VertexBuffer", "VertexBufferSafe", "VertexMetaData", "VertexPositionColor", "VertexPositionTexture", "VertexType", "Viewport" ]
    
    parser = DoxyHaml::Parser.new "spec/xml"
    @namespace = parser.index.namespaces.first
  end

  it "should have a name" do
    expect(@namespace.name).to eq "eve"
    expect(@namespace.html_name).to eq "<a href='namespaceeve.html'>eve</a>"
  end

  it "should have class(es)" do
    class_names = map_node @namespace.classes do |clazz| clazz.name end
    expect(class_names).to match_array @expected_classes
  end

end