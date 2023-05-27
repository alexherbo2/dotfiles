define-command open_sudo_write_prompt %{
  prompt -password password: %{
    sudo_write %val{text}
  }
}

alias global sudo-write open_sudo_write_prompt

define-command sudo_write -params 1 %{
  evaluate-commands %sh{
    echo "$1" | sudo -S dd "if=$kak_response_fifo" "of=$kak_buffile" &&
    echo "write $kak_quoted_response_fifo" > "$kak_command_fifo" ||
    echo fail sudo write failed
  }
}
