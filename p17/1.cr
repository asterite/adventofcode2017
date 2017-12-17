steps = 370
buffer = [0]
pos = 0

(1..50000000).each do |i|
  puts i if i % 10_000 == 0

  pos = (pos + steps) % buffer.size
  pos += 1
  buffer.insert(pos, i)
end

pos = (pos + 1) % buffer.size
puts buffer[pos]
