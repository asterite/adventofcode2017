checksum = File.read("#{__DIR__}/input.txt")
               .each_line
               .map(&.split.map(&.to_i))
               .map(&.minmax)
               .sum { |min, max| max - min }
puts checksum
