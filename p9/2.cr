input = File.read("#{__DIR__}/input.txt").strip

in_garbage = false
ignore_next = false
total_garbage = 0

input.each_char do |c|
  if ignore_next
    ignore_next = false
    next
  end

  case c
  when '<'
    if in_garbage
      total_garbage += 1
    else
      in_garbage = true
    end
  when '>'
    in_garbage = false
  when '!'
    ignore_next = true if in_garbage
  else
    total_garbage += 1 if in_garbage
  end
end

puts total_garbage
