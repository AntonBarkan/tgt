class StepHolder

  attr_accessor :stepLine
  attr_accessor :lineNumberInStepsFile

  def pars(line)
     @stepLine = line.lstrip
  end

end