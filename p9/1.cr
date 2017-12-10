input = File.read("#{__DIR__}/input.txt").strip

group_count = 0
score = 0
in_garbage = false
ignore_next = false

input.each_char do |c|
  if ignore_next
    ignore_next = false
    next
  end

  case c
  when '{'
    next if in_garbage

    group_count += 1
    score += group_count
  when '}'
    next if in_garbage

    group_count -= 1
  when '<'
    in_garbage = true
  when '>'
    in_garbage = false
  when '!'
    ignore_next = true if in_garbage
  else
    # Ignore
  end
end

puts score
