define-command open_doc -params 1 -docstring 'open doc' %{
  edit -existing -readonly %arg{1}
}

complete-command -menu open_doc shell-script-candidates %{
  find -L "$kak_config/doc" "$kak_runtime/doc" -type f '(' -name '*.asciidoc' -or -name '*.md' ')'
}

alias global doc open_doc

define-command grep_doc -params 1 -docstring 'grep doc' %{
  grep %arg{1} "%val{config}/doc" "%val{runtime}/doc"
}

complete-command grep_doc shell-script-candidates %{
  find -L "$kak_config/doc" "$kak_runtime/doc" -type f '(' -name '*.asciidoc' -or -name '*.md' ')' -exec grep -o -h -w '[[:alpha:]][[:alnum:]_-]\+' -- {} + | sort -u
}
