# Syntax and semantics
# https://learnxinyminutes.com/docs/bash/
# https://learnxinyminutes.com/docs/crystal/
# https://learnxinyminutes.com/docs/css/
# https://learnxinyminutes.com/docs/docker/
# https://learnxinyminutes.com/docs/git/
# https://learnxinyminutes.com/docs/html/
# https://learnxinyminutes.com/docs/javascript/
# https://learnxinyminutes.com/docs/json/
# https://learnxinyminutes.com/docs/lua/
# https://learnxinyminutes.com/docs/make/
# https://learnxinyminutes.com/docs/markdown/
# https://learnxinyminutes.com/docs/ruby/
# https://learnxinyminutes.com/docs/rust/
# https://learnxinyminutes.com/docs/toml/
# https://learnxinyminutes.com/docs/typescript/
# https://learnxinyminutes.com/docs/xml/
# https://learnxinyminutes.com/docs/yaml/
# Reference

# https://crystal-lang.org/reference/master/syntax_and_semantics/control_expressions.html

# https://crystal-lang.org/reference/master/syntax_and_semantics/if.html

# https://crystal-lang.org/reference/master/syntax_and_semantics/unless.html

# https://crystal-lang.org/reference/master/syntax_and_semantics/case.html

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

"sum = #{1 + 2}" # => "sum = 3"
"hello" # : String
"\"hello world\"" # : String

%q(hello world) # => "hello world"
%w(one two three) # => ["one" "two" "three"]
%i(one two three) # => [:one :two :three]

<<-EOF
hello\nworld
EOF

<<-'EOF'
hello world
EOF

:unquoted_symbol
:"quoted symbol"

/foo/i.match("FOO")

%r(foo|bar)

`echo foo`

%x(echo foo)

value = case {x, y}
when {0, _}
  1
when {_, 0}
  1
when {_, _}
  0
end

value = case {x, y}
in {0, _}
  1
in {_, 0}
  1
in {_, _}
  0
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/while.html

while some_condition
  do_this
end

loop do
  do_this
  break if some_condition
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/until.html

until some_condition
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html

# https://crystal-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html

class Person
end

private class Person
end

abstract class Person
end

def name
end

private def name
end

protected def name
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/modules.html

module JSON
end

private module JSON
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/structs.html

struct Point
end

private struct Point
end

abstract struct Point
end

private abstract struct Point
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/enum.html

enum Color
end

private enum Color
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html

loop do
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/exception_handling.html

begin
rescue exception
ensure
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/macros/

macro version
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/annotations/

annotation Link
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://crystal-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html

lib C
end

private lib C
end
# Source: https://crystal-lang.org/reference/master/syntax_and_semantics/enum.html
enum Color
  Red
  Green
  Blue

  def red?
    self == Color::Red
  end
end

def paint(color : Color)
  case color
  when .red?
    # ...
  else
    # Unusual, but still can happen.
    raise "Unknown color: #{color}"
  end
end

paint :red

# Documenting code
# https://crystal-lang.org/reference/master/syntax_and_semantics/comments.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/documenting_code.html

# :nodoc:
private module Legendary
end

# :nodoc:
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
