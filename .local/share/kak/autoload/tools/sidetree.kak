def sidetree -params .. %{
  terminal env "kak_session=%val{session}" "kak_client=%val{client}" "VISUAL=sh %val{runtime}/assets/editor.sh" "EDITOR=sh %val{runtime}/assets/editor.sh" sidetree -e "set open_cmd ""$EDITOR \""$sidetree_entry\""""" -s %val{buffile} %arg{@}
}

compl sidetree file
