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

input = File.read("#{__DIR__}/input.txt").strip

used = 128.times.sum do |i|
  knot_hash("#{input}-#{i}").chars.sum(&.to_i(16).popcount)
end

puts used
