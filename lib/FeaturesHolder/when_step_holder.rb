require 'FeaturesHolder/step_holder'

class WhenStepHolder < StepHolder
  def initialize(step)
    pars step
  end
end