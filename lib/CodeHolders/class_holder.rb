require 'CodeHolders/attribute_holder'
require 'CodeHolders/method_holder'


  class ClassHolder
    attr_accessor :class_name
    attr_accessor :attribute_holders
    attr_accessor :method_holders

    def initialize(class_name)
      @class_name = class_name
      @attribute_holders = Array.new
      @method_holders = Array.new
    end

    def add_attribute(attribute_name, attribute_type=nil)
      @attribute_holders << AttributeHolder.new(attribute_name, attribute_type)
    end

    def add_method(method_name)
      if method_name.class.equal?(String)
        @method_holders << MethodHolder.new(method_name)
        return
      end
      if method_name.class.equal?(MethodHolder)
        @method_holders << method_name
        return
      end

    end

    def print_code
      retString = '';
      retString = 'class ' + @class_name + "\n";
      @attribute_holders.each do |value|
        retString +="\t" + 'attr_accessor :' + value.attribute_name + "\n"
      end
      @method_holders.each do |value|
        retString += value.print
      end

      retString += 'end'
    end

  end




