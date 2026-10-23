def yank_selected_text_to_terminal_clipboard %{
  exec 'y:new-buffer<ret><a-R>a<ret><esc><a-_>H<a-|>{ printf ''\033]52;c;''; base64; printf ''\a''; } <gt> "$kak_opt_terminal_tty"<ret>:db<ret>'
}

alias global yank yank_selected_text_to_terminal_clipboard

def yank_shell_command_to_terminal_clipboard -params 1.. %{
  echo -quoting shell -to-shell-script %{
    { printf "\\033]52;c;"; base64; printf "\\a"; } > "$kak_opt_terminal_tty"
  } -- "sh" "-c" "cd -- ""$1"" && shift && exec ""$@""" "--" %sh{pwd} %arg{@}
}

compl yank_shell_command_to_terminal_clipboard shell
