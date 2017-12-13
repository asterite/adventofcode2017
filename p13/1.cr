severity = File.read("#{__DIR__}/input.txt")
               .lines
               .map(&.split(": ").map(&.to_i))
               .sum do |(time, range)|
                 time.divisible_by?(2*range - 2) ? time * range : 0
               end
puts severity
