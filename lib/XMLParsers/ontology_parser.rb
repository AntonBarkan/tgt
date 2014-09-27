require 'nokogiri'
require 'CodeHolders/class_holder'

class OntologyParser

  attr_accessor :ontology
  attr_accessor :classes

  def initialize(file)
    @ontology = Nokogiri::XML(File.open(file))
    @classes = Hash.new
    ontology.search('Declaration//Class').each { |x|
      @classes[x.attr('IRI')[1, x.attr('IRI').length-1]] = ClassHolder.new(x.attr('IRI')[1, x.attr('IRI').length-1])
    }
  end



end


#classes = Hash.new
#ontology.search('Declaration//Class').each { |x|
#  classes[x.attr('IRI')[1, x.attr('IRI').length-1]] = ClassHolder.new(x.attr('IRI')[1, x.attr('IRI').length-1])
#}
#
#ontology.search('ObjectPropertyDomain').length
#
#
#classes.each do |x, _|

#end
