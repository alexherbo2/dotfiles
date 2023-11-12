define-command open_buffer_picker %{
  evaluate-commands -save-regs '^"t' %{
    execute-keys -draft -save-regs '' '%y'
    set-register ^ %val{selections_desc}
    set-register t %opt{filetype}
    edit -scratch "%val{client}.preview"
    set-option buffer filetype %reg{t}
    execute-keys '%R'
    select %reg{^}
  }
  prompt open: -menu -shell-script-candidates %opt{other_buffers_completion} %{
    delete-buffer "%val{client}.preview"
    buffer -- %val{text}
  } -on-change %{
    evaluate-commands -draft -save-regs '"' -verbatim try %{
      buffer -- %val{text}
      set-option "buffer=%val{client}.preview" filetype %opt{filetype}
      execute-keys -save-regs '' '%y'
      execute-keys -buffer "%val{client}.preview" '%R'
      # execute-keys -client %val{client} '<a-;>gg'
    } catch %{
    }
  } -on-abort %{
    delete-buffer "%val{client}.preview"
  }
}
