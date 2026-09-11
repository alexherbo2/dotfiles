def nnn -params .. %{
  terminal env "kak_session=%val{session}" "kak_client=%val{client}" "VISUAL=sh %val{runtime}/assets/editor.sh" "EDITOR=sh %val{runtime}/assets/editor.sh" nnn %arg{@}
}

compl nnn file
