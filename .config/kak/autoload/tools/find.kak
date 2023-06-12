declare-option str find_command find
declare-option str-list find_args -type f

define-command find -params .. %{
  create_buffer_from_command_output "%arg{1}.flist" %opt{find_command} %opt{find_args} -- %arg{@}
}

define-command open_file_finder %{
  prompt find_file: -file-completion %{
    find %val{text}
  }
}

define-command open_buffer_finder %{
  prompt find_buffer: -buffer-completion %{
    find %val{text} %val{buflist}
  }
}

complete-command find file

add-highlighter shared/find regex '^(.+?)$' 0:value

hook global BufOpenFifo '.+\.flist' %{
  set-option buffer filetype find
}

hook global BufSetOption filetype=find %{
  add-highlighter buffer/find ref find
  map buffer normal <ret> ':jump_to_files<ret>'
}

define-command -hidden jump_to_files %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s>H'
    evaluate-commands -itersel %{
      evaluate-commands -client %val{client} -- edit -existing -- %val{selection}
    }
  }
}
