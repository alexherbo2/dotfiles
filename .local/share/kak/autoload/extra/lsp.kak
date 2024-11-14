declare-option -hidden str lsp_modeline_code_actions
declare-option -hidden str lsp_modeline_progress
declare-option -hidden str lsp_modeline_message_requests

define-command initialize_lsp %{
  evaluate-commands %sh{
    kak-lsp --kakoune --session "$kak_session"
  }
  lsp-enable
}
