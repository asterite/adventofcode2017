input = 289326

directions = [{1, 0}, {0, 1}, {-1, 0}, {0, -1}]
direction = 0
movement = 2
x = 0
y = 0

values = { {0, 0} => 1 }
value = 0

until value > input
  steps = movement / 2
  available = {steps, input}.min
  dx, dy = directions[direction]
  available.times do
    x += dx
    y += dy
    value = values.fetch({x + 1, y}, 0) +
            values.fetch({x + 1, y + 1}, 0) +
            values.fetch({x, y + 1}, 0) +
            values.fetch({x - 1, y + 1}, 0) +
            values.fetch({x - 1, y}, 0) +
            values.fetch({x - 1, y - 1}, 0) +
            values.fetch({x, y - 1}, 0) +
            values.fetch({x + 1, y - 1}, 0)
    values[{x, y}] = value
    break if value > input
  end
  direction = (direction + 1) % directions.size
  movement += 1
end

puts value
