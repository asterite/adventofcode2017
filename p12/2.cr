input = File.read("#{__DIR__}/input.txt").strip
pipes = input.each_line
        .map do |line|
          left, right = line.split("<->").map(&.strip)
          {left, right.split(",").map(&.strip)}
        end
        .to_h

groups = [] of Set(String)

pipes.each_key do |start|
  next if groups.any? &.includes?(start)

  group = Set{start}
  pending = [start]

  while node = pending.pop?
    others = pipes[node]
    others.each do |other|
      unless group.includes?(other)
        pending << other
        group << other
      end
    end
  end

  groups << group
end

puts groups.size
