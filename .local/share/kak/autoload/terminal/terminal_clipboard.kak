def yank_selected_text_to_terminal_clipboard %{
  exec 'y:edit -scratch<ret><a-R>a<ret><esc><a-_>H<a-|>if [ -e "/proc/$kak_client_pid/fd/0" ]; then fd=/proc/$kak_client_pid/fd/0; else fd=/dev/tty; fi; { printf ''\033]52;c;''; base64; printf ''\a''; } <gt> "$fd"<ret>:delete-buffer<ret>'
}

alias global yank yank_selected_text_to_terminal_clipboard
