UP        = {0, -1}
DOWN      = {0, 1}
LEFT      = {-1, 0}
RIGHT     = {1, 0}
OPPOSITES = {UP => DOWN, DOWN => UP, LEFT => RIGHT, RIGHT => LEFT}
PATH      = {UP => '|', DOWN => '|', LEFT => '-', RIGHT => '-'}

def fetch(map, x, y)
  return ' ' unless 0 <= y < map.size

  row = map[y]
  return ' ' unless 0 <= x < row.size

  row[x]
end

map = File.read("#{__DIR__}/input.txt").lines.map(&.chars)

x = map[0].index('|').not_nil!
y = 0
dir = DOWN

letters = [] of Char

loop do
  curr = fetch(map, x, y)
  break if curr == ' '

  letters << curr if curr.letter?

  if curr == '+'
    opposite = OPPOSITES[dir]

    {UP, DOWN, LEFT, RIGHT}.find do |alt_dir|
      next if alt_dir == opposite

      obj = fetch(map, x + alt_dir[0], y + alt_dir[1])
      obj = PATH[alt_dir] if obj.letter?

      if obj == PATH[alt_dir]
        dir = alt_dir
        break
      end
    end
  end

  x, y = x + dir[0], y + dir[1]
end

puts letters.join
