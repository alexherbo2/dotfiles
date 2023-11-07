define-command create_buffer_from_command_output -params 2.. %{
  set-register f %sh{mktemp -u}
  nop %sh{
    shift
    mkfifo "$kak_reg_f"
    { "$@" > "$kak_reg_f" 2>&1; } < /dev/null > /dev/null 2>&1 &
  }
  edit! -scroll -fifo %reg{f} -- %arg{1}
  hook -always -once buffer BufCloseFifo '' "
    nop %%sh{
      unlink ""%reg{f}""
    }
  "
}

define-command create_auto_named_buffer_from_command_output -params 1.. %{
  create_buffer_from_command_output "%arg{@}.output" %arg{@}
}

complete-command create_buffer_from_command_output shell
complete-command create_auto_named_buffer_from_command_output shell

alias global !! create_buffer_from_command_output
alias global ! create_auto_named_buffer_from_command_output
alias global fifo create_auto_named_buffer_from_command_output
