def -docstring "
usage: doc [topic_name]
description: open doc.
config_options: []
" doc -params 1 %{
  eval %sh{
    if [ -r "$kak_config/doc/$1.md" ]
    then
      echo 'view "%val{config}/doc/%arg{1}.md"'
    elif [ -r "$kak_runtime/doc/$1.md" ]
    then
      echo 'view "%val{runtime}/doc/%arg{1}.md"'
    else
      echo 'fail "No such topic: “%arg{1}”"'
      exit 1
    fi
  }
}

compl -menu doc shell-script-candidates %{
  find -L -- "$kak_config/doc" "$kak_runtime/doc" -type f -name "*.md" -exec basename -a -s ".md" -- {} +
}
