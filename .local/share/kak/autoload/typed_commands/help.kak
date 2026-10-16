def -docstring "
usage: help [subject]
description: open documentation.
config_options: []
" help -params 1 %{
  eval %sh{
    if [ -r "$kak_config/docs/$1.md" ]
    then
      echo 'view "%val{config}/docs/%arg{1}.md"'
    elif [ -r "$kak_runtime/docs/$1.md" ]
    then
      echo 'view "%val{runtime}/docs/%arg{1}.md"'
    else
      echo 'fail "No such topic: “%arg{1}”"'
      exit 1
    fi
  }
}

compl -menu help shell-script-candidates %{
  find -L -- "$kak_config/docs" "$kak_runtime/docs" -type f -name "*.md" -exec basename -a -s ".md" -- {} +
}
