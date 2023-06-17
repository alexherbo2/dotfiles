# Source: https://crystal-lang.org/reference/master/syntax_and_semantics/
# Source: https://learnxinyminutes.com/docs/crystal/

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/nil.html
nil # : Nil

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/bool.html
true # : Bool
false # : Bool

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/integers.html
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

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/floats.html
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

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/char.html
'a' # : Char

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/char.html#escaping
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

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html
"hello world" # : String

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping
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

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
a = 1
b = 2
"sum: #{a} + #{b} = #{a + b}" # => "sum: 1 + 2 = 3"

"\#{a + b}" # => "#{a + b}"
%q(#{a + b}) # => "#{a + b}"

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
%(hello (world)) # => "hello (world)"
%[hello [world]] # => "hello [world]"
%{hello {world}} # => "hello {world}"
%<hello <world>> # => "hello <world>"
%|hello world| # => "hello world"

name = "world"
%(hello\n#{name}) # => "hello\nworld"
%Q(hello\n#{name}) # => "hello\nworld"
%q(hello\n#{name}) # => "hello\\n\#{name}"

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#multiline-strings
"hello
  world" # => "hello\n  world"

"hello " \
"world, " \
"no newlines." # => "hello world, no newlines."

"hello \
  world, \
  no newlines." # => "hello world, no newlines."

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc
<<-EOF # => "hello\nworld"
hello\n#{name}
EOF

<<-'EOF' # => "hello\\n\#{name}"
hello\n#{name}
EOF

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html
:unquoted_symbol # : Symbol
:"quoted symbol" # : Symbol
:"a" # => :a
:question? # => :"question?"
:exclamation! # => :"exclamation!"

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/array.html
[1, 2, 3] # : Array(Int32)
[1, "hello", 'x'] # : Array(Int32 | String | Char)
[] of Int32 # : Array(Int32)

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/array.html#percent-array-literals
%w(one two three) # => ["one" "two" "three"]
%i(one two three) # => [:one :two :three]

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/array.html#array-like-type-literal
Array{1, 2, 3} # => [1, 2, 3]
Set{1, 2, 3} # => Set{1, 2, 3}

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/hash.html
{ "one" => 1, "two" => 2 } # : Hash(String, Int32)
{} of String => Int32 # : Hash(String, Int32)

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/hash.html#hash-like-type-literal
Hash{"one" => 1, "two" => 2} # => {"one" => 1, "two" => 2}
HTTP::Headers{"foo" => "bar"} # => HTTP::Headers{"foo" => "bar"}

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/range.html
0..9 # : Range(Int32, Int32)
0...9 # : Range(Int32, Int32)
(0..9).to_a # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
(0...9).to_a # => [0, 1, 2, 3, 4, 5, 6, 7, 8]

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html
/foo|bar/ # : Regex

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html#escaping
/\// # slash
/\\/ # backslash
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
/\x{FFFF}/ # hexadecimal unicode character
/\x{10FFFF}/ # hexadecimal unicode character

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html#modifiers
/foo/i.match("FOO") # => Regex::MatchData("FOO")

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html#percent-regex-literals
%r(foo (bar)) # => /foo (bar)/
%r[foo [bar]] # => /foo [bar]/
%r{foo {bar}} # => /foo {bar}/
%r<foo <bar>> # => /foo <bar>/
%r|foo bar| # => /foo bar/

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/tuple.html
{1, 2, 3} # : Tuple(Int32)
{1, "hello", 'x'} # : Tuple(Int32 | String | Char)

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/named_tuple.html
{name: "Crystal", year: 2011} # : NamedTuple(name: String, year: Int32)

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/proc.html
->{ 1 } # : Proc(Int32)

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/proc.html#invoking
proc = ->(x : Int32, y : Int32) { x + y } # : Proc(Int32, Int32, Int32)
proc.call(1, 2) # => 3

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/proc.html#from-methods
def one
  1
end
proc = ->one
proc.call # => 1

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/proc.html#from-methods
def plus_one(x)
  x + 1
end
proc = ->plus_one(Int32)
proc.call(41) # => 42

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/proc.html#from-methods
str = "hello"
proc = ->str.count(Char)
proc.call('e') # => 1
proc.call('l') # => 2

# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html
`echo foo` # => "foo\n"
%x(echo foo) # => "foo\n"

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
  def initialize(@horns : Int32)
    raise "Not a unicorn" if @horns != 1
  end

  def self.new : self
    new(1)
  end

  # Returns the number of horns this unicorn has.
  def horns : Int32
    @horns
  end

  # :ditto:
  def number_of_horns : Int32
    horns
  end

  # Makes the unicorn speak to `STDOUT`.
  #
  # NOTE: Although unicorns don’t normally talk, this one is special.
  # TODO: Check if unicorn is asleep and raise exception if not able to speak.
  # TODO: Create another `#speak` method that takes and prints a string.
  def speak
    puts "I’m a unicorn"
  end

  # Makes the unicorn talk to `STDOUT`.
  @[Deprecated("Use `#speak` instead")]
  def talk
    puts "I’m a unicorn"
  end

  # :nodoc:
  class Helper
  end
end
