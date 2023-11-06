define-command sort_selections %{
  evaluate-commands -save-regs '"' %sh{
    printf 'echo -to-file %s -- "%%val{selections}"' "$kak_quoted_response_fifo" > "$kak_command_fifo"
    jq -s -R -r 'split("\u0000") | sort | ["set-register", "dquote"] + map("\u0027" + gsub("\u0027"; "\u0027" + "\u0027") + "\u0027") | join(" ")' "$kak_response_fifo"
    echo execute-keys R
  }
}

alias global sort sort_selections
