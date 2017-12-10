valid = File.read("#{__DIR__}/input.txt")
            .each_line
            .map(&.split)
            .sum do |values|
              chargroups = values.map(&.chars.group_by(&.itself))
              chargroups.uniq.size == chargroups.size ? 1 : 0
            end
puts valid
