

module TDDgem
  require "TDDgem/version"
  require 'CucumberRuner/cucumber_runner'
  require 'TDDgem/railtie' if defined?(Rails)
 #(CucumberRunner.new).run
end
