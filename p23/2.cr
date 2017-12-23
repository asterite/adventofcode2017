a = 1
b = 65
c = 65

if a != 0
  b = 106500
  c = 123500
end

non_primes = b.step(by: 17, to: c).count do |x|
  (2..(x - 1)).any? { |n| x.divisible_by?(n) }
end
puts non_primes
