input = File.read("#{__DIR__}/input.txt").strip
pipes = input.each_line
        .map do |line|
          left, right = line.split("<->").map(&.strip)
          {left, right.split(",").map(&.strip)}
        end
        .to_h

found = Set{"0"}
pending = ["0"]

while node = pending.pop?
  others = pipes[node]
  others.each do |other|
    unless found.includes?(other)
      pending << other
      found << other
    end
  end
end

puts found.size
