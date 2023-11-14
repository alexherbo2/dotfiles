define-command open_buffer_picker %{
  evaluate-commands -draft -verbatim edit -scratch -- "%val{client}.preview"
  cp_buffers %val{bufname} "%val{client}.preview"
  prompt open: -menu -shell-script-candidates %opt{other_buffers_completion} %{
    delete-buffer -- "%val{client}.preview"
    buffer -- %val{text}
  } -on-change %{
    evaluate-commands -draft -verbatim try %{
      cp_buffers %val{text} "%val{client}.preview"
      execute-keys -client %val{client} '<a-;>gg'
    } catch %{}
  } -on-abort %{
    delete-buffer -- "%val{client}.preview"
  }
}
