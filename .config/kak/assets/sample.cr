# Syntax and semantics
# Reference

# https://crystal-lang.org/reference/master/syntax_and_semantics/control_expressions.html

# https://crystal-lang.org/reference/master/syntax_and_semantics/if.html

# https://crystal-lang.org/reference/master/syntax_and_semantics/unless.html

# https://crystal-lang.org/reference/master/syntax_and_semantics/case.html

puts "I say: \"Hello, \\\n\t#{:crystal_lang.to_s + '\u{1f48e}'}!\""
array_of_numbers = [1_000_000, 1_000_000.111_111, 0b1101, 0o123, 0xfe012d]
array_of_strings = []

puts %q(hello world)
puts %w(hello world)
puts %i(hello world)

puts <<-EOF
hello\nworld
EOF

puts <<-'EOF'
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
