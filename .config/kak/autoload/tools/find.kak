declare-option str find_command find
declare-option str-list find_args -type f

declare-option str find_completion %{
  eval "$kak_quoted_opt_find_command" "$kak_quoted_opt_find_args"
}

define-command find -params .. %{
  evaluate-commands -try-client %opt{tools_client} -verbatim create_buffer_from_command_output "%arg{1}.flist" %opt{find_command} %opt{find_args} %arg{@}
}

complete-command find file

add-highlighter shared/find regex '^(.+?)$' 0:value

hook global BufCreate '.+\.flist' %{
  set-option buffer filetype find
}

hook global BufSetOption filetype=find %{
  add-highlighter buffer/find ref find
  map -docstring 'jump to files' buffer goto f '<a-;>:jump_to_files<ret>'
}

define-command -hidden jump_to_files %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>H'
    evaluate-commands -itersel %{
      evaluate-commands -try-client %opt{jump_client} -verbatim edit -existing -- %val{selection}
    }
  }
}
