def steps(x, y)
  x = x.abs
  y = y.abs
  x + (y - {x, y}.min)/2
end

x = 0
y = 0
max_steps = 0

input = File.read("#{__DIR__}/input.txt").strip
input.split(",").each_with_index do |direction, i|
  case direction
  when "n"  then y += 2
  when "s"  then y -= 2
  when "ne" then x += 1; y += 1
  when "se" then x += 1; y -= 1
  when "nw" then x -= 1; y += 1
  when "sw" then x -= 1; y -= 1
  end
  max_steps = {max_steps, steps(x, y)}.max
end

puts max_steps
