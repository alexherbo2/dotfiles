def lf -params .. %{
  terminal env "kak_session=%val{session}" "kak_client=%val{client}" "VISUAL=sh %val{runtime}/assets/editor.sh" "EDITOR=sh %val{runtime}/assets/editor.sh" lf %val{buffile} %arg{@}
}

compl lf file
