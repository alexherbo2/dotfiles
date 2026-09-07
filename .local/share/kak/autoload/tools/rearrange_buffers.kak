def -docstring "
usage: rearrange-buffers
config_options: []
" rearrange-buffers %{
  buffer "*buffers*"
  exec "%%"
  select_buffer_list_entries 1
  arrange-buffers %val{selections}
}
