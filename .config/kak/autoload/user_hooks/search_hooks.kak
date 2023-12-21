define-command add_search_user_hooks -params 1 %{
  hook %arg{1} NormalKey '/|<a-/>|\?|<a-\?>|s|S|<a-k>|<a-K>' %{
    trigger-user-hook "SearchBegin=%val{hook_param}"
    hook -once window ModeChange 'pop:prompt:normal' %exp{
      trigger-user-hook "SearchEnd=%val{hook_param}"
    }
  }
  hook %arg{1} NormalKey 'n|<a-n>|N|<a-N>' %{
    trigger-user-hook "SearchMatch=%val{hook_param}"
  }
  hook %arg{1} NormalKey '\*|<a-\*>' %{
    trigger-user-hook "SearchSelection=%val{hook_param}"
  }
}
