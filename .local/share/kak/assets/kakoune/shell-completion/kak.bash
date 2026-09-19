_kak() {
  local IFS='
'
  local OPTION_WORDLIST=(
    "-p "
    "--pick-command="
    "-m "
    "--map-command="
    "-d "
    "--drop-command="
    "-P "
    "--pick-shell-script="
    "-M "
    "--map-shell-script="
    "-D "
    "--drop-shell-script="
    "-e "
    "--editor="
    "-f "
    "--filter="
    "-E "
    "--no-edit "
    "--no-pick "
    "--no-map "
    "--no-drop "
    "- "
    "-h "
    "--help "
    "-V "
    "--version "
  )
  COMPREPLY=(
    $(
      case "$3,$2" in
        -p,*|--pick-command,*)
          compgen -A command -- "$2"
          ;;
        -m,*|--map-command,*)
          compgen -A command -- "$2"
          ;;
        -d,*|--drop-command,*)
          compgen -A command -- "$2"
          ;;
        -P,*|--pick-shell-script,*)
          compgen -A command -- "$2"
          ;;
        -M,*|--map-shell-script,*)
          compgen -A command -- "$2"
          ;;
        -D,*|--drop-shell-script,*)
          compgen -A command -- "$2"
          ;;
        -e,*|--editor,*)
          compgen -A command -- "$2"
          ;;
        -f,*|--filter,*)
          compgen -A command -- "$2"
          ;;
        *,-*)
          compgen -W "${OPTION_WORDLIST[*]}" -- "$2"
          ;;
      esac
    )
  )
}

complete -o bashdefault -o default -o nospace -F _kak kak
