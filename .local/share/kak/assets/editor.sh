#!/bin/sh
set -e
line_number=0
while :
do
  case "$1" in
    "+"|"+"[0-9]*)
      line_number="${1#+}"
      shift
      ;;
    "--")
      shift
      break
      ;;
    "-"*)
      echo "ERROR: $1 is not a valid option." >&2
      exit 1
      ;;
    *)
      break
      ;;
  esac
done
if [ "$#" -eq 0 ]
then exit 1
fi
kak_client_init=
if [ -z "$line_number" ]
then kak_client_init="exec -client '$kak_client' 'gj'"
elif [ "$line_number" -gt 0 ]
then kak_client_init="exec -client '$kak_client' -- '${line_number}g'"
fi
realpath -- "$@" |
sed "1!G;h;\$!d;s/'/''/g" |
tr "\\n" "\\0" |
{
  xargs -0 printf "eval -client '$kak_client' -verbatim edit -- '%s'\\n"
  printf "%s\\n" "$kak_client_init"
} |
kak -p "$kak_session"
