hook global ClientCreate '.*' %{
  trigger-user-hook "WAYLAND_DISPLAY=%val{client_env_WAYLAND_DISPLAY}"
}

hook global User 'WAYLAND_DISPLAY=.+' %{
  set-option global clipboard_copy_command 'wl-copy'
  set-option global clipboard_copy_args
  set-option global clipboard_paste_command 'wl-paste'
  set-option global clipboard_paste_args '--no-newline'
}
