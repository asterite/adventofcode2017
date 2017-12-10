sum = 0

input = File.read("#{__DIR__}/input.txt").strip
input.each_char_with_index do |char, i|
  next_char = input[(i + input.size/2) % input.size]
  sum += char.to_i if char == next_char
end

puts sum
