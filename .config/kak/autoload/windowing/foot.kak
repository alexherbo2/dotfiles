# https://codeberg.org/dnkl/foot
define-command foot -params 1.. %{
  nop %sh{
    footclient "$@"
  }
}

define-command open_new_window_with_foot -params .. %{
  footclient -e kak -c %val{session} -e "%arg{@}"
}

complete-command open_new_window_with_foot command
