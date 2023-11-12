define-command open_buffer_picker %{
  evaluate-commands -save-regs 'swct' %{
    execute-keys -draft '%"cy'
    set-register s %val{selections_desc}
    evaluate-commands -draft %{
      execute-keys 'gt'
      set-register w %val{cursor_line}
    }
    set-register t %opt{filetype}
    edit -scratch "%val{client}.preview"
    set-option buffer filetype %reg{t}
    execute-keys "%%""cRge%reg{w}g"
    select %reg{s}
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
