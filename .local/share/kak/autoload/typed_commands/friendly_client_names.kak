compl rename-client shell-script-candidates %{
  if [ -r "$kak_config/friendly_client_names.txt" ]
  then
    cat -- "$kak_config/friendly_client_names.txt"
  else
    cat -- "$kak_runtime/friendly_client_names.txt"
  fi
}

def find_friendly_client_name %{
  rename-client %sh{
    client_list_file=$(mktemp)
    trap 'rm -f -- "$client_list_file"' EXIT
    echo "$kak_client_list" | tr ' ' '\n' > "$client_list_file"
    if [ -r "$kak_config/friendly_client_names.txt" ]
    then
      grep -Fxv -f "$client_list_file" -- "$kak_config/friendly_client_names.txt" |
      shuf -n 1
    else
      grep -Fxv -f "$client_list_file" -- "$kak_runtime/friendly_client_names.txt" |
      shuf -n 1
    fi
  }
}
