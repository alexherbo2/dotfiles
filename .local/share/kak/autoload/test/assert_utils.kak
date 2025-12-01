# Reference:
#
# - https://github.com/crystal-lang/crystal/blob/master/src/spec/context.cr
# - https://github.com/crystal-lang/crystal/blob/master/src/spec/expectations.cr

# https://doc.rust-lang.org/std/macro.assert_eq.html
def assert_eq -params 2 -docstring 'assert_eq <actual_value> <expected_value>' %{
  try %sh{
    [ "$1" = "$2" ] || echo fail
  } catch %{
    fail %sh{
      printf '%s\n' "assert_eq '$1' '$2'" 'Expected:' "$2" 'Got:' "$1"
    }
  }
}

# Asserts that two buffers are equal to each other.
# Buffer contents and selected text should be equal.
def assert_buffer_eq -params 2 %{
  eval -save-regs 'abcdef' %{
    buffer -- %arg{1}
    exec -draft '%"ay'
    reg c %val{selections_desc}

    buffer -- %arg{2}
    exec -draft '%"by'
    reg d %val{selections_desc}

    # Asserts that two buffers are equal to each other.
    # Buffer contents and selected text should be equal.
    try %sh{
      [ "$kak_reg_a" = "$kak_reg_b" ] && [ "$kak_reg_c" = "$kak_reg_d" ] || echo fail
    } catch %{
      # Failure message
      # Mark selected text
      # Text enclosed in square brackets `[]` denotes selected text.
      edit -scratch
      exec '"aR'
      select %reg{c}
      exec 'i[<esc>a]<esc>'
      exec -draft '%"ey'
      delete-buffer

      edit -scratch
      exec '"bR'
      select %reg{d}
      exec 'i[<esc>a]<esc>'
      exec -draft '%"fy'
      delete-buffer

      fail %sh{
        printf '%s\n' "assert_buffer_eq '$1' '$2'" 'Expected:' "$kak_reg_f" 'Got:' "$kak_reg_e"
      }
    }
  }
}

compl assert_buffer_eq buffer

def assert_buffer_eq_and_clean_them -params 2 %{
  assert_buffer_eq %arg{1} %arg{2}
  eval -buffer "%arg{1},%arg{2}" delete-buffer
}

alias global assert_buffer_eq! assert_buffer_eq_and_clean_them
compl assert_buffer_eq_and_clean_them buffer
