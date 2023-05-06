hook global ClientCreate '.*' %{
  trigger-user-hook "DISPLAY=%val{client_env_DISPLAY}"
}

hook global User 'DISPLAY=.+' %{
  set-option global clipboard_copy_command 'xsel'
  set-option global clipboard_copy_args '--input' '--clipboard'
  set-option global clipboard_paste_command 'xsel'
  set-option global clipboard_paste_args '--output' '--clipboard'
}
