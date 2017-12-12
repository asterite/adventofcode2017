x = 0
y = 0

input = File.read("#{__DIR__}/input.txt").strip
input.split(",").each do |direction|
  case direction
  when "n"  then y += 2
  when "s"  then y -= 2
  when "ne" then x += 1; y += 1
  when "se" then x += 1; y -= 1
  when "nw" then x -= 1; y += 1
  when "sw" then x -= 1; y -= 1
  end
end

x = x.abs
y = y.abs

steps = x + (y - {x, y}.min)/2
puts steps
