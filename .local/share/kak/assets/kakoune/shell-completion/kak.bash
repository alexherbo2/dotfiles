_kak() {
  local IFS='
'
  local OPTION_WORDLIST=(
    "-c "
    "-C "
    "-e "
    "-E "
    "-n "
    "-s "
    "-d "
    "-p "
    "-f "
    "-i "
    "-q "
    "-ui "
    "-ro "
    "-l "
    "-clear "
    "-debug "
    "-help "
    "-version "
  )
  local UI_TYPE_WORDLIST=(
    "terminal "
    "dummy "
    "json "
  )
  COMPREPLY=(
    $(
      case "$3,$2" in
        -c,*)
          compgen -W "$(kak -l)" -- "$2"
          ;;
        -C,*)
          compgen -W "$(kak -l)" -- "$2"
          ;;
        -p,*)
          compgen -W "$(kak -l)" -- "$2"
          ;;
        -ui,*)
          compgen -W "${UI_TYPE_WORDLIST[*]}" -- "$2"
          ;;
        *,-*)
          compgen -W "${OPTION_WORDLIST[*]}" -- "$2"
          ;;
      esac
    )
  )
}

complete -o bashdefault -o default -o nospace -F _kak kak
