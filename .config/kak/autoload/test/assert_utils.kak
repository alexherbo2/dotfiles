# Reference:
#
# - https://github.com/crystal-lang/crystal/blob/master/src/spec/context.cr
# - https://github.com/crystal-lang/crystal/blob/master/src/spec/expectations.cr

# https://doc.rust-lang.org/std/macro.assert_eq.html
define-command assert_eq -params 2 -docstring 'assert_eq <actual_value> <expected_value>' %{
  try %sh{
    [ "$1" = "$2" ] || echo fail
  } catch %{
    fail %sh{
      printf '%s\n' "assert_eq '%arg{1}' '%arg{2}'" 'Expected:' '%arg{2}' 'Got:' '%arg{1}'
    }
  }
}

# Asserts that two buffers are equal to each other.
# Buffer contents and selected text should be equal.
define-command assert_buffer_eq -params 2 %{
  evaluate-commands -save-regs 'abcdef' %{
    buffer -- %arg{1}
    execute-keys -draft '%"ay'
    set-register c %val{selections_desc}

    buffer -- %arg{2}
    execute-keys -draft '%"by'
    set-register d %val{selections_desc}

    # Asserts that two buffers are equal to each other.
    # Buffer contents and selected text should be equal.
    try %sh{
      [ "$kak_reg_a" = "$kak_reg_b" ] && [ "$kak_reg_c" = "$kak_reg_d" ] || echo fail
    } catch %{
      # Failure message
      # Mark selected text
      # Text enclosed in square brackets `[]` denotes selected text.
      edit -scratch
      execute-keys '"aR'
      select %reg{c}
      execute-keys 'i[<esc>a]<esc>'
      execute-keys -draft '%"ey'
      delete-buffer

      edit -scratch
      execute-keys '"bR'
      select %reg{d}
      execute-keys 'i[<esc>a]<esc>'
      execute-keys -draft '%"fy'
      delete-buffer

      fail %sh{
        printf '%s\n' "assert_buffer_eq '%arg{1}' '%arg{2}'" 'Expected:' '%reg{f}' 'Got:' '%reg{e}'
      }
    }
  }
}

complete-command assert_buffer_eq buffer

define-command assert_buffer_eq_and_clean_them -params 2 %{
  assert_buffer_eq %arg{1} %arg{2}
  evaluate-commands -buffer "%arg{1},%arg{2}" delete-buffer
}

alias global assert_buffer_eq! assert_buffer_eq_and_clean_them
complete-command assert_buffer_eq_and_clean_them buffer
