steps = 370
pos = 0
value = nil

(1..50000000).each do |i|
  pos = (pos + steps) % i
  pos += 1
  value = i if pos == 1
end

puts value
