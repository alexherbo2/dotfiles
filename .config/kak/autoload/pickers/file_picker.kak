hook global BufCreate '.+\.preview' %{
  set-option buffer filetype preview
}

hook global WinSetOption filetype=preview %{
  remove-highlighter window/line_numbers
  # set-face buffer LineNumbers ''
  # set-face buffer LineNumberCursor ''
  # set-face buffer LineNumbersWrapped ''
}

define-command update_preview -params 1 %{
  ditto_viewport %arg{1} "%val{client}.preview"
}

define-command open_preview %{
  edit -scratch -- "%val{client}.preview"
}

define-command close_preview %{
  delete-buffer -- "%val{client}.preview"
}

define-command open_file_picker %{
  open_preview
  prompt open: -menu -shell-script-candidates %opt{find_completion} %{
    close_preview
    edit -existing -- %val{text}
  } -on-change %{
    evaluate-commands -draft -verbatim try %{
      update_preview %val{text}
    } catch %{
      edit -existing -- %val{text}
      update_preview %val{text}
      delete-buffer -- %val{text}
    } catch %{}
    execute-keys '<a-;>gg'
  } -on-abort %{
    close_preview
  }
}
