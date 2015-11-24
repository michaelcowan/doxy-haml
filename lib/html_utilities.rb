require_relative 'helpers'

module DoxyHaml

  module HtmlUtilities
    include Helpers

    def link_to *args, &block
      if block_given?
        # TODO url = args[0]
      else
        name, url = args[0], args[1]
        "<a href='#{url}'>#{name}</a>"
      end
    end

    def anchor_for id
      "<a id='#{id}'/>"
    end

    def id_to_href id
      return "#{id}.html" unless /_[a-z0-9]{34,}/.match id
      *a, b = id.split('_', -1)
      "#{a.join('_')}.html##{b}"
    end

    def id_to_a_id id
      raise "String does not contain an id" unless id =~ /[a-zA-Z0-9]{34}$/
      id.split('_').last
    end

    def doxygen_markup_to_html doc
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
      # Generate HTML, remove extra spaces and substitute " for '
      doc.inner_html.strip.gsub /"/, "'"
    end

  end

end