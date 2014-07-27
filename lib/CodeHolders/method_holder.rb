class MethodHolder
  attr_accessor :method_name
  attr_accessor :method_return_type
  attr_accessor :parameters

  def initialize(method_name)
    @method_name = method_name
    @parameters = Array.new
  end

  def addParameter(field)
    @parameters << field
  end

  def print
    methodString = 'def ' + method_name
    if !@parameters.empty?
      methodString += '('
    end
    @parameters.each_with_index do |param, index|
      methodString += param
      if index != @parameters.size - 1
       methodString += ', '
      end
    end
    if !@parameters.empty?
      methodString += ')'
    end
    methodString += "\n"
    methodString += "end\n"
  end

end