define-command diff_buffers -params 2 %{
  evaluate-commands %sh{
    a=$(mktemp -u)
    b=$(mktemp -u)
    cat <<EOF
      evaluate-commands -buffer "$1" write "$a"
      evaluate-commands -buffer "$2" write "$b"
      fifo diff -u -- "$a" "$b"
      rename-buffer "$a_$b.diff"
      set-option buffer filetype diff
      hook -always -once buffer BufCloseFifo "" %{
        nop %sh{
          rm -- "$a" "$b"
        }
      }
EOF
  }
}

complete-command diff_buffers buffer
alias global diff diff_buffers
