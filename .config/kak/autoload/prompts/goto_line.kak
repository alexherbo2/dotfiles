define-command open_goto_line_prompt %{
  prompt goto_line: %{
    goto_lines_from_text %val{text}
  } -on-change %{
    goto_lines_from_text %val{text}
  } -on-abort %exp{
    select -timestamp %val{timestamp} %val{selections_desc}
    restore_viewport %val{window_range}
  }
}

define-command restore_viewport -params 4 %{
  execute-keys "%arg{1}gjvt%arg{2}vlvh"
}

define-command goto_lines_from_text -params .. %{
  evaluate-commands %sh{
    select_command='select '
    for cursor_line in $@
    do select_command="$select_command $cursor_line.1,$cursor_line.1 "
    done
    echo "$select_command"
  }
}
