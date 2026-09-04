def sudo-write %{
  eval %sh{
    if [ -z "$kak_buffile" ]
    then
      echo "fail 'Can’t save with no path set!'"
      exit 1
    fi
  }
  prompt -password password: %{
    echo -to-shell-script %{
      if sudo -S -N -b dd "if=$kak_response_fifo" "of=$kak_buffile"
      then
        echo "write -- $kak_response_fifo; edit!" > "$kak_command_fifo"
      else
        echo "abort 'sudo-write' '$?'"
      fi
    } -- %val{text}
  }
}
