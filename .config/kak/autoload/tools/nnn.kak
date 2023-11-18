define-command open_nnn -params .. %{
  terminal sh -c %{
    kak_session=$1
    kak_client=$2
    shift 2
    nnn -p - "$@" |
    xargs printf "evaluate-commands -client '$kak_client' -verbatim -- edit -existing -- '%s';" |
    kak -p "$kak_session"
  } -- %val{session} %val{client} %arg{@}
}

define-command open_current_buffer_with_nnn %{
  open_nnn -- %val{buffile}
}

alias global nnn open_nnn
complete-command open_nnn file
