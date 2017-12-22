def expand_rule(rule, n, d1, d2, d3)
  (d1 ? 0.to(n) : n.to(0)).map do |y|
    (d2 ? 0.to(n) : n.to(0)).map do |x|
      d3 ? rule[y][x] : rule[x][y]
    end.to_a
  end.to_a
end

def matches?(pixels, pattern, x, y)
  (0...pattern.size).all? do |py|
    (0...pattern.size).all? do |px|
      pixels[y + py][x + px] == pattern[py][px]
    end
  end
end

def copy(pixels, pattern, x, y)
  pattern.size.times do |py|
    pattern.size.times do |px|
      pixels[y + py][x + px] = pattern[py][px]
    end
  end
end

rules = {} of Array(Array(Char)) => Array(Array(Char))

input = File.read("#{__DIR__}/input.txt")
input.lines.each do |line|
  from, to = line.split(" => ").map(&.split('/').map(&.chars))
  n = from.size - 1
  8.times do |i|
    rules[expand_rule(from, n, i.bit(2) == 1, i.bit(1) == 1, i.bit(0) == 1)] = to
  end
end

pixels = [
  ['.', '#', '.'],
  ['.', '.', '#'],
  ['#', '#', '#'],
]

18.times do
  size = pixels.size
  square_size = size.divisible_by?(2) ? 2 : 3
  new_square_size = square_size + 1
  new_size = size / square_size * (square_size + 1)
  next_pixels = Array.new(new_size) { Array.new(new_size) { '-' } }
  0.step(by: square_size, to: size - 1) do |y|
    0.step(by: square_size, to: size - 1) do |x|
      pattern = rules.find do |(from, to)|
        from.size == square_size && matches?(pixels, from, y, x)
      end.not_nil![1]
      copy(next_pixels, pattern,
        (y/square_size)*new_square_size,
        (x/square_size)*new_square_size)
    end
  end
  pixels = next_pixels
end

puts pixels.sum &.count('#')
