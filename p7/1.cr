nodes = [] of String
down = {} of String => String

lines = File.read("#{__DIR__}/input.txt").lines
lines.each do |line|
  pieces = line.split("->")
  left = pieces[0]
  left = left.split[0]

  nodes << left

  if pieces.size > 1
    right = pieces[1].split(",").map(&.strip)
    right.each do |disk|
      down[disk] = left
    end
  end
end

base = nodes.find { |node| !down.has_key?(node) }
puts base
