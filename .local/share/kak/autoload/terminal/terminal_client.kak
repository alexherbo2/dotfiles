def new-terminal-client -params .. %{
  terminal kak -c %val{session} -e "%arg{@}" "+%val{cursor_line}:%val{cursor_char_column}" -- "%val{buffile}"
}

compl new-terminal-client command

alias global new-client new-terminal-client
