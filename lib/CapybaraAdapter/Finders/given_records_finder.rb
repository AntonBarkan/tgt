class GivenRecordsFinder
  def self.finder(row)
    row = row.params_line
    if /.+record/ =~ row or /.+records/ =~ row
      entity = row.match(/(\w+) record/).captures
      entity[0].capitalize![0]
      "table.hashes.each do |hash|\n"+
        "\t#{entity[0]}.create(hash).save\n"+
      "end\n"
  # TODO several matches
    end
  end
end




