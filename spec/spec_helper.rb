require 'simplecov'
require 'coveralls'

SimpleCov.start do
  add_filter "/vendor/bundle/"
end

Coveralls.wear!

require_relative '../lib/generator'
require_relative '../lib/parser'

RSpec.configure do |config|
  config.before(:suite) {
    generator = DoxyHaml::Generator.new
    generator.generate "spec/doxygen", "Animal Farm", "spec/src", true
  }
  config.after(:suite) {
    FileUtils.rm_rf "spec/doxygen"
  }
end

def map_node node
  list = []
  node.each do |node|
    list << (yield node)
  end
  list
end

def class_by_name class_name
  @classes.select { |clazz| clazz.name == class_name }.first
end