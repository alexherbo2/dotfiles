# name: kakoune_find
# version: 0.1.0
# description: This script provides support for the find command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
decl -docstring '
find_command = "sh"
' str find_command 'sh'
decl -docstring '
find_args = ["-c", "find...", "--"]
' str-list find_args -c %{
  find_flags=
  while getopts ':HL' opt
  do
    case "$opt" in
      'H')
        find_flags='-H'
        ;;
      'L')
        find_flags='-L'
        ;;
      ':')
        printf 'ERROR: -%s is missing something.\n' "$OPTARG" >&2
        exit 1
        ;;
      '?')
        printf 'ERROR: -%s is not a valid option.\n' "$OPTARG" >&2
        exit 1
        ;;
      *)
        break
        ;;
    esac
  done
  shift $((OPTIND - 1))
  case "$#" in
    2)
      find $find_flags -- "$2" -type 'f' -name "$1"
      ;;
    1)
      find $find_flags . -type 'f' -name "$1"
      ;;
    0)
      find $find_flags . -type 'f'
      ;;
    *)
      find_name="$1"
      shift
      find $find_flags -- "$@" -type 'f' -name "$find_name"
      ;;
  esac
} --

def -docstring '
usage: find [options] [pattern] [paths]
kakoune_options: ["find_command", "find_args"]
' find -params .. %{
  eval -save-regs '"' %{
    try %{
      exec -buffer '*find*' -save-regs '' '%y'
    } catch %{
      reg '"'
    }
    fifo -name '*find*' -- %opt{find_command} %opt{find_args} %arg{@}
    exec -buffer '*find*' 'P'
  }
}

complete-command find file

def -hidden jump_to_files %{
  eval -draft %{
    exec 'x<a-s><a-K>^\n<ret>H'
    eval -itersel %{
      eval -client %val{client} -verbatim edit -existing -- %val{selection}
    }
  }
}

def -hidden select_find_entries -params 1 %{
  exec "x<a-s>%arg{1}s\A(.+?)\n\z<ret>"
}
