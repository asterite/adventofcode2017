record Instruction, value : Bool, offset : Int32, new_state : Char

lines = File.read("#{__DIR__}/input.txt").lines.reverse
lines.pop =~ /Begin in state (.)\./
state = $1[0]

lines.pop =~ /Perform a diagnostic checksum after (\d+) steps./
steps = $1.to_i

lines.pop

instructions = {} of Char => Hash(Bool, Instruction)

while line = lines.pop?
  line =~ /In state (.):/
  instruction_state = $1[0]

  on_zero, on_one = Array.new(2) do
    lines.pop

    lines.pop =~ /Write the value (\d)\./
    value = $1.to_i == 1

    lines.pop =~ /Move one slot to the (right|left)\./
    offset = $1 == "left" ? -1 : 1

    lines.pop =~ /Continue with state (.)\./
    new_state = $1[0]

    Instruction.new value, offset, new_state
  end

  instructions[instruction_state] = {false => on_zero, true => on_one}

  lines.pop?
end

tape = Set(Int32).new
pos = 0

steps.times do
  instruction = instructions[state][tape.includes?(pos)]
  instruction.value ? tape.add(pos) : tape.delete(pos)
  pos += instruction.offset
  state = instruction.new_state
end

puts tape.size
