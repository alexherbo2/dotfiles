def show_working_directory %{
  echo -- %sh{pwd}
}

alias global pwd show_working_directory
