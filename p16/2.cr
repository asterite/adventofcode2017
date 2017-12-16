record Spin, size : Int32 do
  def run(programs)
    programs.rotate!(-size)
  end
end

record Exchange, a : Int32, b : Int32 do
  def run(programs)
    programs.swap(a, b)
  end
end

record Partner, a : Char, b : Char do
  def run(programs)
    programs.swap(programs.index(a).not_nil!, programs.index(b).not_nil!)
  end
end

input = File.read("#{__DIR__}/input.txt").strip

instructions = input.split(",").map do |instruction|
  case instruction
  when %r(s(\d+))       then Spin.new($1.to_i)
  when %r(x(\d+)/(\d+)) then Exchange.new($1.to_i, $2.to_i)
  when %r(p(\w)/(\w))   then Partner.new($1[0], $2[0])
  else                       raise "Unknown instruction: #{instruction}"
  end
end

programs = ('a'..'p').to_a

all = [programs.dup]
found_cycle = false

i = 0
n = 1_000_000_000

while i < n
  instructions.each &.run(programs)

  i += 1

  if !found_cycle && (cycle_index = all.index(programs.dup))
    cycle_size = i - cycle_index
    i += ((n - i) / cycle_size) * cycle_size
    found_cycle = true
  end

  all << programs.dup
end

puts programs.join
