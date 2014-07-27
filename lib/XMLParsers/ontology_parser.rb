require 'nokogiri'
require 'CodeHolders/class_holder'

class OntologyParser

  attr_accessor :ontology

  def initialize
    @ontology = Nokogiri::XML(File.open('/home/anton/Documents/project/ATM_new/shopping card.owl'))
  end



end


classes = Hash.new
ontology.search('Declaration//Class').each { |x|
  classes[x.attr('IRI')[1, x.attr('IRI').length-1]] = ClassHolder.new(x.attr('IRI')[1, x.attr('IRI').length-1])
}

ontology.search('ObjectPropertyDomain').length


classes.each do |x, _|

end
