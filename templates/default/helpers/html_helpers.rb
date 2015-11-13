require 'json'
require 'cgi'

module HtmlHelpers
  
  def function_labels function
    labels = []
    labels << "static" if function.static?
    labels << "pure virtual" if function.pure_virtual?
    labels << "virtual" if function.virtual?
    labels << "constructor" if function.constructor?
    labels << "destructor" if function.destructor?
    labels
  end

  def variable_labels variable
    labels =[]
    labels << "static" if variable.static?
    labels
  end

  def html_fully_qualified_names_as_sentence objects
    objects.map { |m| m.html_fully_qualified_name }.to_sentence
  end

  def lunr_data
    data =[]
    data = get_lunr_objects(classes, "class") 
    data += get_lunr_objects(namespaces, "namespace")
    data += get_lunr_objects(functions, "function")
    data += get_lunr_objects(variables, "variable")
    data += get_lunr_objects(enumerations, "enumeration")
    data += get_lunr_objects(enumerators, "enumerator")
    data
  end

  def get_lunr_objects nodes, type
    nodes.map do |node|
      object_for_lunr node, type
    end
  end

  def object_for_lunr node, type
    {
      id: CGI::escapeHTML(node.html_name),
      name: node.name,
      brief: node.brief,
      description: node.description,
      type: type,
    }
  end

end

class Object; def ensure_array; [self] end end
class Array; def ensure_array; to_a end end
class NilClass; def ensure_array; to_a end end

class Array
  def to_sentence
    case length
    when 0 
      ""
    when 1
      self[0].to_s
    else
      self[0..-2].join(", ") + " and " + self[-1]
    end
  end
end
