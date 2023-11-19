define-command reverse_selections %{
  evaluate-commands -save-regs '"' %sh{
    eval set -- "$kak_quoted_selections"
    jq -s -R -r '$ARGS.positional | reverse | ["set-register", "dquote"] + map("\u0027" + gsub("\u0027"; "\u0027" + "\u0027") + "\u0027") | join(" ")' --args -- "$@"
    echo execute-keys R
  }
}

alias global reverse reverse_selections
