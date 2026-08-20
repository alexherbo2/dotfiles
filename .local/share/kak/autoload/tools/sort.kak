def sort_selections %{
  eval -save-regs '"' %sh{
    eval set -- "$kak_quoted_selections"
    jq -s -R -r '$ARGS.positional | sort | ["reg", "\"\"\"\""] + map("\u0027" + gsub("\u0027"; "\u0027\u0027") + "\u0027") + [";", "exec", "R"] | join(" ")' --args -- "$@"
  }
}

alias global sort sort_selections
