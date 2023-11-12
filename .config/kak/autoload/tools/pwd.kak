define-command show_working_directory %{
  echo -markup "{Information}%sh{pwd}"
}

alias global pwd show_working_directory
