hook global ClientCreate '.*' %{
  trigger-user-hook "OS=%sh{uname}"
}

hook global User 'OS=Darwin' %{
  set-option global clipboard_copy_command 'pbcopy'
  set-option global clipboard_copy_args
  set-option global clipboard_paste_command 'pbpaste'
  set-option global clipboard_paste_args
}
