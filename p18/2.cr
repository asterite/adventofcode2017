class Interpreter
  record Send, value : String | Int64
  record Set, reg : String, value : String | Int64
  record Add, reg : String, value : String | Int64
  record Mul, reg : String, value : String | Int64
  record Mod, reg : String, value : String | Int64
  record Receive, reg : String
  record JumpGreaterZero, value : String | Int64, offset : String | Int64

  def self.parse(code)
    code.lines.map do |line|
      case line
      when /snd (.+)/
        Send.new($1.to_i64? || $1)
      when /set (.+) (.+)/
        Set.new($1, $2.to_i64? || $2)
      when /add (.+) (.+)/
        Add.new($1, $2.to_i64? || $2)
      when /mul (.+) (.+)/
        Mul.new($1, $2.to_i64? || $2)
      when /mod (.+) (.+)/
        Mod.new($1, $2.to_i64? || $2)
      when /rcv (.+)/
        Receive.new($1)
      when /jgz (.+) (.+)/
        JumpGreaterZero.new($1.to_i64? || $1, $2.to_i64? || $2)
      else
        raise "Unknown instruction: #{line}"
      end
    end
  end

  @pos = 0
  getter registers
  getter number_of_sends = 0_i64
  getter send_buffer = Deque(Int64).new
  getter? done = false
  getter? waiting = false

  def initialize(@id : Int64)
    @registers = {} of String => Int64
    @registers["p"] = @id
  end

  def interpret(instructions, receive_buffer)
    @waiting = false

    while 0 <= @pos < instructions.size
      instruction = instructions[@pos]

      case instruction
      when Send
        @number_of_sends += 1
        @send_buffer << value(instruction.value)
      when Set
        @registers[instruction.reg] = value(instruction.value)
      when Add
        @registers[instruction.reg] += value(instruction.value)
      when Mul
        @registers[instruction.reg] *= value(instruction.value)
      when Mod
        @registers[instruction.reg] %= value(instruction.value)
      when Receive
        if value = receive_buffer.shift?
          @registers[instruction.reg] = value
        else
          @waiting = true
          return
        end
      when JumpGreaterZero
        if (v = value(instruction.value)) > 0
          @pos += value(instruction.offset)
          next
        end
      end

      @pos += 1
    end

    @done = true
  end

  private def value(value : Int64)
    value
  end

  private def value(reg : String)
    @registers[reg]
  end
end

code = File.read("#{__DIR__}/input.txt").strip
instructions = Interpreter.parse(code)

i1 = Interpreter.new(0_i64)
i2 = Interpreter.new(1_i64)

until (i1.done? || (i1.waiting? && i2.send_buffer.empty?)) &&
      (i2.done? || (i2.waiting? && i1.send_buffer.empty?))
  i1.interpret(instructions, i2.send_buffer)
  i2.interpret(instructions, i1.send_buffer)
end

puts i2.number_of_sends
