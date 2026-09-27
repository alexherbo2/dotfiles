compl rename-session shell-script-candidates %{
  if [ -r "$kak_config/friendly_session_names.txt" ]
  then
    cat -- "$kak_config/friendly_session_names.txt"
  else
    cat -- "$kak_runtime/friendly_session_names.txt"
  fi
}

def find_friendly_session_name %{
  rename-session %sh{
    session_list_file=$(mktemp)
    trap 'rm -f -- "$session_list_file"' EXIT
    kak -l | grep -v '^.\+\s(dead)$' > "$session_list_file"
    if [ -r "$kak_config/friendly_session_names.txt" ]
    then
      grep -Fxv -f "$session_list_file" -- "$kak_config/friendly_session_names.txt" |
      shuf -n 1
    else
      grep -Fxv -f "$session_list_file" -- "$kak_runtime/friendly_session_names.txt" |
      shuf -n 1
    fi
  }
}
