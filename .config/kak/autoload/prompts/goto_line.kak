define-command open_goto_line_prompt %{
  prompt goto_line: %{
    evaluate-commands goto_lines %val{text}
  } -on-change %exp{
    try %%{
      evaluate-commands goto_lines %%val{text}
    } catch %%{
      # restore_viewport %val{window_range}
      select -timestamp %val{timestamp} %val{selections_desc}
    }
  } -on-abort %exp{
    # restore_viewport %val{window_range}
    select -timestamp %val{timestamp} %val{selections_desc}
  }
}

define-command restore_viewport -params 4 %{
  execute-keys "%arg{1}gjvt%arg{2}vlvh"
}

define-command goto_lines -params .. %{
  evaluate-commands select %sh{
    index=$#
    while [ "$index" -ge 1 ]; do
      printf '"%%arg{%d}.1,%%arg{%d}.1" ' "$index" "$index"
      index=$((index - 1))
    done
  }
}
