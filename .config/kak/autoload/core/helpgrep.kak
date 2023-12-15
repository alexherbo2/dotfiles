define-command helpgrep -params 1 -docstring 'grep help' %{
  evaluate-commands -save-regs 'f' %{
    set-register f
    evaluate-commands %sh{
      find -L "$kak_config/autoload" "$kak_runtime/doc" "$kak_runtime/rc" -type f -name '*.asciidoc' | xargs printf "set-register f %%reg{f} '%s';"
    }
    grep %arg{1} %reg{f}
  }
}

complete-command helpgrep shell-script-candidates %{
  find -L "$kak_config/autoload" "$kak_runtime/doc" "$kak_runtime/rc" -type f -name '*.asciidoc' | xargs grep -o -h '\w\+' -- | sort -u
}

alias global hg helpgrep
