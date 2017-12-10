valid = File.read("#{__DIR__}/input.txt")
            .each_line
            .map(&.split)
            .sum do |values|
              values.uniq.size == values.size ? 1 : 0
            end
puts valid
