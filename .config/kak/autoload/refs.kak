# syntax "**/*.refs"
# syntax keywords "^{%a}:[/\\]{%w/\\%._-}|^{%w/\\%._-}"
# syntax symbols ":|,|-|%(|%)"
# syntax literals "%d{%d}"

add-highlighter shared/refs regex '^(.+?):(\d+):(\d+):(.+?)$' 1:string 2:value 3:value

hook global BufOpenFifo '.+\.refs' %{
  set-option buffer filetype refs
}

hook -group grep-highlight global BufSetOption filetype=refs %{
  add-highlighter buffer/refs ref refs
  map buffer normal <ret> ':jump_to_references<ret>'
}

define-command -hidden jump_to_references %{
  evaluate-commands -draft %{
    execute-keys ',;xs^(.+?):(\d+):(\d+):(.+?)$<ret>'
    evaluate-commands -client %val{client} -- edit -existing %reg{1} %reg{2} %reg{3}
  }
}
