require 'FeaturesHolder/step_holder'

class ThenStepHolder < StepHolder
  def initialize(step)
    pars step
  end
end