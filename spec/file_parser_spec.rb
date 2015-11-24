require 'spec_helper'

describe "DoxyHaml File Parser" do

  before(:all) do
    parser = DoxyHaml::Parser.new "spec/doxygen/xml"
    @file = file_by_name parser.index.files, "misc.h"
  end

  it "should have a program listing" do
    expected_source = [
      "<span class='src-preprocessor'>#ifndef MISC_H</span><span class='src-normal'></span>",
      "<span class='src-normal'></span><span class='src-preprocessor'>#define MISC_H</span><span class='src-normal'></span>",
      "<span class='src-normal'></span>",
      "<span class='src-keyword'>struct </span><span class='src-normal'><a href='struct_rect.html'>Rect</a> {</span>",
      "<span class='src-normal'>  </span><span class='src-keywordtype'>int</span><span class='src-normal'> <a href='struct_rect.html#1a64d1ef14e429e1816539de4c54361e55'>x</a>;</span>",
      "<span class='src-normal'>  </span><span class='src-keywordtype'>int</span><span class='src-normal'> <a href='struct_rect.html#1a1e37b6f8a4fb0d68ba22c8fffffab0a4'>y</a>;</span>",
      "<span class='src-normal'>  </span><span class='src-keywordtype'>int</span><span class='src-normal'> <a href='struct_rect.html#1a367714e71d566668addb140c7981b5bc'>width</a>;</span>",
      "<span class='src-normal'>  </span><span class='src-keywordtype'>int</span><span class='src-normal'> <a href='struct_rect.html#1ad79d7bf12771a81627a672452437011d'>height</a>;</span>",
      "<span class='src-normal'>};</span>",
      "<span class='src-normal'></span>",
      "<span class='src-normal'><a href='struct_rect.html'>Rect</a> * rect32();</span>",
      "<span class='src-normal'></span>",
      "<span class='src-keyword'>static</span><span class='src-normal'> <a href='struct_rect.html'>Rect</a> * emptyRect();</span>",
      "<span class='src-normal'></span>",
      "<span class='src-keyword'>enum</span><span class='src-normal'> Direction {</span>",
      "<span class='src-normal'>  Up,</span>",
      "<span class='src-normal'>  Down,</span>",
      "<span class='src-normal'>  Left,</span>",
      "<span class='src-normal'>  Right</span>",
      "<span class='src-normal'>};</span>",
      "<span class='src-normal'></span>",
      "<span class='src-keywordtype'>float</span><span class='src-normal'> pi;</span>",
      "<span class='src-normal'></span>",
      "<span class='src-keyword'>static</span><span class='src-normal'> </span><span class='src-keywordtype'>float</span><span class='src-normal'> e;</span>",
      "<span class='src-normal'></span>",
      "<span class='src-normal'></span><span class='src-preprocessor'>#endif // MISC_H</span>"
    ]
    expect(@file.source).to eq expected_source

  end

end