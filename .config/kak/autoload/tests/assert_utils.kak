# https://doc.rust-lang.org/std/macro.assert_eq.html
define-command assert_eq -params 2 %{
  try %sh[[ "$1" != "$2" ] && echo fail] catch %{
    echo -debug -quoting kakoune %arg{1} %arg{2}
    fail assert_eq %arg{1} %arg{2}
  }
}

# Asserts that two buffers are equal to each other.
# Buffer contents and selected text should be equal.
define-command assert_buffer_eq -params 2 %{
  buffer -- %arg{1}
  execute-keys -draft '%"ay'
  set-register c %val{selections_desc}

  buffer -- %arg{2}
  execute-keys -draft '%"by'
  set-register d %val{selections_desc}

  try %sh[[ "$kak_reg_a" != "$kak_reg_b" ] || [ "$kak_reg_c" != "$kak_reg_d" ] && echo fail] catch %{
    echo -debug -quoting kakoune %reg{a} %reg{b} %reg{c} %reg{d}
    fail assert_buffer_eq %arg{1} %arg{2}
  }
}

complete-command assert_buffer_eq buffer

define-command assert_buffer_eq_and_clean_them -params 2 %{
  assert_buffer_eq %arg{1} %arg{2}
  evaluate-commands -buffer "%arg{1},%arg{2}" delete-buffer
}

alias global assert_buffer_eq! assert_buffer_eq_and_clean_them
complete-command assert_buffer_eq_and_clean_them buffer
