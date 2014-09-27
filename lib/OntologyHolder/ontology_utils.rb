require 'XMLParsers/ontology_parser'

class OntologyUtils
  #TBI mock dont use really ontology need

  attr_accessor :ontology_holder
  attr_accessor :classesHash
  attr_accessor :ontologyParser

  def initialize (file) #TODO init ontology holder or set like constructor parameter
    @ontologyParser =  OntologyParser.new(file)
    @classesHash =  @ontologyParser.classes
  end

  def go (steps_holder)#is it right place for method?
      steps_holder.steps.each do |step|
        if step.innerCode.empty?
          find step
        end
      end
  end

  def find (step)
      class_matcher step
  end

  def class_matcher (step)#TODO use real ontology
     #TODO list from ontology
     if /user/ =~ step.params_line
       step.innerCode += '@user = arg1' + "\n";
     end
    if /password/ =~ step.params_line
      step.innerCode +='@password = arg2'
    end
  end

  def prop_matcher

  end

  def find_posible_page (line)
    @classesHash.each do |x, _|
      if (line.downcase.include? x.downcase)
        return x.downcase
      end

    end
    return nil
  end

  def find_posible_content (line)
    arr = Array.new
    @classesHash.each do |x, _|
      if (line.include? x)
         arr << x
      end

    end
    return arr.length == 0 ? nil : arr
  end

  def find_posible_record (line)
    @classesHash.each do |x, _|
       if (line.downcase.include? x.downcase)
         return x.downcase
       end

    end
    return nil
  end


end