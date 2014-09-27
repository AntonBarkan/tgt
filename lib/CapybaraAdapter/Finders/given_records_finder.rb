class GivenRecordsFinder
  attr_accessor :ontology

  def  initialize (ontology)
    @ontology = ontology
  end

  def finder(row)
    row = row.params_line
    if /.+record/ =~ row or /.+records/ =~ row
      name = @ontology.find_posible_record(row);
      if (name.nil?)
        entity = row.match(/(\w+) record/).captures
        entity[0].capitalize![0]
        name = entity[0]
      end
      "table.hashes.each do |hash|\n"+
        "\t\t#{name.capitalize![0]+name[1..name.length]}.create(hash).save\n"+
      "\tend"
  # TODO several matches?
    end
  end
end




