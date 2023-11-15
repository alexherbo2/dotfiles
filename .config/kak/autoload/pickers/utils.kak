define-command ditto_viewport -params 2 %{
  evaluate-commands -save-regs '"' %{
    buffer -- %arg{1}
    # execute-keys -draft -save-regs '' 'gtGbxy'
    execute-keys -draft -save-regs '' '%y'
    set-option "buffer=%arg{2}" filetype %opt{filetype}
    buffer -- %arg{2}
    # execute-keys '%Rgg'
    execute-keys '%R'
  }
}
