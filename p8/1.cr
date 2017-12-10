registers = Hash(String, Int32).new { |h, k| h[k] = 0 }

File.read("#{__DIR__}/input.txt").each_line do |line|
  target_register, target_op, target_value, _if, if_register, if_op, if_value = line.split

  if_value = if_value.to_i
  if_register_value = registers[if_register]

  must_execute = case if_op
                 when ">"  then if_register_value > if_value
                 when ">=" then if_register_value >= if_value
                 when "==" then if_register_value == if_value
                 when "<=" then if_register_value <= if_value
                 when "<"  then if_register_value < if_value
                 when "!=" then if_register_value != if_value
                 else           raise "Unknown op: #{if_op}"
                 end

  if must_execute
    sign = target_op == "inc" ? 1 : -1
    registers[target_register] += sign * target_value.to_i
  end
end

puts registers.values.max
