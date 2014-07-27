class StepHolder

  attr_accessor :innerCode
  attr_accessor :params_line
  attr_accessor :parameters
  attr_accessor :feature_lines
  attr_accessor :numberOfArguments
  attr_accessor :type

  #attr_accessor :feature_holder
  #attr_accessor :scenario_holders
  #attr_accessor :steps

  def initialize(step)
    @innerCode = ''
    @params_line = step[0][step[0].index('/')+1..step[0].rindex('/')-1]
    if step[0].include? "|"
      parametersLine = step[0][step[0].index('|')+1..step[0].rindex('|')-1]
    end
    @parameters = pars_parameters parametersLine
    @numberOfArguments = @parameters.size
    @feature_lines = Array.new
  end

  def pars_parameters(parameters_line)
    retArray = Array.new
    if parameters_line == nil
      return retArray
    end
    parameters_line.split(',').reject{ |e| e.empty?}.each do |s|
      retArray << s.lstrip
    end
    retArray
  end

  def find_feature_line(feature_holder)
    feature_holder.scenarioHolders.each do |scenario|
        scenario.givenSteps.each do |step|
            if /#{@params_line}/ =~ step.stepLine
              @feature_lines << step
              @type = 'Given'
            end
        end
        scenario.whenSteps.each do |step|
          if /#{@params_line}/ =~ step.stepLine
            @feature_lines << step
            @type = 'When'
          end
        end
        scenario.thenSteps.each do |step|
          if /#{@params_line}/ =~ step.stepLine
            @feature_lines << step
            @type = 'Then'
          end
        end
    end
  end

  def addLine(line)
    @innerCode += "\n\t" + line
  end


  def parameters_string
    str = String.new
    if @parameters.empty?
      return str
    end
    @parameters.each_with_index do |parameter, index|

      str.concat parameter
      if index != @parameters.size - 1
        str.concat ', '
      end
    end
    str
  end

  def type
     @type
  end

end