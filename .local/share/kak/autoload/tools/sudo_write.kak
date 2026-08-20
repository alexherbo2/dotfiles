def open_sudo_write_prompt %{
  prompt -password password: %{
    echo -to-shell-script %{
      if sudo -S -b dd "if=$kak_response_fifo" "of=$kak_buffile"
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
