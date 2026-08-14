set global lsp_debug false
set global lsp_timeout 1800

set global lsp_snippet_support false

set global lsp_servers ""
set global lsp_language_id ""
set global lsp_semantic_tokens %{
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
