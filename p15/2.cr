a = 783_i64
b = 325_i64

count = 0
5_000_000.times do
  while true
    a = (a * 16807) % 2147483647
    break if a.divisible_by?(4)
  end

  while true
    b = (b * 48271) % 2147483647
    break if b.divisible_by?(8)
  end

  count += 1 if (a & 0xFFFF) == (b & 0xFFFF)
end
puts count
