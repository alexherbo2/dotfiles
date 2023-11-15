hook global BufCreate '.+\.preview' %{
  set-option buffer filetype preview
}

hook global WinSetOption filetype=preview %{
  remove-highlighter window/line_numbers
  # set-face buffer LineNumbers ''
  # set-face buffer LineNumberCursor ''
  # set-face buffer LineNumbersWrapped ''
}

# <buffer> <line_range>
define-command update_preview -params 1 %{
  evaluate-commands -buffer "%val{client}.preview" -save-regs '"' %{
    buffer -- %arg{1}
    execute-keys -draft -save-regs '' 'gg40Gxy'
    set-option "buffer=%val{client}.preview" filetype %opt{filetype}
    buffer -- "%val{client}.preview"
    execute-keys '%R'
  }
}

define-command remove_preview %{
  execute-keys -buffer "%val{client}.preview" '%d'
}

define-command open_preview %{
  edit -scratch -- "%val{client}.preview"
}

define-command close_preview %{
  delete-buffer -- "%val{client}.preview"
}
