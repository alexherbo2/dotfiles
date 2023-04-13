add-highlighter shared/grep regex '^(.+?):(\d+):(\d+):(.+?)$' 1:string 2:value 3:value

hook -group grep-highlight global BufSetOption filetype=grep %{
  add-highlighter buffer/grep ref grep
  hook -always -once buffer BufSetOption 'filetype=.*' %{
    remove-highlighter buffer/grep
  }
}

define-command -hidden grep_jump %{
  evaluate-commands -draft %{
    execute-keys ',;xs^(.+?):(\d+):(\d+):(.+?)$<ret>'
    evaluate-commands -client %val{client} -- edit -existing %reg{1} %reg{2} %reg{3}
  }
}

define-command grep -params .. %{
  reg d %sh{mktemp -d}
  reg f "%reg{d}/fifo"
  reg b "%arg{@}.refs"
  nop %sh{
    mkfifo "$kak_reg_f"
    { "$@" -- "$kak_text" > "$kak_reg_f"; } < /dev/null > /dev/null 2>&1 &
  }
  edit! -fifo %reg{f} %reg{b}
  set-option buffer filetype grep
  map buffer normal <ret> ': grep_jump<ret>'
  hook -always -once buffer BufCloseFifo '' "nop %%sh{ echo rm -Rf ""%reg{d}"" >> ~/t.txt }"
}

declare-option str grep_command rg
declare-option str-list grep_args --hidden --column --with-filename
complete-command grep shell-completion
