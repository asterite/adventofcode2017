def knot_hash(input)
  nums = (0..255).to_a
  skip_size = 0
  pos = 0

  lengths = input.bytes.map(&.to_i)
  lengths.concat([17, 31, 73, 47, 23])

  64.times do
    lengths.each do |length|
      (length/2).times do |i|
        nums.swap((pos + i) % nums.size, (pos + length - 1 - i) % nums.size)
      end
      pos += length + skip_size
      skip_size += 1
    end
  end

  nums
    .each_slice(16)
    .map { |chunk| chunk.reduce { |a, b| a ^ b } }
    .map { |num| sprintf("%02s", num.to_s(16)) }
    .join
end

def flood(grid, regions, x, y, region_count)
  return false unless grid[x][y]
  return false if regions[x][y] != 0

  stack = [{x, y}]

  while pos = stack.pop?
    x, y = pos
    regions[x][y] = region_count

    { {1, 0}, {-1, 0}, {0, 1}, {0, -1} }.each do |dx, dy|
      nx = x + dx
      ny = y + dy
      next unless 0 <= nx <= 127 && 0 <= ny <= 127

      if grid[nx][ny] && regions[nx][ny] == 0
        stack << {nx, ny}
      end
    end
  end

  true
end

input = File.read("#{__DIR__}/input.txt").strip

grid = Array.new(128) do |i|
  knot_hash("#{input}-#{i}").chars.flat_map do |chars|
    sprintf("%04s", chars.to_i(16).to_s(2)).chars.map do |c|
      c == '1'
    end
  end
end

regions = Array.new(128) { Array.new(128, 0) }
region_count = 1

grid.each_with_index do |row, x|
  row.each_with_index do |used, y|
    if flood(grid, regions, x, y, region_count)
      region_count += 1
    end
  end
end

puts regions.max_of &.max
