# This script provides the functionality to test Kakoune scripts.
# Tests live in the `test` directory and must end with `_test.kak`.

# Internal variables
declare-option str-list tests

declare-option int success_count 0
declare-option int failure_count 0
declare-option int error_count 0

declare-option str final_status_message
declare-option int exit_code 0

# Temporary files
declare-option str tmp %sh(mktemp -d)
hook -always global KakEnd '' %{
  nop %sh(rm -Rf "$kak_opt_tmp")
}

define-command load_tests %{
  evaluate-commands %sh{
    find -L "$kak_config/tests" -type f -name '*.kak' -exec printf 'source "%s";' {} +
  }
}

# Commands ─────────────────────────────────────────────────────────────────────

# Syntax:
#
# test <name> <commands>
#
define-command -override add_test -params 2 %{
  define-command -override -hidden %arg{1} %arg{2}
  set-option -add global tests %arg{1}
}

alias global test add_test

define-command -override clear_tests %{
  unset-option global tests
}

# Reference:
# https://doc.rust-lang.org/test/fn.run_tests.html
define-command -override run_tests %{
  evaluate-commands %sh{
    eval set -- "$kak_quoted_opt_tests"
    echo "echo running $# tests"
    printf 'run_test "%s";' "$@"
  }
}

# Reference:
# https://doc.rust-lang.org/test/fn.run_test.html
define-command -override run_test -params 1 -shell-script-candidates 'eval set -- "$kak_quoted_opt_tests" && printf ''%s\n'' "$@"' %{
  echo -debug "test %arg{1}"
  try %{
    evaluate-commands %arg{1}
    echo -debug "%arg{1}: ok"
  } catch %{
    echo -debug "%arg{1}: failed"
    echo -debug "Error: %val{error}"
  }
}

define-command -override load_and_run_tests %{
  load_tests
  run_tests
}

define-command -override run_tests_and_exit -params 1 %{
  delete-buffer '*debug*'
  test_files
  report_and_exit %arg{1}
}

define-command -override test_files %{
  clear_tests
  # Source `test/**/*_test.kak`.
  evaluate-commands %sh{
    find test -type f -name '*_test.kak' -exec printf 'source "%s";' {} +
  }
  run_tests
}

define-command -override report_and_exit -params 1 %{
  buffer '*debug*'
  write! %arg{1}
  quit! %opt{exit_code}
}

# Expectations ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference:
#
# - https://github.com/crystal-lang/crystal/blob/master/src/spec/context.cr
# - https://github.com/crystal-lang/crystal/blob/master/src/spec/expectations.cr

# Syntax:
#
# assert_eq <actual_value> <expected_value>
#
# Reference:
#
# - https://doc.rust-lang.org/std/macro.assert.html
# - https://doc.rust-lang.org/std/macro.assert_eq.html
#
define-command -override assert_eq -params 2 %{
  try %sh[ "$1" = "$2" || echo fail ] catch %{
    echo -debug "Expected: %arg{2}"
    echo -debug "Got: %arg{1}"
    fail fail
  }
}

# Asserts that two buffers are equal to each other.
# Buffer contents and selected text should be equal.
define-command -override assert_buffer_eq -params 2 %{
  set-register a "%opt{tmp}/a"
  set-register b "%opt{tmp}/b"
  buffer %arg{1}
  set-register c %val{selections_desc}
  write! %reg{a}
  buffer %arg{2}
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

    echo -debug 'Expected:'
    evaluate-commands "echo -debug %%file{%reg{a}}"
    echo -debug 'Got:'
    evaluate-commands "echo -debug %%file{%reg{b}}"

    # Return status
    fail fail
  }
}

# Utilities ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Creates a buffer from the given string.
#
# Syntax
#
# create_buffer_from_string <buffer_name> <text>
#
# Reference:
#
# https://github.com/mawww/kakoune/blob/master/src/buffer_utils.cc#:~:text=create_buffer_from_string
#
define-command -override create_buffer_from_string -params 2 %{
  edit -scratch %arg{1}
  set-register dquote %arg{2}
  execute-keys '%R'
}

alias global buffer_str create_buffer_from_string

# Indented strings
#
# Leading whitespace is removed from the string contents according to the number of whitespace in the last line before the string delimiter.
#
# Syntax
#
# create_buffer_from_template_string <buffer_name> <template_text>
#
# Reference:
#
# - <https://nixos.org/manual/nix/stable/expressions/language-values.html#:~:text=indented string>
# - https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc
#
define-command -override create_buffer_from_template_string -params 2 %{
  create_buffer_from_string %arg{1} %arg{2}
  execute-keys '%s\A\n|\n\z<ret>d%1s(\h+)\n\z<ret>y%s^\Q<c-r>"<ret>dged%s\[<ret><a-i>ri<backspace><esc>a<del><esc>'
}

alias global buffer_str! create_buffer_from_template_string
