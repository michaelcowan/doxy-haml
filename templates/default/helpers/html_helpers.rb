module HtmlHelpers
  
  def method_labels method
    labels = []
    labels << "static" if method.static?
    labels << "pure virtual" if method.pure_virtual?
    labels << "virtual" if method.virtual?
    labels << "constructor" if method.constructor?
    labels << "destructor" if method.destructor?
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
