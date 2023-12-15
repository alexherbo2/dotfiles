define-command help -params 1 -docstring 'show help' %{
  edit -existing -readonly %arg{1}
}

complete-command -menu help shell-script-candidates %{
  find -L "$kak_config/autoload" "$kak_runtime/doc" "$kak_runtime/rc" -type f -name '*.asciidoc'
}

alias global h help
