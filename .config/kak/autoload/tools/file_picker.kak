define-command open_file_picker_in_new_window %{
  terminal sh -c %{
    kak_session=$1
    kak_client=$2
    shift 2
    "$@" | zf |
    xargs printf "evaluate-commands -client '$kak_client' -verbatim -- edit -existing -- '%s';" |
    kak -p "$kak_session"
  } -- %val{session} %val{client} %opt{find_command} %opt{find_args}
}

define-command open_buffer_picker_in_new_window %{
  terminal sh -c %{
    kak_session=$1
    kak_client=$2
    shift 2
    printf '%s\n' "$@" | zf |
    xargs printf "evaluate-commands -client '$kak_client' -verbatim -- buffer -- '%s';" |
    kak -p "$kak_session"
  } -- %val{session} %val{client} %val{buflist}
}
