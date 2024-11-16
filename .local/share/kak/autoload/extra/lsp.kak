declare-option str lsp_command kak-lsp
declare-option str-list lsp_args --kakoune --session %val{session}

declare-option -hidden str lsp_modeline_code_actions
declare-option -hidden str lsp_modeline_progress
declare-option -hidden str lsp_modeline_message_requests

define-command enter_lsp_mode %{
  enter-user-mode lsp
}

define-command initialize_lsp %{
  evaluate-commands %sh{
    eval "$kak_quoted_opt_lsp_command" "$kak_quoted_opt_lsp_args"
  }
  set-option global lsp_cmd %opt{lsp_command}
  lsp-enable
}
