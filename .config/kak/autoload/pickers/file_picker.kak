define-command open_file_picker %{
  evaluate-commands -save-regs '^"' %{
    execute-keys -draft -save-regs '' '%y'
    set-register ^ %val{selections_desc}
    edit -scratch "%val{client}.preview"
    execute-keys '%R'
    select %reg{^}
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
    } catch %{
      edit -existing -- %val{text}
      set-option "buffer=%val{client}.preview" filetype %opt{filetype}
      execute-keys -save-regs '' '%y'
      execute-keys -buffer "%val{client}.preview" '%R'
      delete-buffer "%val{client}.preview"
    } catch %{
    }
  } -on-abort %{
    delete-buffer "%val{client}.preview"
  }
}
