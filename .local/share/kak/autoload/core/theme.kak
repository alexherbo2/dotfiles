define-command load_theme -params 1 -docstring 'load theme' %{
  evaluate-commands %sh{
    if [ -r "$kak_config/themes/$1.kak" ]
    then
      echo 'source "%val{config}/themes/%arg{1}.kak"'
    elif [ -r "$kak_runtime/themes/$1.kak" ]
    then
      echo 'source "%val{runtime}/themes/%arg{1}.kak"'
    else
      echo 'fail "No such theme: “%arg{1}”"'
      exit 1
    fi
  }
}

complete-command -menu load_theme shell-script-candidates %{
  find -L "$kak_config/themes" "$kak_runtime/themes" -type f -name '*.kak' -exec basename -a -s '.kak' -- {} +
}

alias global theme load_theme

define-command open_theme -params 1 -docstring 'open theme' %{
  edit -existing -readonly %arg{1}
}

complete-command -menu open_theme shell-script-candidates %{
  find -L "$kak_config/themes" "$kak_runtime/themes" -type f -name '*.kak'
}
