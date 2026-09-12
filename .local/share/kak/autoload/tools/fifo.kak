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
    mkfifo -- "$fifo_name"
    { trap - INT QUIT; exec "$@" > "$fifo_name" 2>&1; } < /dev/null > /dev/null 2>&1 &
    if [ -z "$append_mode" ]
    then
      cat <<EOF
        edit! ${edit_flags} -fifo "$fifo_name" -- "$buffer_name"
        hook -always -once buffer BufCloseFifo "" %{
          nop %sh{
            unlink -- "$fifo_name"
          }
        }
EOF
    else
      cat <<EOF
        eval -save-regs '"' %{
          try %{
            exec -buffer "$buffer_name" -save-regs '' '%y'
          } catch %{
            reg '"'
          }
          edit! ${edit_flags} -fifo "$fifo_name" -- "$buffer_name"
          exec -buffer "$buffer_name" 'P'
        }
        hook -always -once buffer BufCloseFifo "" %{
          nop %sh{
            unlink -- "$fifo_name"
          }
        }
EOF
    fi
  }
}

complete-command fifo shell

alias global ! fifo
