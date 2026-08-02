decl str lsp_command kak-lsp
decl str-list lsp_args --kakoune --session %val{session}

decl -hidden str lsp_modeline_code_actions
decl -hidden str lsp_modeline_progress
decl -hidden str lsp_modeline_message_requests

decl str lsp_servers
decl str lsp_language_id
decl str lsp_semantic_tokens

def initialize_lsp %{
  eval %sh{
    eval "$kak_quoted_opt_lsp_command" "$kak_quoted_opt_lsp_args"
  }
  set global lsp_cmd %opt{lsp_command}
  lsp-enable
}
