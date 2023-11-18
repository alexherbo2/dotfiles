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
  evaluate-commands %sh{
    selections_desc=
    IFS=','
    for cursor_line in $1
    do
      if [ "$cursor_line" -eq "$cursor_line" ]
      then
        selections_desc="$cursor_line.1,$cursor_line.1 $selections_desc"
      else
        echo 'fail "cannot parse text as a list of integers: %arg{1}"'
        exit 1
      fi
    done
    echo "select $selections_desc"
  }
}
