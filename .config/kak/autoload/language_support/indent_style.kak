# Implementation reference:
# https://github.com/helix-editor/helix/blob/master/helix-core/src/indent.rs
# hook on file open and buffer reload.
# hook global BufOpenFile '.*' detect_indent_style
# hook global BufReload '.*' detect_indent_style
define-command detect_indent_style %{
  evaluate-commands -save-regs 'h' -draft -verbatim try %{
    set-register h
    execute-keys -save-regs '' '1000gGgx<a-s><a-K>^\h*$<ret>'
    evaluate-commands -draft -itersel -verbatim -- try %{
      execute-keys '<a-k>^\t<ret>s^\h+<ret>s\t<ret>'
      set-register h %reg{h} 1 %val{selection_count}
    } catch %{
      execute-keys '<a-k>^<space><ret>s^\h+<ret>s<space><ret>'
      set-register h %reg{h} 0 %val{selection_count}
    } catch %{
      set-register h %reg{h} 0 0
    }
    edit -scratch
    execute-keys '"h<a-R>\a<ret><esc><a-_>s\d<plus>\n\d<plus><ret><a-j>x<a-,>ypggO0<space>0<esc><percent>_s\d<plus>\h\d<plus>\n\d<plus>\h\d<plus><ret><a-k>\A1|\A\d<plus>\h0<ret><semicolon>k<a-i>nyjA<minus><c-r>"<esc>xy<percent><a-R>ghWd<percent>|bc<ret><a-s>Px<a-k>\A\d<plus>\h[1<minus>9]\d*<ret>Z<a-k>\A1<ret>h<a-i>nc0<esc>zh<a-i>nLy<percent><a-R><a-_>|sort|uniq<space><minus>c|sort<space><minus>nr<ret>s\d+<ret>"hy'
    delete-buffer
    echo -debug %sh{
      eval set -- "$kak_quoted_reg_h"
      echo "$@"
      indent_freq=${$1:-0}
      indent=${$2:-0}
      indent_freq_2=${$3:-0}
      indent_2=${$4:-0}
      if [ "$indent_freq" -gt 0 ] && echo "$indent_freq_2 / $indent_freq < 0.66" | bc -l | grep -q 1; then
        echo set-option buffer indentwidth "$indent"
      fi
    }
  }
}
