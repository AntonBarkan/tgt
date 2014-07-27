require 'StepsHolder/step_holder'

class StepsHolder
  attr_accessor :steps

  def initialize (cucumber_output)
    lines = cucumber_output.split("\n")
    @steps = Array.new
    firstIndex = 0
    lastIndex = -1
    lines.each_with_index do |line, index|
      if line == 'You can implement step definitions for undefined steps with these snippets:'
        lastIndex = index
        break
      end
    end
    lines = lines[lastIndex+1..lines.size]
    while true
      firstIndex = -1
      lastIndex = -1
      lines.each_with_index do |line, index|
        if line.include? 'Given' or line.include? 'When' or line.include? 'Then'    #TODO start from
          firstIndex = index
          break
        end
      end
      lines.each_with_index do |line, index|
        if line == 'end'
          lastIndex = index
          break
        end
      end

      if lastIndex == -1 or firstIndex == -1
        break
      else
        step = lines[firstIndex..lastIndex]
        @steps << StepHolder.new(step)
      end
      lines = lines[lastIndex+1..lines.size]
    end

    def find_feature_line(feature_holder)

        @steps.each do |step|
          step.find_feature_line(feature_holder)
         end

    end



  end
end