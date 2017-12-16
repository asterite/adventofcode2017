record Spin, size : Int32
record Exchange, a : Int32, b : Int32
record Partner, a : Char, b : Char

input = File.read("#{__DIR__}/input.txt").strip

instructions = input.split(",").map do |instruction|
  case instruction
  when %r(s(\d+))
    Spin.new($1.to_i)
  when %r(x(\d+)/(\d+))
    Exchange.new($1.to_i, $2.to_i)
  when %r(p(\w)/(\w))
    Partner.new($1[0], $2[0])
  else
    raise "Unknown instruction: #{instruction}"
  end
end

programs = ('a'..'p').to_a

all = [programs.dup]
found_cycle = false

i = 0
n = 1_000_000_000

while i < n
  instructions.each do |instruction|
    case instruction
    when Spin
      programs.rotate!(-instruction.size)
    when Exchange
      programs.swap(instruction.a, instruction.b)
    when Partner
      programs.swap(
        programs.index(instruction.a).not_nil!,
        programs.index(instruction.b).not_nil!,
      )
    else
      raise "Unknown instruction: #{instruction}"
    end
  end

  i += 1

  if !found_cycle && (cycle_index = all.index(programs.dup))
    cycle_size = i - cycle_index
    i += ((n - i) / cycle_size) * cycle_size
    found_cycle = true
  end

  all << programs.dup
end

puts programs.join
