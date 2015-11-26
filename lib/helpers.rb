module DoxyHaml

  module Helpers

    def map_node node
      list = []
      node.each do |node|
        list << (yield node)
      end
      list
    end

    def remove_namespace name
      name.split("::").last
    end

    def add_namespace namespace, name
      "#{namespace}::#{name}"
    end

    def replace_file_in_id id, file
      "#{file}_#{id_to_a_id id}"
    end


    def qualify node, recursive = true
      result = node.name
      if node.has_qualifying_parent?
        p = recursive ? qualify(node.parent) : node.parent.name
        result = add_namespace p, result
      end
      result
    end

    def html_qualify node, recursive = true
      result = node.html_name
      if node.has_qualifying_parent?
        p = recursive ? html_qualify(node.parent) : node.parent.html_name
        result = add_namespace p, result
      end
      result
    end

    def html_qualify_except_self node, recursive = true
      result = node.name
      if node.has_qualifying_parent?
        p = recursive ? html_qualify(node.parent) : node.parent.html_name
        result = add_namespace p, result
      end
      result
    end

    def first_alpha_character string
      /[^a-zA-Z]*([a-zA-Z]).*/.match(string)[1]
    end

    def alpha_name string
      /[^a-zA-Z]*([a-zA-Z]*).*/.match(string)[1]
    end

    def sort_by_name objects
      objects.sort_by { |o| [alpha_name(o.name), o.name[0]] }
    end

    def doxygen_markup doc, to_html = true
      doc.css('programlisting').each { |n| n.name = 'pre'; n['class'] = 'src' }
      doc.css('codeline').each { |n| n.name = 'span'; n['class'] = 'src-line' }
      doc.css('highlight').each { |n| n.name = 'span'; n['class'] = "src-#{n['class']}" }
      doc.css('sp').each { |n| n.replace(" ") }
      # docMarkupType
      doc.css('bold').each { |n| n.name = 'strong' }
      doc.css('emphasis').each { |n| n.name = 'em' }
      doc.css('computeroutput').each { |n| n.name = 'pre' }
      doc.css('subscript').each { |n| n.name = 'sub' }
      doc.css('superscript').each { |n| n.name = 'sup' }
      doc.css('center').each { |n| n.name = 'center' }
      doc.css('small').each { |n| n.name = 'small' }
      # docURLLink
      doc.css('ulink').each { |n| n.name = 'a'; n.attribute('url').name = 'href' }
      # docRefTextType
      doc.css('ref').each do |n|
        n.name = 'a'
        n.attribute('refid').name = 'href'
        n['href'] = id_to_href n['href']
        n.attribute('kindref').remove
      end
      # Generate text/HTML, remove extra spaces and substitute " for '
      (to_html ? doc.inner_html : doc.inner_text).rstrip.gsub(/"/, "'")
    end
    
  end

end

class String

  def squish
    dup.squish!
  end

  def squish!
    gsub!(/\A[[:space:]]+/, '')
    gsub!(/[[:space:]]+\z/, '')
    gsub!(/[[:space:]]+/, ' ')
    self
  end

end
