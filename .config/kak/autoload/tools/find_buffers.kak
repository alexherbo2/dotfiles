define-command find_buffers -params .. %{
  find %arg{@} %val{buflist}
}

define-command open_buffer_finder %{
  prompt find_buffer: -buffer-completion %{
    find_buffers -- %val{text}
  }
}

complete-command find_buffers buffer
