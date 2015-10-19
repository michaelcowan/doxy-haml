
describe "Run doxy-haml command line" do

  it "" do
    ARGV = "-i spec/src -o tmp/doc/api".split(" ")
    require_relative "../doxy-haml"
  end

end