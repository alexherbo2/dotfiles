define-command grep_buffers -params 1 %{
  set-register / %arg{1}
  edit! -scratch -debug -- "%arg{1}.refs"
  evaluate-commands -no-hooks -buffer '*' -verbatim -- try %{
    execute-keys '%s<ret><a-;>'
    evaluate-commands -itersel -save-regs 'ab' %{
      set-register a "%val{bufname}:%val{cursor_line}:%val{cursor_column}:"
      execute-keys 'x<a-:>H"by'
      execute-keys -buffer "%arg{1}.refs" 'ge"apH"bp<a-j>'
    }
  }
  execute-keys 'd'
}

define-command open_buffer_search_prompt %{
  prompt buffer_search: -shell-script-candidates %opt{grep_word_completion} %{
    grep_buffers %val{text}
  }
}
