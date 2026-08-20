def open_sudo_write_prompt %{
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
        echo "write $kak_response_fifo; edit!" > "$kak_command_fifo"
      else
        echo "fail 'sudo write failed'"
        exit 1
      fi
    } -- %val{text}
  }
}

alias global sudo-write open_sudo_write_prompt
