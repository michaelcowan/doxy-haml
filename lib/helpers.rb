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

    def parse_doxygen_description xpath
      doxygen_markup xpath, false
    end

    def parse_doxygen_description_to_html xpath
      doxygen_markup xpath, true
    end

    def doxygen_markup doc, to_html = true
      # NOTE Never replace a tag with 'p' or 'div' as these has specific nesting rules that could break rendering
      
      # Changes should only affect this call, not the underlying parsed data
      doc = doc.dup
      # If there is only one param, do not wrap in a span
      #doc = doc.css('para') if doc.css('para').count == 1
      # These are parsed out to specific variables and must be removed e.g. author, param etc
      doc.css('simplesect').each { |n| n.remove }
      doc.css('parameterlist').each { |n| n.remove }

      if to_html
        # listingType and sub-types
        doc.css('programlisting').each { |n| n.name = 'pre'; n['class'] = 'src' }
        doc.css('codeline').each { |n| n.name = 'span'; n['class'] = 'src-line' }
        doc.css('highlight').each { |n| n.name = 'span'; n['class'] = "src-#{n['class']}" }
        
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
        # docTableType
        doc.css('table').each do |table|
          table.attribute('cols').remove
          table.attribute('rows').remove
          table.css('row').each do |row|
            row.css('entry').each do |entry|
              entry.name = (entry['thead'] == 'yes' ? 'th' : 'td')
              entry.attribute('thead').remove
            end
            row.name = 'tr'
          end
        end
        # Strip empty para tags and convert remaining to spans
        doc.css('para').each do |para|
          para.name = 'span'; para['class'] = 'para' 
          para.remove if para.content.strip.empty?
        end
      else
        # Strip empty para tags and replace with newline character
        doc.css('para').each do |para| 
          para.replace("\n#{para.inner_text}")
          para.remove if para.content.strip.empty?
        end
      end

      # Strip trailing spaces inside tags
      doc.xpath('//text()[last()]').each{ |t| t.content = t.content.rstrip }

      # Insert explicit spaces
      doc.css('sp').each { |n| n.replace(" ") }

      # Generate text/HTML, remove starting new lines, remove trailing spaces and substitute " for '
      (to_html ? doc.inner_html : doc.inner_text).gsub(/^\n/, "").rstrip.gsub(/"/, "'")
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
