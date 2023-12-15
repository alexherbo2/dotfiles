define-command helpgrep -params 1 -docstring 'grep help' %{
  grep %arg{1} "%val{runtime}/doc" "%val{runtime}/autoload" "%val{config}/doc" "%val{config}/autoload"
}

complete-command helpgrep shell-script-candidates %{
  find -L "$kak_runtime/doc" "$kak_runtime/autoload" "$kak_config/doc" "$kak_config/autoload" -type f '(' -name '*.asciidoc' -or -name '*.md' ')' -exec grep -o -h '\w\+' -- {} +
}

alias global hg helpgrep
