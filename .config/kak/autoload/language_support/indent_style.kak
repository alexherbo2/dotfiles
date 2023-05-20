# Implementation reference:
# https://github.com/helix-editor/helix/blob/master/helix-core/src/indent.rs
# hook global BufOpenFile .* 'hook -once buffer NormalIdle .* detect_current_buffer_indent_style'
define-command detect_current_buffer_indent_style %{
  detect_indent_style %val{bufname}
}

define-command detect_indent_style -params 1 %{
  create_indent_style_buffer_report %arg{1}
  try_infer_indent_style %arg{1} %val{selections}
  delete-buffer
}

define-command create_indent_style_buffer_report -params 1 %{
  evaluate-commands -buffer %arg{1} -verbatim try %{
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
  }
  edit -scratch "%arg{1}.indent_style"
  try %{
    execute-keys '"h<a-R>\a<ret><esc><a-_>s\d<plus>\n\d<plus><ret><a-j>x<a-,>ypggO0<space>0<esc><percent>_s\d<plus>\h\d<plus>\n\d<plus>\h\d<plus><ret><a-k>\A1|\A\d<plus>\h0<ret><semicolon>k<a-i>nyjA<minus><c-r>"<esc>xy<percent><a-R>ghWd<percent>|bc<ret><a-s>Px<a-k>\A\d<plus>\h[1<minus>9]\d*<ret>y<percent><a-R><a-_>|sed "s/^1 [0-9]\\+/1 0/"<ret><a-s>h<a-i>nLy<percent><a-R><a-_>|sort|uniq<space><minus>c|sort<space><minus>nr<ret>s\d+<ret>'
  } catch %{
    execute-keys '%c-1 -1<esc>%s-1<ret>'
  }
}

define-command try_infer_indent_style -params 2.. %{
  evaluate-commands %sh{
    shift
    indent_freq=${1:-0}
    indent=${2:-0}
    indent_freq_2=${3:-0}
    indent_2=${4:-0}
    if [ "$indent_freq" -gt 0 ] && echo "$indent_freq_2 / $indent_freq < 0.66" | bc -l | grep -q 1; then
      printf 'set-option "buffer=%%arg{1}" indentwidth %d\n' "$indent"
    fi
  }
}

complete-command detect_indent_style buffer
complete-command create_indent_style_buffer_report buffer
complete-command try_infer_indent_style buffer
