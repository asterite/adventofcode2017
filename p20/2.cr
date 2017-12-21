record Vector, x : Int64, y : Int64, z : Int64 do
  def +(other : Vector)
    Vector.new(x + other.x, y + other.y, z + other.z)
  end
end

class Particle
  getter n
  property p, v, a

  def initialize(@n : Int32, @p : Vector, @v : Vector, @a : Vector)
  end

  def frame
    @v += @a
    @p += @v
  end
end

particles = File.read("#{__DIR__}/input.txt").lines.map_with_index do |line, i|
  line =~ /p=<(-?\d+),(-?\d+),(-?\d+)>, v=<(-?\d+),(-?\d+),(-?\d+)>, a=<(-?\d+),(-?\d+),(-?\d+)>/
  Particle.new(
    i,
    Vector.new($1.to_i64, $2.to_i64, $3.to_i64),
    Vector.new($4.to_i64, $5.to_i64, $6.to_i64),
    Vector.new($7.to_i64, $8.to_i64, $9.to_i64),
  )
end

100.times do |i|
  particles.reject! { |p| particles.any? { |q| p.n != q.n && p.p == q.p } }
  particles.each &.frame
end

puts particles.size
