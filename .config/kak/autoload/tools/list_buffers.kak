define-command list_buffers %{
  evaluate-commands -try-client %opt{tools_client} %{
    edit! -scratch -- '*buffers*'
    edit! -scratch -debug -- '*buffers_tmp*'
    evaluate-commands -no-hooks -buffer '*' -verbatim -- try %{
      execute-keys '%s<ret><a-;>'
      evaluate-commands -itersel -save-regs '"' %{
        set-register dquote "%val{bufname} (%opt{filetype}:%opt{readonly}:%val{cursor_column}:%val{modified})"
        execute-keys -buffer '*buffers_tmp*' 'gep'
      }
    }
    execute-keys 'd%y:delete-buffer<ret>Rgg'
  }
}
