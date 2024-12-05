hook -always global ModeChange '\Qpush:normal:next-key[user.extend]\E' %{
  set-option window autoinfo ''
  hook -always -once window ModeChange '\Qpop:next-key[user.extend]:normal\E' %{
    unset-option window autoinfo
  }
}
