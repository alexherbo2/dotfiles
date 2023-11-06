define-command open_current_buffer_with_nnn %{
  terminal sh -c %{
    nnn -p - -- "$3" |
    xargs printf "evaluate-commands -client '$2' -verbatim -- edit -existing -- '%s';" |
    kak -p "$1"
  } -- %val{session} %val{client} %val{buffile}
}

alias global nnn open_current_buffer_with_nnn
