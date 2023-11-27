declare-option str find_command find
declare-option str-list find_args -type f

declare-option str find_completion %{
  eval "$kak_quoted_opt_find_command" "$kak_quoted_opt_find_args"
}

define-command find -params .. %{
  create_buffer_from_command_output "%arg{1}.flist" %opt{find_command} %opt{find_args} -- %arg{@}
}

complete-command find file

add-highlighter shared/find regex '^(.+?)$' 0:value

hook global BufCreate '.+\.flist' %{
  set-option buffer filetype find
}

hook global BufSetOption filetype=find %{
  add-highlighter buffer/find ref find
  map -docstring 'jump to files in current client' buffer goto f '<a-;>:jump_to_files %val{client}<ret>'
  map -docstring 'jump to files in jump client' buffer goto F '<a-;>:jump_to_files %opt{jump_client}<ret>'
}

define-command -hidden jump_to_files -params 1 %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s>H<a-K>\A\h+.\z<ret>'
    evaluate-commands -itersel %{
      evaluate-commands -client %arg{1} -- edit -existing -- %val{selection}
    }
  }
}
