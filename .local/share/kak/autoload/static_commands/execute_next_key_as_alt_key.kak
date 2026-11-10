def -docstring "
usage: execute_next_key_as_alt_key
description: execute next key as alt key.
config_options: []
" execute_next_key_as_alt_key %{
  on-key %{
    exec -with-maps -with-hooks %sh{
      case "$kak_key" in
        "<"*">")
          echo "<a-${kak_key#<}"
          break
          ;;
        *)
          echo "<a-$kak_key>"
          break
          ;;
      esac
    }
  }
}
