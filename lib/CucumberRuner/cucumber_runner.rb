require 'open3'
require 'Steps/Parser/features_parser'
require 'Steps/Parser/steps_parser'
require 'CapybaraAdapter/coincidence_finder'
require 'OntologyHolder/ontology_utils'


class CucumberRunner
  def  self.print_parameters(step)
    if step.parameters.empty?
      return ""
    end
    "|" +  step.parameters_string + "|"
  end


def run(path)
  runComand = ''
  pipe = Open3.popen3('cucumber /home/anton/RubymineProjects/sample_app/features/my.feature') do |stdin, stdout, stderr, wait_thr|
    cucumberOutput =  stdout.read
    if !stderr.read.strip.empty?
       puts  stderr.read
       puts 'ERROR'
    end






    file = File.open(path, 'r')
    fileText =''
    while (line = file.gets)
      fileText += "#{line}"
    end
    file.close


    fp = FeaturesParser.new(fileText)
    fp.parse

    if !Dir.exists?("/home/anton/Documents/project/tests/mail/step_definitions")
      Dir.mkdir("/home/anton/Documents/project/tests/mail/step_definitions")
    end
    #
    #
    if cucumberOutput.include? 'You can implement step definitions for undefined steps with these snippets:'
      #if !File.exists?("/home/anton/Documents/project/Loggin/features/step_definitions/Loggin_steps.rb")
        puts 'steps file not exists'

        #/home/anton/Documents/project/tests/mail/mail.feature
        #/home/anton/Documents/project/tests/first/first.features
        steps_file = File.open("/home/anton/Documents/project/tests/mail/step_definitions/mail.rb", 'w')
        sp =  StepsParser.new(cucumberOutput)
        #puts cucumberOutput
        steps_file.close
        sp.connect_features_to_steps(fp.feature_holder)

        #filling steps
        coincidence_finder = CoincidenceFinder.new

        # TODO move injection from there
        coincidence_finder.ontology = OntologyUtils.new

        coincidence_finder.go sp.steps_holder

        sp.steps_holder.steps.each do |step|
          puts step.type + " /" + step.params_line + "/ do "+ CucumberRunner.print_parameters(step) +"\n"
          puts "\t" + step.innerCode + "\n"
          puts 'end'
        end

      #else
      #  puts 'steps file exists'
      #end
    end
  end
end
  end

#(CucumberRunner.new).run()



