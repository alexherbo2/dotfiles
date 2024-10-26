define-command open_kakrc %{
  edit "%val{config}/kakrc"
}

define-command load_local_kakrc %{
  evaluate-commands %sh{
    if [ -f '.kakrc' -a -r '.kakrc' ]
    then
      echo "source '.kakrc'"
    fi
  }
}

define-command open_config -params 1 -docstring 'open config' %{
  edit -existing -readonly %arg{1}
}

complete-command -menu open_config shell-script-candidates %{
  find -L "$kak_config/kakrc" "$kak_runtime/kakrc" -type f -name 'kakrc'
  find -L "$kak_config/autoload" "$kak_runtime/autoload" -type f -name '*.kak'
}

alias global config open_config

define-command grep_config -params 1 -docstring 'grep config' %{
  grep %arg{1} "%val{config}/kakrc" "%val{runtime}/kakrc" "%val{config}/autoload" "%val{runtime}/autoload"
}

complete-command grep_config shell-script-candidates %{
  find -L "$kak_config/autoload" "$kak_runtime/autoload" -type f -name '*.kak' -exec grep -o -h -w '[[:alpha:]][[:alnum:]_-]\+' -- {} + | sort -u
}
