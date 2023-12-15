define-command doc -params 1 -docstring 'show doc' %{
  edit -existing -readonly %arg{1}
}

complete-command -menu doc shell-script-candidates %{
  find -L "$kak_config/autoload" "$kak_runtime/doc" "$kak_runtime/rc" -type f -name '*.asciidoc'
}

alias global d doc
