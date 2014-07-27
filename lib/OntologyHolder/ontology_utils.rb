class OntologyUtils
  #TBI mock dont use really ontology need

  attr_accessor :ontology_holder

  def initialize #TODO init ontology holder or set like constructor parameter

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


end