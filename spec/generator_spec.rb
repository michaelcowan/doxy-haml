require 'spec_helper'

describe "DoxyHaml Generator" do

  before(:all) do
    @expected_xml_files = [ "classzoo_1_1_animal.xml", "namespacezoo.xml", "index.xml" ]
  end

  it "should generate Doxyfile" do
    expect(File.exists? "spec/doxygen/Doxyfile").to be true
  end

  it "should generate XML" do
    expect(Dir.entries "spec/doxygen/xml").to include *@expected_xml_files
  end

end