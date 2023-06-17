# Source: https://crystal-lang.org/reference/master/syntax_and_semantics/
# Source: https://learnxinyminutes.com/docs/crystal/

nil # : Nil
true # : Bool
false # : Bool
1 # : Int32
1_i8 # : Int8
1_i32 # : Int32
1_i64 # : Int64
1_i128 # : Int128
1_u8 # : UInt8
1_u32 # : UInt32
1_u64 # : UInt64
1_u128 # : UInt128
+10 # : Int32
-20 # : Int32
2147483647 # Int32
2147483648 # Int64
-2147483648 # Int32
-2147483649 # Int64
1_000_000 # => 1000000
0b1101 # => 13
0o123 # => 83
0xFE012D # => 16646445
0xfe012d # => 16646445

1 + 2 # => 3

1.0 # => Float64
1.0_f32 # => Float32
1_f32 # => Float32
1e10 # => Float64
1.5e10 # => Float64
1.5e-7 # => Float64
+1.3 # => Float64
-0.5 # => Float64
1_000_000.111_111.class # => Float64

1.0 + 2 # => 3.0

'a' # : Char
'\'' # single quote
'\\' # backslash
'\a' # alert
'\b' # backspace
'\e' # escape
'\f' # form feed
'\n' # newline
'\r' # carriage return
'\t' # tab
'\v' # vertical tab
'\0' # null character
'\uFFFF' # hexadecimal unicode character
'\u{10FFFF}' # hexadecimal unicode character

"hello world" # : String
"\"" # double quote
"\\" # backslash
"\#" # hash character (to escape interpolation)
"\a" # alert
"\b" # backspace
"\e" # escape
"\f" # form feed
"\n" # newline
"\r" # carriage return
"\t" # tab
"\v" # vertical tab
"\0" # null character
"\377" # octal ASCII character
"\xFF" # hexadecimal ASCII character
"\uFFFF" # hexadecimal unicode character
"\u{0}".."\u{10FFFF}" # hexadecimal unicode character

a = 1
b = 2
"sum: #{a} + #{b} = #{a + b}" # => "sum: 1 + 2 = 3"

"\#{a + b}" # => "#{a + b}"
%q(#{a + b}) # => "#{a + b}"

%(hello (world)) # => "hello (world)"
%[hello [world]] # => "hello [world]"
%{hello {world}} # => "hello {world}"
%<hello <world>> # => "hello <world>"
%|hello world| # => "hello world"

name = "world"
%(hello\n#{name}) # => "hello\nworld"
%Q(hello\n#{name}) # => "hello\nworld"
%q(hello\n#{name}) # => "hello\\n\#{name}"

"hello
  world" # => "hello\n  world"

"hello " \
"world, " \
"no newlines." # => "hello world, no newlines."

"hello \
  world, \
  no newlines." # => "hello world, no newlines."

<<-EOF # => "hello\nworld"
hello\n#{name}
EOF

<<-'EOF' # => "hello\\n\#{name}"
hello\n#{name}
EOF

:unquoted_symbol # : Symbol
:"quoted symbol" # : Symbol
:"a" # => :a
:question? # => :"question?"
:exclamation! # => :"exclamation!"

/foo|bar/ # : Regex
/\// # single quote
/\\/ # backslash
/\a/ # alert
/\b/ # backspace
/\e/ # escape
/\f/ # form feed
/\n/ # newline
/\r/ # carriage return
/\t/ # tab
/\v/ # vertical tab
/\0/ # null character
/\377/ # octal ASCII character
/\xFF/ # hexadecimal ASCII character
/\uFFFF/ # hexadecimal unicode character
/\u{1f48e}/ # hexadecimal unicode character
/foo/i.match("FOO")
%r(foo|bar)

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/array.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/array.html#percent-array-literals
[1, 2, 3] # : Array(Int32)
%w(one two three) # => ["one" "two" "three"]
%i(one two three) # => [:one :two :three]

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html
`echo foo`
%x(echo foo)

# https://crystal-lang.org/reference/master/syntax_and_semantics/comments.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/documenting_code.html
private module Legendary
end

private abstract class Animal
  # Returns the name of `self`.
  abstract def name : String
end

# A unicorn is a **legendary animal** (see the `Legendary` module) that has been
# described since antiquity as a beast with a large, spiraling horn projecting
# from its forehead.
#
# To create a unicorn:
#
# ```
# unicorn = Unicorn.new
# unicorn.speak
# ```
#
# The above produces:
#
# ``` text
# "I’m a unicorn"
# ```
#
# Check the number of horns with `#horns`.
class Unicorn < Animal
  include Legendary

  def name : String
    "unicorn"
  end

  # Creates a unicorn with the specified number of *horns*.
  def initialize(@horns : Int32 = 1)
    raise "Not a unicorn" if @horns != 1
  end

  # :nodoc:
  def self.new
    new(1)
  end

  # Returns the number of horns this unicorn has.
  def horns
    @horns
  end

  # :ditto:
  def number_of_horns
    horns
  end

  # Makes the unicorn speak to `STDOUT`.
  #
  # NOTE: Although unicorns don’t normally talk, this one is special.
  # TODO: Check if unicorn is asleep and raise exception if not able to speak.
  # TODO: Create another `speak` method that takes and prints a string.
  def speak
    puts "I’m a unicorn"
  end

  # Makes the unicorn talk to `STDOUT`.
  @[Deprecated("Use `speak` instead")]
  def talk
    puts "I’m a unicorn"
  end
end
