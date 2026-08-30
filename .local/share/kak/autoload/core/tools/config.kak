def open_kakrc %{
  edit "%val{config}/kakrc"
}

def open_shared_kakrc %{
  edit "%val{runtime}/kakrc"
}

def load_local_kakrc %{
  eval %sh{
    if [ -f '.kakrc' -a -r '.kakrc' ]
    then
      echo "source '.kakrc'"
    fi
  }
}

def open_config -params 1 -docstring 'open config' %{
  edit -existing -readonly %arg{1}
}

compl -menu open_config shell-script-candidates %{
  find -L -- "$kak_config/kakrc" "$kak_runtime/kakrc" -type f -name 'kakrc'
  find -L -- "$kak_config/autoload" "$kak_runtime/autoload" -type f -name '*.kak'
}

alias global config open_config

def grep_config -params 1 -docstring 'grep config' %{
  grep %arg{1} "%val{config}/kakrc" "%val{runtime}/kakrc" "%val{config}/autoload" "%val{runtime}/autoload"
}

compl grep_config shell-script-candidates %{
  {
    find -L -- "$kak_config/kakrc" "$kak_runtime/kakrc" -type f -name 'kakrc'
    find -L -- "$kak_config/autoload" "$kak_runtime/autoload" -type f -name '*.kak'
  } |
  xargs grep -o -h -w '[[:alpha:]][[:alnum:]_-]\+' -- |
  sort -u
}

def explore_config %{
  ls %val{config}
}

def explore_shared_config %{
  ls %val{runtime}
}
