input = 289326

directions = [{1, 0}, {0, 1}, {-1, 0}, {0, -1}]
direction = 0
movement = 2
x = 0
y = 0

input -= 1

while input > 0
  steps = movement / 2
  available = {steps, input}.min
  dx, dy = directions[direction]
  x += dx * available
  y += dy * available
  input -= available
  direction = (direction + 1) % directions.size
  movement += 1
end

distance = x.abs + y.abs

puts distance
