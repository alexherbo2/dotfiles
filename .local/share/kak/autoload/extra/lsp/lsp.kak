# kakoune-lsp
# https://github.com/kakoune-lsp/kakoune-lsp
# https://github.com/kakoune-lsp/kakoune-lsp/blob/master/kak-lsp.toml
# Helix
# https://helix-editor.com
# https://docs.helix-editor.com/languages.html
# https://github.com/helix-editor/helix/blob/master/languages.toml
# https://microsoft.github.io/language-server-protocol/implementors/servers/
# https://microsoft.github.io/language-server-protocol/specifications/specification-current/
# Reference
# https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocumentItem
# Reference
# https://microsoft.github.io/language-server-protocol/implementors/servers/
# Reference
# https://microsoft.github.io/language-server-protocol/specification#textDocument_semanticTokens
decl str lsp_command kak-lsp
decl str-list lsp_args --kakoune --session %val{session}

decl -hidden str lsp_modeline_code_actions
decl -hidden str lsp_modeline_progress
decl -hidden str lsp_modeline_message_requests

decl bool lsp_debug false
decl int lsp_timeout 1800

decl bool lsp_snippet_support false

decl str lsp_servers
decl str lsp_language_id
decl str lsp_semantic_tokens %{
  [
    { face = 'documentation', token = 'comment', modifiers = ['documentation'] },
    { face = 'comment', token = 'comment' },
    { face = 'function', token = 'function' },
    { face = 'keyword', token = 'keyword' },
    { face = 'module', token = 'namespace' },
    { face = 'operator', token = 'operator' },
    { face = 'string', token = 'string' },
    { face = 'type', token = 'type' },
    { face = 'default+d', token = 'variable', modifiers = ['readonly'] },
    { face = 'default+d', token = 'variable', modifiers = ['constant'] },
    { face = 'variable', token = 'variable' }
  ]
}

def initialize_lsp %{
  eval %sh{
    eval "$kak_quoted_opt_lsp_command" "$kak_quoted_opt_lsp_args"
  }
  set global lsp_cmd %opt{lsp_command}
  remove-hooks "lsp-filetype-.+|lsp-language-id"
  source "%val{runtime}/assets/lsp/lsp.kak"
  lsp-enable
}
