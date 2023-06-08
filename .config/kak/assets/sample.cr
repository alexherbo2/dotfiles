# Syntax and semantics
# Reference
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
#
# class Person
# end
#
# private class Person
# end
#
# abstract class Person
# end
#
# private abstract class Person
# end
#
# def name
# end
#
# private def name
# end
#
# protected def name
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module JSON
# end
#
# private module JSON
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/structs.html
#
# struct Point
# end
#
# private struct Point
# end
#
# abstract struct Point
# end
#
# private abstract struct Point
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://crystal-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end
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
