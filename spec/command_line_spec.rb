
describe "Run doxy-haml command line" do

  it "" do
    ARGV = "-i spec/src -o tmp/doc/api -t templates/default -n Test".split(" ")
    require_relative "../doxy-haml"
  end

end