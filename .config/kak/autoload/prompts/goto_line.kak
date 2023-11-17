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
    index=1
    set -- $1
    while [ "$index" -le "$#" ]
    do selections_desc="%exp{%arg{$index}.1,%arg{$index}.1} $selections_desc"
    index=$((index + 1))
    done
    echo "select $selections_desc"
  }
}
