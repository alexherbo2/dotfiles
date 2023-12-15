define-command docgrep -params 1 -docstring 'grep doc' %{
  evaluate-commands -save-regs 'f' %{
    set-register f
    evaluate-commands %sh{
      find -L "$kak_config/autoload" "$kak_runtime/doc" "$kak_runtime/rc" -type f -name '*.asciidoc' | xargs printf "set-register f %%reg{f} '%s';"
    }
    grep %arg{1} %reg{f}
  }
}

complete-command docgrep shell-script-candidates %{
  find -L "$kak_config/autoload" "$kak_runtime/doc" "$kak_runtime/rc" -type f -name '*.asciidoc' | xargs grep -o -h '\w\+' -- | sort -u
}

alias global dg docgrep
