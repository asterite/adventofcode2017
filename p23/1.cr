class Interpreter
  record Set, reg : UInt8, value : UInt8 | Int64
  record Sub, reg : UInt8, value : UInt8 | Int64
  record Mul, reg : UInt8, value : UInt8 | Int64
  record Jnz, value : UInt8 | Int64, offset : UInt8 | Int64

  def self.parse(code)
    code.lines.map do |line|
      case line
      when /set (.+) (.+)/
        Set.new(pos($1), $2.to_i64? || pos($2))
      when /sub (.+) (.+)/
        Sub.new(pos($1), $2.to_i64? || pos($2))
      when /mul (.+) (.+)/
        Mul.new(pos($1), $2.to_i64? || pos($2))
      when /jnz (.+) (.+)/
        Jnz.new($1.to_i64? || pos($1), $2.to_i64? || pos($2))
      else
        raise "Unknown instruction: #{line}"
      end
    end
  end

  private def self.pos(reg)
    (reg[0] - 'a').to_u8
  end

  @registers = StaticArray(Int64, 8).new(0_i64)
  @pos = 0
  getter muls = 0

  def interpret(instructions)
    while 0 <= @pos < instructions.size
      instruction = instructions[@pos]

      case instruction
      when Set
        @registers[instruction.reg] = value(instruction.value)
      when Sub
        @registers[instruction.reg] -= value(instruction.value)
      when Mul
        @registers[instruction.reg] *= value(instruction.value)
        @muls += 1
      when Jnz
        if value(instruction.value) != 0
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

  private def value(reg : UInt8)
    @registers[reg]
  end
end

code = File.read("#{__DIR__}/input.txt")
instructions = Interpreter.parse(code)

interpreter = Interpreter.new
interpreter.interpret(instructions)

puts interpreter.muls
