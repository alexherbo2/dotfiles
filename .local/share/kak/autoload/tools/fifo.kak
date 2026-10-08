# name: kakoune_fifo
# version: 0.1.0
# description: This script provides the functionality to create buffers from command outputs.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
def -docstring '
usage: fifo [options] [command] [args]
description: create a new fifo buffer from command output.
options: ["-name <buffer_name>", "-scroll", "-append"]
config_options: []
' fifo -params 1.. %{
  eval %sh{
    buffer_name='*fifo*'
    edit_flags=
    append_mode=
    arg_position=1
    while :
    do
      case "$1" in
        '-name')
          buffer_name="$2"
          shift 2
          arg_position=$((arg_position + 2))
          ;;
        '-scroll')
          edit_flags='-scroll'
          shift
          arg_position=$((arg_position + 1))
          ;;
        '-append')
          append_mode=1
          shift
          arg_position=$((arg_position + 1))
          ;;
        '--')
          shift
          break
          ;;
        '-'*)
          printf 'fail "ERROR: %%arg{%d} is not a valid option."\n' "$arg_position"
          exit 1
          ;;
        *)
          break
          ;;
      esac
    done
    fifo_name=$(mktemp -u)
    buffer_content=$(mktemp)
    mkfifo -- "$fifo_name"
    if [ -n "$append_mode" ]
    then
      echo > "$kak_command_fifo" "
        try %{
          eval -buffer '$buffer_name' -verbatim write -- '$buffer_content'
        }
      "
    fi
    { trap - INT QUIT; { cat -- "$buffer_content"; exec "$@"; } > "$fifo_name" 2>&1; } < /dev/null > /dev/null 2>&1 &
    echo "
      edit! ${edit_flags} -fifo '$fifo_name' -- '$buffer_name'
      hook -always -once buffer BufCloseFifo '' %{
        nop %sh{
          rm -- '$fifo_name' '$buffer_content'
        }
      }
    "
  }
}

complete-command fifo shell

alias global ! fifo
