define-command mkdir %{
  evaluate-commands %sh{
    mkdir -p -- "$(dirname -- "$kak_buffile")" ||
    printf "fail 'ERROR: mkdir exited with: %d.'" "$?"
  }
}
