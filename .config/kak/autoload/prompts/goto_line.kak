define-command open_goto_line_prompt %{
  prompt goto_line: %{
    evaluate-commands -verbatim goto_lines %val{text}
  } -on-change %{
    evaluate-commands -verbatim goto_lines %val{text}
  } -on-abort %exp{
    select -timestamp %val{timestamp} %val{selections_desc}
    restore_viewport %val{window_range}
  }
}

define-command restore_viewport -params 4 %{
  execute-keys "%arg{1}gjvt%arg{2}vlvh"
}

define-command goto_lines -params .. %{
  evaluate-commands -verbatim select %sh{
    for cursor_line do
      echo "$cursor_line.1,$cursor_line.1"
    done
  }
}
