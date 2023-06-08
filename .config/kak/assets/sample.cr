# Syntax and semantics
# Reference

# https://crystal-lang.org/reference/master/syntax_and_semantics/control_expressions.html

# https://crystal-lang.org/reference/master/syntax_and_semantics/if.html

value = if some_condition
elsif some_other_condition
else
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/unless.html

value = unless some_condition
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/case.html

value = case expression
when value
end

value = case expression
in value
end

# https://crystal-lang.org/reference/master/syntax_and_semantics/while.html

while some_condition
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

private abstract class Person
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
# Syntax and semantics
# https://crystal-lang.org/reference/master/syntax_and_semantics/
# Method definition and call
# https://crystal-lang.org/reference/master/syntax_and_semantics/method_arguments.html

# Instance and class variables
# https://crystal-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/class_variables.html

# Keywords
# https://github.com/crystal-lang/crystal/blob/master/src/compiler/crystal/syntax/lexer.cr

# Built-in functions
# https://crystal-lang.org/api/master/toplevel.html
# https://crystal-lang.org/api/master/Object.html

# Operators
# https://crystal-lang.org/reference/master/syntax_and_semantics/operators.html

# Literals
# Constants
# Numbers
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/floats.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/constants.html
FOO
1_000_000
1_000_000.111_111
0b1101
0o123
0xfe012d

# Comments
# https://crystal-lang.org/reference/master/syntax_and_semantics/comments.html
# Documenting code
# https://crystal-lang.org/reference/master/syntax_and_semantics/documenting_code.html
# A unicorn is a **legendary animal**.
#
# To create a unicorn:
#
# ```
# unicorn = Unicorn.new
# unicorn.speak
# ```
#
# Check the number of horns with `#horns`.

# Strings

# Interpolated strings
# Interpolation
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping
puts "hello world"
puts "\""
puts "\\"

# Single quoted strings
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/char.html
puts 'a'
puts '\''
puts '\\'

# Percent string literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
puts %Q(hello #{name})

# Raw percent string literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal
puts %q(hello world)
puts %w(hello world)
puts %i(hello world)

# Here document
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc
puts <<-EOF
hello\nworld
EOF

puts <<-'EOF'
hello world
EOF

# Symbols
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html
:unquoted_symbol
:"quoted symbol"

# Regular expressions

# Quoted regex literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html
/foo/i.match("FOO")

# Percent regex literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html
%r(foo|bar)

# Command literal
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html

# Quoted command literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html
`echo foo`

# Percent command literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html
%x(echo foo)
