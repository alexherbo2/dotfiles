declare-option -hidden line-specs git_diff_line_specs

hook global ModeChange pop:insert:.* gitdiff
hook global NormalIdle .* gitdiff
hook global BufOpenFile .* %{
  hook -once buffer NormalIdle .* %{
    gitdiff
  }
}

define-command -hidden gitdiff %{
  evaluate-commands %sh{
    is_added() {
      [ "$2" -eq 0 ] && [ "$4" -gt 0 ]
    }

    is_removed() {
      [ "$2" -gt 0 ] && [ "$4" -eq 0 ]
    }

    is_modified() {
      [ "$2" -gt 0 ] && [ "$4" -gt 0 ] && [ "$2" -eq "$4" ]
     }

    is_modified_and_added() {
      [ "$2" -gt 0 ] && [ "$4" -gt 0 ] && [ "$2" -lt "$4" ]
     }

    is_modified_and_removed() {
      [ "$2" -gt 0 ] && [ "$4" -gt 0 ] && [ "$2" -gt "$4" ]
    }

    process_added() {
      index=0
      while [ "$index" -lt "$4" ]; do
        line_number=$(($3+index))
        printf ' %d|{green}┃ ' "$line_number"
        index=$((index + 1))
      done
    }

    process_removed() {
      if [ "$3" -eq 0 ]; then
        printf ' 1|{value}X '
      else
        printf ' %d|{value}┃ ' "$3"
      fi
    }

    process_modified() {
      index=0
      while [ "$index" -lt "$4" ]; do
        line_number=$(($3+index))
        printf ' %d|{blue}┃ ' "$line_number"
        index=$((index+1))
      done
    }

    process_modified_and_added() {
      index=0
      while [ "$index" -lt "$2" ]; do
        line_number=$(($3+index))
        printf ' %d|{blue}┃ ' "$line_number"
        index=$((index+1))
      done
      while [ "$index" -lt "$4" ]; do
        line_number=$(($3+index))
        printf ' %d|{green}┃ ' "$line_number"
        index=$((index+1))
      done
    }

    process_modified_and_removed() {
      index=0
      while [ $index -lt "$4" ]; do
        line_number=$(($3+index))
        printf ' %d|{blue}┃ ' "$line_number"
        index=$((index+1))
      done
      printf ' %d|{red}┃ ' $(($3+index))
    }

    process_hunk() {
      is_added "$@" \
        && process_added "$@" \
        && return 0
      is_removed "$@" \
        && process_removed "$@" \
        && return 0
      is_modified "$@" \
        && process_modified "$@" \
        && return 0
      is_modified_and_added "$@" \
        && process_modified_and_added "$@" \
        && return 0
      is_modified_and_removed "$@" \
        && process_modified_and_removed "$@" \
        && return 0
    }

    git_diff() {
      printf 'set-option buffer git_diff_line_specs %%val{timestamp} '
      git --no-pager diff --no-ext-diff --no-color -U0 "$1" "$2" |
      grep -o '^@@[^@]*@@' | sed -E 's/([-+][0-9]) /\1,1 /g' | grep -o '[0-9]*' |
      while read from_line; read from_count; read to_line; read to_count; do
        process_hunk "$from_line" "$from_count" "$to_line" "$to_count"
      done
    }
    bufdir=${kak_buffile%/*}
    bufname=${kak_buffile##*/}
    tmpdir=$(mktemp -d)
    a=$tmpdir/a
    b=$tmpdir/b
    trap 'rm -Rf "$tmpdir"' EXIT
    echo "write $kak_response_fifo" > "$kak_command_fifo"
    cat "$kak_response_fifo" > "$b"
    if [ -f "${kak_buffile}" ]; then
      git -C "$bufdir" --no-pager show "HEAD:./$bufname" > "$a" &&
      git_diff "$a" "$b"
    else
      echo "set-option buffer git_diff_line_specs %val{timestamp}"
    fi
  }
}

add-highlighter global/ flag-lines LineNumbers git_diff_line_specs
