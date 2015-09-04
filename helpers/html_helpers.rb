module HtmlHelpers
  def link_to *args, &block
    if block_given?
      url = args[0]
      # TODO
    else
      name, url = args[0], args[1]
      "<a href=#{url}>#{name}</a>"
    end
  end
end