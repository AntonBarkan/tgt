require 'FeaturesHolder/scenario_holder'

class FeatureHolder

  attr_accessor :featureName
  attr_accessor :scenarioHolders

  def initialize(feature)
    @scenarioHolders = Array.new
    lines = feature.split("\n")
    lines.each_with_index do |line, index|
      if !line.lstrip.empty?
           if line.lstrip.start_with? 'Feature:'
             @featureName = line.sub('Feature:',' ' ).lstrip
             lines = lines[(index+1)..lines.size]
             break
           end
      end
    end

    exit = false

    while !exit
      exit = true
      first_index = -1
      last_index = -1
      lines.each_with_index do |line, index|
        if !line.lstrip.empty?
        exit = false
          if line.lstrip.start_with? 'Scenario:'
            if first_index == -1
              first_index = index
            else
              last_index = index
              break
            end
          end
          if line =~ /s*\d+\s+scenarios/
            last_index = index
            exit = true
            break
          end
        end
      end
      if last_index == -1
        last_index = lines.size
        exit = true
      end
      @scenarioHolders << ScenarioHolder.new(lines[first_index...last_index])
      lines = lines[(last_index-1)..lines.size]
    end
  end

end