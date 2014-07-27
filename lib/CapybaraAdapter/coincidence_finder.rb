require 'CapybaraAdapter/Finders/given_records_finder'

class CoincidenceFinder

  #talk with Daniil
  #TODO who inject it?
  attr_accessor :ontology

  def page_line(step, page_name)
      if (step.type == "Given")
        return "visit '/#{page_name}'"     # TODO several matches
      elsif (step.type == "Then")
        return "current_path.should == '/#{page_name}'"
      end

  end

  def find(step)
    if /on the.+/ =~ step.params_line
      page_name = step.params_line.match(/on the (\w+)/).captures
      return page_line step, page_name[0]
    else if /am at.+/ =~ step.params_line
             if step.parameters.size > 0
               return page_line  step, 'arg1'
             end
         end
    end

    step = step.params_line

    if /press/ =~ step  or
        /push/ =~ step or
        /click/ =~ step or
        /snap/ =~ step or
         /pressure/ =~ step #TODO find argument
      return "click_on arg1"
    end

    if /see/ =~ step  #TODO find argument
      return "page.should have_content(arg1)"
    end

    if /fill/ =~ step or
        /write/ =~ step or
        /wrote/ =~ step or
        /pasted/ =~ step or
        /pad/ =~ step or
        /complete/ =~ step or
        /stuff/ =~ step or
        /inscribe/ =~ step or
        /enter/ =~ step or
        /give/ =~ step
      return "element = page.find_by_id(arg1)\n"   +
      "element.set(arg2)"
    end

    if /email/ =~ step or
        /mail/ =~ step
      if /receive/ =~ step

        step = scan_previous_steps([/email/, /mail/])
        size = step.parameters.size - 1
        step.addLine "@mail_name = #{step.parameters[size]}"
        puts ''
        return '@email = UserMailer.create_signup(@mail_name, "Jojo Binks")' + "\n" +
            '@email.should deliver_to(@mail_name)'
      end
      if /should see/ =~ step
          return '@email.should have_body_text(/#{arg0}/)'
      end
    end

  end

  #TODO create executer, create capybara utils... move this code to executer
  def go(steps_holder)
    #Capybara function
    @steps_holder = steps_holder
     steps_holder.steps.each do |step|
       return_val = GivenRecordsFinder.finder(step)
       if return_val != nil
         step.innerCode = return_val
         next
       end
       return_val = find(step)
       if return_val != nil and !return_val.empty?
         step.innerCode = return_val
         puts return_val
       end
     end
     #Matches to ontology
     @ontology.go steps_holder
  end


  private

  def scan_previous_steps(arr)
    arr.each do |element|
      line = scan_previous_steps_for(element)
      if !line.nil?
        return line
      end
    end
  end

  def scan_previous_steps_for(pattern)
    @steps_holder.steps.each do |step|
      step.feature_lines.each do |line|
        if pattern =~ line.stepLine
          return step
        end
      end
    end
  end
end