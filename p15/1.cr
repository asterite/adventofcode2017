a = 783_i64
b = 325_i64

count = 0
40_000_000.times do
  a = (a * 16807) % 2147483647
  b = (b * 48271) % 2147483647
  count += 1 if (a & 0xFFFF) == (b & 0xFFFF)
end
puts count
