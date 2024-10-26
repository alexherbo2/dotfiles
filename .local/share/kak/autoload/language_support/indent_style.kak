# Implementation reference:
# https://github.com/helix-editor/helix/blob/master/helix-core/src/indent.rs
define-command set_current_buffer_indent_style -params 1 %{
  set-option buffer indentwidth %arg{1}
}
alias global set-indent-style set_current_buffer_indent_style

define-command detect_current_buffer_indent_style %{
  detect_indent_style %val{bufname}
}
alias global detect-indent-style detect_current_buffer_indent_style

define-command show_current_buffer_indent_style %{
  echo -markup "{Information}indentwidth=%opt{indentwidth}"
}

alias global show-indent-style show_current_buffer_indent_style

define-command detect_indent_style -params 1 %{
  analyze_indent_style %arg{1}
  try_infer_indent_style %arg{1} %val{selections}
  delete-buffer
}

define-command analyze_indent_style -params 1 %{
  evaluate-commands -buffer %arg{1} -verbatim try %{
    set-register h
    execute-keys '1000gGgx<a-s><a-K>^\h*$<ret>'
    evaluate-commands -draft -itersel -verbatim try %{
      execute-keys 's^\t+<ret>'
      set-register h %reg{h} 1 %val{selection_length}
    } catch %{
      execute-keys 's^ +<ret>'
      set-register h %reg{h} 0 %val{selection_length}
    } catch %{
      set-register h %reg{h} 0 0
    }
  }
  edit -scratch
  try %{
    execute-keys '"h<a-R>a<ret><esc><a-_>s[01]\n\d+<ret><a-j>x<a-,>yp1,O0 0<esc>%s([01]+ \d+\n){2}<ret><a-k>\A1|\A0 0<ret>hk<a-i>nyjA-<c-r>"<esc>xy%<a-R>ghWd%|bc<ret><a-s>Px<a-k>\A[01] [1-9]\d*<ret>y%<a-R><a-_>|sed "s/^1 [0-9]\\+/1 0/"<ret><a-s>h<a-i>nLy%<a-R><a-_>|sort | uniq -c | sort -n -r<ret>s\d+<ret>'
  } catch %{
    execute-keys '%c-1 -1<esc>%s-1<ret>'
  }
}

define-command try_infer_indent_style -params 3.. %{
  evaluate-commands %sh{
    if [ "$3" -eq 0 -o "$3" -eq 2 -o "$3" -eq 4 -o "$3" -eq 6 -o "$3" -eq 8 ] && [ "$2" -gt 0 ] && echo "${4:-0} / $2 < 0.66" | bc -l | grep -q 1; then
      printf 'set-option "buffer=%%arg{1}" indentwidth %d' "$3"
    fi
  }
}

complete-command detect_indent_style buffer
complete-command analyze_indent_style buffer
complete-command try_infer_indent_style buffer
