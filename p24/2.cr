record Component, id : Int32, x : Int32, y : Int32

def build(port, depth, components, bridge, used, strength)
  strenghts = components[port].compact_map do |component|
    next if used.includes?(component.id)

    bridge << component
    used << component.id

    new_strength = strength + component.x + component.y
    new_depth = depth + 1

    other_port = port == component.x ? component.y : component.x
    sub_max = build(other_port, new_depth, components, bridge, used, new_strength)

    bridge.pop
    used.delete component.id

    sub_max.as({Int32, Int32})
  end

  strenghts.empty? ? {depth, strength} : strenghts.max
end

input = File.read("#{__DIR__}/input.txt")

components = Hash(Int32, Array(Component)).new { |h, k|
  h[k] = [] of Component
}

input.lines.each_with_index do |line, i|
  x, y = line.split("/").map(&.to_i)
  component = Component.new(i, x, y)
  components[component.x] << component
  components[component.y] << component
end

puts build(0, 0, components, Array(Component).new, Set(Int32).new, 0)[1]
