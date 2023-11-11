define-command open_buffer_picker_in_new_window %{
  terminal sh -c %{
    kak_session=$1
    kak_client=$2
    kak_bufname=$3
    shift 3
    printf '%s\n' "$@" | grep -Fxv "$kak_bufname" | zf |
    xargs printf "evaluate-commands -client '$kak_client' -verbatim -- buffer -- '%s';" |
    kak -p "$kak_session"
  } -- %val{session} %val{client} %val{bufname} %val{buflist}
}
