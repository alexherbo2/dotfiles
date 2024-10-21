define-command open_buffer_picker %{
  open_preview
  prompt open: -menu -shell-script-candidates %opt{other_buffers_completion} %{
    close_preview
    buffer -- %val{text}
  } -on-change %{
    evaluate-commands -draft -verbatim try %{
      update_preview %val{text}
    } catch %{
      remove_preview
    }
    execute-keys '<a-;>gg'
  } -on-abort %{
    close_preview
  }
}
