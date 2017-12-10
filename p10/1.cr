nums = (0..255).to_a
skip_size = 0
pos = 0

lengths = File.read("#{__DIR__}/input.txt").strip.split(",").map(&.to_i)
lengths.each do |length|
  (length/2).times do |i|
    nums.swap((pos + i) % nums.size, (pos + length - 1 - i) % nums.size)
  end
  pos += length + skip_size
  skip_size += 1
end

puts nums[0] * nums[1]
