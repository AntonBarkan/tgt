class StepHolder

  attr_accessor :stepLine
  attr_accessor :lineNumberInStepsFile

  def pars(line)
     @stepLine = line.lstrip
     puts 'text = ' + @stepLine
  end

end