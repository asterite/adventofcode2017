checksum = File.read("#{__DIR__}/input.txt")
               .each_line
               .map(&.split.map(&.to_i))
               .map do |row|
                 value = nil
                 row.each_with_index do |c1, i|
                   row.each_with_index do |c2, j|
                     if i != j && c1.divisible_by?(c2)
                       value = c1 / c2
                       break
                     end
                   end
                   break if value
                 end
                 value.not_nil!
               end
               .sum
puts checksum
