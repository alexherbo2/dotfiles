declare-option str find_command fd
declare-option str-list find_args --hidden --type=file

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

hook -group grep-highlight global BufSetOption filetype=find %{
  add-highlighter buffer/find ref find
  map buffer normal <ret> ':jump_to_files<ret>'
}

define-command -hidden jump_to_files %{
  execute-keys 'x<a-s>_gf'
}
