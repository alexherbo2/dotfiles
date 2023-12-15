define-command docimpl -params 1 -docstring 'goto impl' %{
  grep %arg{1} "%val{config}/autoload" "%val{runtime}/rc"
}

complete-command docimpl shell-script-candidates %{
  find -L "$kak_config/autoload" "$kak_runtime/rc" -type f -name '*.kak' | xargs pcregrep -o -h '\b\w[\w-]+\b' -- | sort -u
}

alias global di docimpl
