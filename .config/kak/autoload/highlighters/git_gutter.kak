declare-option line-specs git_diff_flags

define-command update_git_diff_flags %{
  evaluate-commands %sh{
    if git ls-files --error-unmatch "$kak_buffile" > /dev/null 2>&1; then
      echo "set-option buffer git_diff_flags %val{timestamp}"
      exit 1
    fi

    a=$(mktemp)
    b=$(mktemp)
    trap 'rm "$a" "$b"' EXIT

    cd $(dirname "$kak_buffile")

    git_rev=HEAD
    git_path=$(git ls-files "$kak_buffile")
    git show "$git_rev:$git_path" > "$a"

    echo "write $kak_response_fifo" > "$kak_command_fifo"
    cat "$kak_response_fifo" > "$b"

    printf 'set-option buffer git_diff_flags %%val{timestamp} '

    diff -U0 "$a" "$b" |
    grep -o '^@@[^@]*@@' | sed -E 's/([-+][0-9]) /\1,1 /g' | grep -o '[0-9]*' |
    while read from_line; read from_count; read to_line; read to_count; do
      # is added
      if [ "$from_count" -eq 0 ] && [ "$to_count" -gt 0 ]; then
        printf ' %d|{green}+ ' $(seq "$to_line" $((to_line + to_count - 1)))
      # all removed
      elif [ "$from_count" -gt 0 ] && [ "$to_count" -eq 0 ] && [ "$to_line" -eq 0 ]; then
        printf ' 1|{red}x '
      # is removed
      elif [ "$from_count" -gt 0 ] && [ "$to_count" -eq 0 ]; then
        printf ' %d|{red}- ' "$to_line"
      # is modified
      elif [ "$from_count" -gt 0 ] && [ "$to_count" -gt 0 ] && [ "$from_count" -eq "$to_count" ]; then
        printf ' %d|{blue}~ ' $(seq "$to_line" $((to_line + to_count - 1)))
      # is modified and added
      elif [ "$from_count" -gt 0 ] && [ "$to_count" -gt 0 ] && [ "$from_count" -lt "$to_count" ]; then
        printf ' %d|{blue}~ ' $(seq "$to_line" $((to_line + from_count - 1)))
        printf ' %d|{green}+ ' $(seq $((to_line + from_count)) $((to_line + to_count - 1)))
      # is modified and removed
      elif [ "$from_count" -gt 0 ] && [ "$to_count" -gt 0 ] && [ "$from_count" -gt "$to_count" ]; then
        printf ' %d|{blue}~ ' $(seq "$to_line" $((to_line + to_count - 2)))
        printf ' %d|{blue+u}v ' $((to_line + to_count - 1))
      fi
    done
  }
}

add-highlighter shared/git_diff flag-lines LineNumbers git_diff_flags
hook global BufWritePost .* %{
  hook -once buffer NormalIdle .* %{
    update_git_diff_flags
  }
}
hook global BufOpenFile .* %{
  hook -once buffer NormalIdle .* %{
    update_git_diff_flags
  }
}
hook global NormalKey 'dc' %{
  hook -once buffer NormalIdle .* %{
    update_git_diff_flags
  }
}
hook global ModeChange pop:insert:normal %{
  hook -once buffer NormalIdle .* %{
    update_git_diff_flags
  }
}
