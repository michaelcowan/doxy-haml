require 'rspec'

require_relative 'helpers'
require_relative '../lib/parser'

describe "DoxyHaml Index Parser" do

  before(:all) do
    @expected_namespaces = [ "eve" ]
    @expected_classes = [ "Application", "Array", "BasicEffect", "Blend", "ByteArrayInputStream", "Color", "ColorMask", "DepthStencil", "FileInputStream", "Graphics", "IndexBuffer", "IndexBufferSafe", "InputStream", "Integer", "Log", "Math", "Matrix", "Rasterizer", "Rect", "Renderable", "RenderableFormat", "Screen", "Shader", "ShaderInfo", "ShaderSource", "String", "Texture", "TextureHint", "TextureInfo", "UniformMetaData", "UniformType", "Vector2", "Vector3", "Version", "VertexBuffer", "VertexBufferSafe", "VertexMetaData", "VertexPositionColor", "VertexPositionTexture", "VertexType", "Viewport" ]
    
    parser = DoxyHaml::Parser.new "spec/xml"
    @index = parser.index
  end

  it "should have namespace(s)" do
    namespace_names = map_node @index.namespaces do |namespace| namespace.name end
    expect(namespace_names).to match_array @expected_namespaces
  end

  it "should have class(es)" do
    class_names = map_node @index.classes do |clazz| clazz.name end
    expect(class_names).to match_array @expected_classes
  end

end