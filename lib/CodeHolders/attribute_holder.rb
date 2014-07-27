class AttributeHolder
  attr_accessor :attribute_name
  attr_accessor :attribute_type


  def initialize(attribute_name, attribute_type = null)
    @attribute_name = attribute_name
    @attribute_type = attribute_type
  end
end
