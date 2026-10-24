def -docstring "
usage: rearrange-buffers
description: rearrange buffers in the buffer list.
config_options: []
" rearrange-buffers %{
  buffer "*buffers*"
  exec "%%"
  select_buffer_list_entries 1
  arrange-buffers %val{selections}
}
