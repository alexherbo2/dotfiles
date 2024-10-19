declare-option str global_search_word_completion %{
  kak_response_fifo=$(mktemp -u)
  mkfifo "$kak_response_fifo"
  echo "evaluate-commands -client $kak_client -verbatim write $kak_response_fifo" | kak -p "$kak_session"
  grep -o -w '[[:alpha:]][[:alnum:]_-]\+' < "$kak_response_fifo" | sort -u
  unlink "$kak_response_fifo"
}

define-command open_global_search_prompt %{
  prompt global_search: -init "%reg{/}" -shell-script-candidates %opt{global_search_word_completion} %{
    set-register / %val{text}
    grep -- %val{text}
  }
}
