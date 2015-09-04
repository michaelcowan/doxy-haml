module TypeHelpers
  def type_link type
    if type.nested_local_types.empty?
      type.name
    else
      nested_type = type.nested_local_types.first.to_s
      # byebug if type.name.include? "VertexType"
      type.name.sub nested_type, link_to(nested_type, "#{type.refid}.html")
    end
  end
end