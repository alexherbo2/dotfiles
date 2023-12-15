define-command help -params 1 -docstring 'show help' %{
  edit -existing -readonly %arg{1}
}

complete-command -menu help shell-script-candidates %{
  find -L "$kak_runtime/doc" "$kak_runtime/autoload" "$kak_config/doc" "$kak_config/autoload" -type f '(' -name '*.asciidoc' -or -name '*.md' ')'
}

alias global h help
