define-command open_goto_line_prompt %{
  prompt goto_line: %{
    goto_lines_from_text %val{text}
  } -on-change %exp{
    try %%{
      goto_lines_from_text %%val{text}
    } catch %%{
      select -timestamp %val{timestamp} %val{selections_desc}
    }
  } -on-abort %exp{
    select -timestamp %val{timestamp} %val{selections_desc}
  }
}

define-command goto_lines_from_text -params 1 %{
  evaluate-commands select %sh{
    selections_desc=
    for cursor_line in $1
    do selections_desc="$cursor_line.1,$cursor_line.1 $selections_desc"
    done
    echo "$selections_desc"
  }
}
