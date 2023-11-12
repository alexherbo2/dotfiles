define-command open_file_picker %{
  evaluate-commands -save-regs 'swct' %{
    execute-keys -draft '%"cy'
    set-register s %val{selections_desc}
    set-register w %val{window_range}
    set-register t %opt{filetype}
    edit -scratch "%val{client}.preview"
    set-option buffer filetype %reg{t}
    evaluate_commands_with_values %{
      execute-keys "%%""cRge%arg{2}gjvt"
    } %reg{w}
    select %reg{s}
  }
  prompt open: -menu -shell-script-candidates %opt{find_completion} %{
    delete-buffer "%val{client}.preview"
    edit -existing -- %val{text}
  } -on-change %{
    evaluate-commands -draft -save-regs '"' -verbatim try %{
      buffer -- %val{text}
      set-option "buffer=%val{client}.preview" filetype %opt{filetype}
      execute-keys -save-regs '' '%y'
      execute-keys -buffer "%val{client}.preview" '%R'
      # execute-keys -client %val{client} '<a-;>gg'
    } catch %{
      edit -existing -- %val{text}
      set-option "buffer=%val{client}.preview" filetype %opt{filetype}
      execute-keys -save-regs '' '%y'
      execute-keys -buffer "%val{client}.preview" '%R'
      delete-buffer -- %val{text}
      # execute-keys -client %val{client} '<a-;>gg'
    } catch %{
    }
  } -on-abort %{
    delete-buffer "%val{client}.preview"
  }
}
