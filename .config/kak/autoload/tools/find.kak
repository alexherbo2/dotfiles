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
