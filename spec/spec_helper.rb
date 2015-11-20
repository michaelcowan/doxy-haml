require 'simplecov'
require 'coveralls'

SimpleCov.start do
  add_filter "/vendor/bundle/"
end

Coveralls.wear!

require_relative '../lib/helpers'
require_relative '../lib/generator'
require_relative '../lib/parser'

include DoxyHaml::Helpers

RSpec.configure do |config|
  config.before(:suite) {
    generator = DoxyHaml::Generator.new
    generator.generate "spec/doxygen", "spec/src", true
  }
  config.after(:suite) {
    FileUtils.rm_rf "spec/doxygen"
  }
end

def namespace_by_name namespaces, namespace_name, number = 0
  namespaces.select { |namespace| namespace.name == namespace_name }[number]
end

def class_by_name classes, class_name, number = 0
  classes.select { |clazz| clazz.name == class_name }[number]
end

def function_by_name functions, function_name, number = 0
  functions.select { |function| function.name == function_name }[number]
end

def enum_by_name enums, enum_name, number = 0
  enums.select { |enum| enum.name == enum_name }[number]
end