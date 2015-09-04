require 'simplecov'

SimpleCov.start

require_relative '../lib/parser'

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