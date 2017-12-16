programs = ('a'..'p').to_a

input = File.read("#{__DIR__}/input.txt").strip

input.split(",").each do |instruction|
  case instruction
  when %r(s(\d+))
    programs.rotate!(-$1.to_i)
  when %r(x(\d+)/(\d+))
    programs.swap($1.to_i, $2.to_i)
  when %r(p(\w)/(\w))
    programs.swap(
      programs.index($1[0]).not_nil!,
      programs.index($2[0]).not_nil!,
    )
  else
    raise "Unknown instruction: #{instruction}"
  end
end

puts programs.join
