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
    execute-keys '"h<a-R>\a<ret><esc><a-_>s\d<plus>\n\d<plus><ret><a-j>x<a-,>ypggO0<space>0<esc><percent>s<space><ret>r<ret><percent>H"hy'
    delete-buffer
    evaluate-commands %sh{
      printf 'echo -to-file %s -- %%val{main_reg_h}' "$kak_quoted_response_fifo" > "$kak_command_fifo"
      while read prev_line_is_tabs; read prev_line_leading_count; read is_tabs; read leading_count; do
        if [ "$prev_line_is_tabs" -eq 1 -o "$prev_line_leading_count" -eq 0 ] && [ "$prev_line_leading_count" -lt "$leading_count" ]; then
          if [ "$is_tabs" -eq 1 ]; then
            echo 0
            echo 0
          else
            amount=$((leading_count - prev_line_leading_count))
            echo "$amount"
          fi
        fi
      done < "$kak_response_fifo" | sort | uniq -c | sort -n -r | head -n 2 | grep -o '\d\+' |
      while true; do
        read indent_freq; read indent; read indent_freq_2; read indent_2
        indent_freq=${indent_freq:-0}
        indent=${indent:-0}
        indent_freq_2=${indent_freq_2:-0}
        indent_2=${indent_2:-0}
        if [ "$indent_freq" -gt 0 ] && echo "$indent_freq_2 / $indent_freq < 0.66" | bc -l | grep -q 1; then
          echo set-option buffer indentwidth "$indent"
        fi
        break
      done
    }
  }
}
