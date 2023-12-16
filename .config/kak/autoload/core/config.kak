define-command open_kakrc %{
  edit "%val{config}/kakrc"
}

define-command open_config -params 1 -docstring 'open config' %{
  edit -existing -readonly %arg{1}
}

complete-command -menu open_config shell-script-candidates %{
  find -L "$kak_config/autoload" "$kak_runtime/rc" -type f -name '*.kak'
}

alias global config open_config

define-command grep_config -params 1 -docstring 'grep config' %{
  grep %arg{1} "%val{config}/autoload" "%val{runtime}/rc"
}

complete-command grep_config shell-script-candidates %{
  find -L "$kak_config/autoload" "$kak_runtime/rc" -type f -name '*.kak' -exec grep -o -h -w '[[:alpha:]][[:alnum:]_-]\+' -- {} + | sort -u
}
