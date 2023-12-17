# Reference:
#
# - https://github.com/crystal-lang/crystal/blob/master/src/spec/context.cr
# - https://github.com/crystal-lang/crystal/blob/master/src/spec/expectations.cr

# https://doc.rust-lang.org/std/macro.assert_eq.html
define-command assert_eq -params 2 -docstring 'assert_eq <actual_value> <expected_value>' %{
  evaluate-commands %sh{
    if [ "$1" != "$2" ]
    then
      printf 'echo -debug "%s"\n' "assert_eq: failed" "Expected:" "%arg{2}" "Got:" "%arg{1}"
      echo "fail"
    fi
  }
}

# Asserts that two buffers are equal to each other.
# Buffer contents and selected text should be equal.
define-command assert_buffer_eq -params 2 %{
  set-register t %sh{mktemp -d}
  set-register a "%reg{t}/a"
  set-register b "%reg{t}/b"

  buffer -- %arg{1}
  set-register c %val{selections_desc}
  write! %reg{a}

  buffer -- %arg{2}
  set-register d %val{selections_desc}
  write! %reg{b}

  # Asserts that two buffers are equal to each other.
  # Buffer contents and selected text should be equal.
  try %sh[ cmp -s "$kak_reg_a" "$kak_reg_b" && test "$kak_reg_c" = "$kak_reg_d" || echo fail ] catch %{
    # Failure message
    # Mark selected text
    # Text enclosed in square brackets `[]` denotes selected text.
    edit %reg{a}
    select %reg{c}
    execute-keys 'i[<esc>a]<esc>'
    write

    edit %reg{b}
    select %reg{d}
    execute-keys 'i[<esc>a]<esc>'
    write

    echo -debug "assert_buffer_eq '%arg{1}' '%arg{2}': failed"
    echo -debug 'Expected:'
    evaluate-commands "echo -debug %%file{%reg{b}}"
    echo -debug 'Got:'
    evaluate-commands "echo -debug %%file{%reg{a}}"

    nop %sh{
      unlink "$kak_reg_a"
      unlink "$kak_reg_b"
      rmdir "$kak_reg_t"
    }

    fail fail
  }

  nop %sh{
    unlink "$kak_reg_a"
    unlink "$kak_reg_b"
    rmdir "$kak_reg_t"
  }
}

complete-command assert_buffer_eq buffer

define-command assert_buffer_eq_and_clean_them -params 2 %{
  assert_buffer_eq %arg{1} %arg{2}
  evaluate-commands -buffer "%arg{1},%arg{2}" delete-buffer
}

alias global assert_buffer_eq! assert_buffer_eq_and_clean_them
complete-command assert_buffer_eq_and_clean_them buffer
