define-command open_goto_line_prompt %{
  prompt goto_line: %{
    evaluate-commands goto_lines %val{text}
  } -on-change %exp{
    try %%{
      evaluate-commands goto_lines %%val{text}
    } catch %%{
      select -timestamp %val{timestamp} %val{selections_desc}
    }
  } -on-abort %exp{
    restore_viewport %val{window_range}
    select -timestamp %val{timestamp} %val{selections_desc}
  }
}

define-command restore_viewport -params 4 %{
  execute-keys "%arg{1}gjvt%arg{2}vlvh"
}

define-command goto_lines -params .. %{
  evaluate-commands select %sh{
    for cursor_line do
      printf '%d.1,%d.1 ' "$cursor_line" "$cursor_line"
    done
  }
}
