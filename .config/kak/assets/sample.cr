# Source: https://learnxinyminutes.com/docs/crystal/
# This is a comment.

1_000_000
1_000_000.111_111.class
0b1101
0o123
0xfe012d
1 + 2 # => 3

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
'\377' # octal ASCII character
'\xFF' # hexadecimal ASCII character
'\uFFFF' # hexadecimal unicode character
'\u{1f48e}' # hexadecimal unicode character

"hello" # : String
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
"\u{1f48e}" # hexadecimal unicode character

"sum = #{1 + 2}" # => "sum = 3"

%(hello world) # => "hello world"
%Q(hello world) # => "hello world"
%q(hello world) # => "hello world"

<<-EOF
hello\nworld
EOF

<<-'EOF'
hello world
EOF

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

[1, 2, 3] # : Array(Int32)
%w(one two three) # => ["one" "two" "three"]
%i(one two three) # => [:one :two :three]

:unquoted_symbol
:"quoted symbol"

`echo foo`
%x(echo foo)

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
