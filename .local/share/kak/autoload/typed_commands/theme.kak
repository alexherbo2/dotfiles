def -docstring "
usage: theme [theme_name]
description: load theme.
config_options: []
" theme -params 1 %{
  eval %sh{
    if [ -r "$kak_config/themes/$1.kak" ]
    then
      echo 'source "%val{config}/themes/%arg{1}.kak"; trigger-user-hook "ThemeChanged=%arg{1}"'
    elif [ -r "$kak_runtime/themes/$1.kak" ]
    then
      echo 'source "%val{runtime}/themes/%arg{1}.kak"; trigger-user-hook "ThemeChanged=%arg{1}"'
    else
      echo 'fail "No such theme: “%arg{1}”"'
      exit 1
    fi
  }
}

compl -menu theme shell-script-candidates %{
  find -L -- "$kak_config/themes" "$kak_runtime/themes" -type f -name "*.kak" -exec basename -a -s ".kak" -- {} +
}
