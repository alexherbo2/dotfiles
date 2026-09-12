def vifm -params .. %{
  terminal env "kak_session=%val{session}" "kak_client=%val{client}" "VISUAL=sh %val{runtime}/assets/editor.sh" "EDITOR=sh %val{runtime}/assets/editor.sh" vifm -c "set vicmd=$EDITOR | set vixcmd=" %arg{@}
}

compl vifm file
