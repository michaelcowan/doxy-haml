require 'simplecov'
require 'coveralls'

SimpleCov.start do
  add_filter "/vendor/bundle/"
end

Coveralls.wear!

require_relative '../lib/helpers'
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

def class_by_name classes, class_name
  classes.select { |clazz| clazz.name == class_name }.first
end

def method_by_name methods, method_name
  methods.select { |method| method.name == method_name }.first
end