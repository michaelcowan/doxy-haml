def map_node node
  list = []
  node.each do |node|
    list << (yield node)
  end
  list
end
