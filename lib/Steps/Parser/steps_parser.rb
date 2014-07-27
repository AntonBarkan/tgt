require 'StepsHolder/steps_holder'

class StepsParser
  attr_accessor :steps_holder

  def initialize (cucumber_output)
    @steps_holder = StepsHolder.new(cucumber_output)
  end

  def connect_features_to_steps(feature_holder)
    @steps_holder.find_feature_line(feature_holder)
  end



end