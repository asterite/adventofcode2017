record Vector, x : Int64, y : Int64, z : Int64 do
  def distance
    x.abs + y.abs + z.abs
  end
end

record Particle, n : Int32, p : Vector, v : Vector, a : Vector

particles = File.read("#{__DIR__}/input.txt").lines.map_with_index do |line, i|
  line =~ /p=<(-?\d+),(-?\d+),(-?\d+)>, v=<(-?\d+),(-?\d+),(-?\d+)>, a=<(-?\d+),(-?\d+),(-?\d+)>/
  Particle.new(
    i,
    Vector.new($1.to_i64, $2.to_i64, $3.to_i64),
    Vector.new($4.to_i64, $5.to_i64, $6.to_i64),
    Vector.new($7.to_i64, $8.to_i64, $9.to_i64),
  )
end

puts particles.min_by { |p| {p.a.distance, p.v.distance, p.p.distance} }.n
