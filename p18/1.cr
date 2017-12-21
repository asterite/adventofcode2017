class Interpreter
  record Sound, value : String | Int64
  record Set, reg : String, value : String | Int64
  record Add, reg : String, value : String | Int64
  record Mul, reg : String, value : String | Int64
  record Mod, reg : String, value : String | Int64
  record Recover, value : String
  record JumpGreaterZero, value : String | Int64, offset : String | Int64

  @registers = Hash(String, Int64).new(0_i64)
  @pos = 0
  @sound : Int64?

  getter recovery : Int64?

  def self.parse(code)
    code.lines.map do |line|
      case line
      when /snd (.+)/
        Sound.new($1.to_i64? || $1)
      when /set (.+) (.+)/
        Set.new($1, $2.to_i64? || $2)
      when /add (.+) (.+)/
        Add.new($1, $2.to_i64? || $2)
      when /mul (.+) (.+)/
        Mul.new($1, $2.to_i64? || $2)
      when /mod (.+) (.+)/
        Mod.new($1, $2.to_i64? || $2)
      when /rcv (.+)/
        Recover.new($1)
      when /jgz (.+) (.+)/
        JumpGreaterZero.new($1.to_i64? || $1, $2.to_i64? || $2)
      else
        raise "Unknown instruction: #{line}"
      end
    end
  end

  def interpret(instructions)
    while 0 <= @pos < instructions.size
      instruction = instructions[@pos]

      case instruction
      when Sound
        @sound = value(instruction.value)
      when Set
        @registers[instruction.reg] = value(instruction.value)
      when Add
        @registers[instruction.reg] += value(instruction.value)
      when Mul
        @registers[instruction.reg] *= value(instruction.value)
      when Mod
        @registers[instruction.reg] %= value(instruction.value)
      when Recover
        if !@recovery && (v = value(instruction.value)) != 0
          @recovery = @sound
          break
        end
      when JumpGreaterZero
        if (v = value(instruction.value)) > 0
          @pos += value(instruction.offset)
          next
        end
      end

      @pos += 1
    end
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

interpreter = Interpreter.new
interpreter.interpret(instructions)

puts interpreter.recovery
