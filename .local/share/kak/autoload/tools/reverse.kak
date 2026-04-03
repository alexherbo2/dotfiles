def reverse_selections %{
  eval -save-regs '"' %sh{
    eval set -- "$kak_quoted_selections"
    jq -s -R -r '$ARGS.positional | reverse | ["reg", "\""] + map("\u0027" + gsub("\u0027"; "\u0027" + "\u0027") + "\u0027") | join(" ")' --args -- "$@"
    echo exec R
  }
}

alias global reverse reverse_selections
