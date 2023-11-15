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
    } catch %{
      remove_preview
    }
    execute-keys '<a-;>gg'
  } -on-abort %{
    close_preview
  }
}
