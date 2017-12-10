banks = File.read("#{__DIR__}/input.txt").split.map(&.to_i)

steps = 0

seen = Set{banks.dup}
occurrences = {banks.dup => steps}
loop_size = nil

loop do
  steps += 1

  index = banks.each_index.max_by { |i| banks[i] }

  value = banks[index]
  banks[index] = 0

  value.times do |i|
    banks[(index + 1 + i) % banks.size] += 1
  end

  if seen.includes?(banks)
    loop_size = steps - occurrences[banks]
    break
  end

  seen << banks.dup
  occurrences[banks.dup] = steps
end

puts loop_size
