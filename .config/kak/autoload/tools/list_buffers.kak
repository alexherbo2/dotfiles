define-command list_buffers %{
  evaluate-commands -try-client %opt{tools_client} %{
    edit! -scratch -- '*buffers*'
    edit! -scratch -debug -- '*buffers_tmp*'
    evaluate-commands -no-hooks -buffer '*' -verbatim -- try %{
      set-register dquote "%val{bufname} (filetype=%opt{filetype}, readonly=%opt{readonly}, modified=%val{modified})"
      execute-keys -buffer '*buffers_tmp*' 'gep'
    }
    execute-keys 'd%y:delete-buffer<ret>Rgg'
  }
}
