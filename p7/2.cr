class Node
  property up = [] of Node
  property down : Node?

  getter name
  property self_weight

  def initialize(@name : String, @self_weight : Int32)
  end

  getter total_weight : Int32 do
    self_weight + up.sum(&.total_weight)
  end

  @balanced_computed = false
  @balanced = false

  def balanced?
    return @balanced if @balanced_computed

    @balanced_computed = true

    up_weights = up.map(&.total_weight)
    @balanced = up_weights.uniq.size <= 1
  end

  setter balanced

  getter height : Int32 do
    if down = @down
      1 + down.height
    else
      0
    end
  end

  def reset
    @total_weight = nil
    @balanced_computed = false
  end
end

nodes = [] of Node
nodes_by_name = {} of String => Node
list = [] of {String, Array(String)}

lines = File.read("#{__DIR__}/input.txt").lines
lines.each do |line|
  pieces = line.split("->")
  left = pieces[0]
  name, weight = left.split("(")
  name = name.strip

  weight = weight.to_i(strict: false)

  node = Node.new(name, weight)
  nodes << node
  nodes_by_name[name] = node

  if pieces.size > 1
    list << {name, pieces[1].split(",").map(&.strip)}
  end
end

list.each do |name, upper_names|
  node = nodes_by_name[name]
  upper_names.each do |upper_name|
    upper_node = nodes_by_name[upper_name]
    node.up << upper_node
    upper_node.down = node
  end
end

unbalanced_nodes = nodes.select { |node| !node.balanced? }

unbalanced_node = unbalanced_nodes.max_by(&.height)

unique_weights = unbalanced_node.up.map(&.total_weight).uniq
target = nil

unbalanced_node.up.each do |node|
  if node.total_weight == unique_weights[0]
    difference = node.total_weight - unique_weights[1]
  else
    difference = node.total_weight - unique_weights[0]
  end

  node.self_weight -= difference

  nodes.each &.reset

  match = nodes.all?(&.balanced?)
  if match
    target = node
    break
  end

  node.self_weight += difference
end

target = target.not_nil!
puts target.name
puts target.self_weight
