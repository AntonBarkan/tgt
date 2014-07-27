require 'FeaturesHolder/given_step_holder'
require 'FeaturesHolder/then_step_holder'
require 'FeaturesHolder/when_step_holder'

class ScenarioHolder
  attr_accessor :scenarioName
  attr_accessor :givenSteps
  attr_accessor :whenSteps
  attr_accessor :thenSteps



  def initialize(scenario_array)
    scenario_array.each_with_index do |line, index|
      if !line.lstrip.empty?
        if line.lstrip.start_with? 'Scenario:'
          @scenarioName = line.sub('Scenario:',' ' ).lstrip
          scenario_array = scenario_array[(index+1)..scenario_array.size]
          break
        end
      end
    end
    @givenSteps = Array.new
    @whenSteps = Array.new
    @thenSteps = Array.new
    scenario_array.each_with_index do |line, index|
      if !line.lstrip.empty?
        if line.lstrip.start_with? 'Given'
          @givenSteps << GivenStepHolder.new(line.sub('Given',' ' ).lstrip)
        end
        if line.lstrip.start_with? 'When'
          @whenSteps << WhenStepHolder.new(line.sub('When',' ' ).lstrip)
        end
        if line.lstrip.start_with? 'Then'
          @thenSteps << ThenStepHolder.new(line.sub('Then',' ' ).lstrip)
        end
      end
    end
  end
end