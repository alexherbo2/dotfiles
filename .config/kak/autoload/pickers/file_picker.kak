define-command open_file_picker %{
  evaluate-commands -draft -verbatim edit -scratch -- "%val{client}.preview"
  cp_buffers %val{bufname} "%val{client}.preview"
  prompt open: -menu -shell-script-candidates %opt{find_completion} %{
    delete-buffer -- "%val{client}.preview"
    edit -existing -- %val{text}
  } -on-change %{
    evaluate-commands -draft -verbatim try %{
      cp_buffers %val{text} "%val{client}.preview"
      execute-keys -client %val{client} '<a-;>gg'
    } catch %{
      edit -existing -- %val{text}
      cp_buffers %val{text} "%val{client}.preview"
      delete-buffer -- %val{text}
      execute-keys -client %val{client} '<a-;>gg'
    } catch %{}
  } -on-abort %{
    delete-buffer -- "%val{client}.preview"
  }
}
