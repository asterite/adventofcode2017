scanners = File.read("#{__DIR__}/input.txt")
               .lines
               .map(&.split(": ").map(&.to_i))

delay = 0
while scanners.any? { |(time, range)| (delay + time).divisible_by?(2*range - 2) }
  delay += 1
end
puts delay
