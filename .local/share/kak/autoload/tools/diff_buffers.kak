def diff_buffers -params 2 %{
  eval %sh{
    a=$(mktemp -u)
    b=$(mktemp -u)
    cat <<EOF
      eval -buffer "$1" -verbatim write -- "$a"
      eval -buffer "$2" -verbatim write -- "$b"
      fifo -name "$a_$b.diff" -- diff -u -- "$a" "$b"
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
