define-command -hidden open_named_buffer_with_output -params 2.. %{
  set-register f %sh{mktemp -u}
  nop %sh{
    shift
    mkfifo "$kak_reg_f"
    { "$@" > "$kak_reg_f" 2>&1; } < /dev/null > /dev/null 2>&1 &
  }
  edit! -scroll -fifo %reg{f} %arg{1}
  hook -always -once buffer BufCloseFifo '' "
    nop %%sh{
      unlink ""%reg{f}""
    }
  "
}

define-command -hidden open_buffer_with_output -params 1.. %{
  open_named_buffer_with_output "%arg{@}.output" %arg{@}
}

complete-command open_buffer_with_output shell

alias global ! open_buffer_with_output
