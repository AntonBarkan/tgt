require 'FeaturesHolder/feature_holder'

class FeaturesParser
  attr_accessor :features
  attr_accessor :feature_holder

  def initialize(cucumber_output)
    @features = cucumber_output
  end

  def parse
    @feature_holder = FeatureHolder.new(@features)
  end



end