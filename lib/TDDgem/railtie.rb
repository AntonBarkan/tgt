require 'TDDgem'
require 'rails'
module MyPlugin
  class Railtie < Rails::Railtie
    railtie_name :TGTgem

    rake_tasks do
      load "tasks/tdd.rake"
    end
  end
end