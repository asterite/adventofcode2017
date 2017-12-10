instructions = File.read("#{__DIR__}/input.txt").split.map(&.to_i)

pc = 0
steps = 0

while instruction = instructions[pc]?
  instructions[pc] = instruction + 1
  pc += instruction
  steps += 1
end

puts steps
