# Keymap

TODO: Document keyboard mappings.

Command | Description
--- | ---
`'` | execute next key as alt key
`j` | move cursor visual line down
`k` | move cursor visual line up
`shift-j` | extend cursor visual line down
`shift-k` | extend cursor visual line up
`w` | move selected text to next word start
`e` | move selected text to next word end
`b` | move selected text to previous word start
`shift-w` | extend selected text to next word start
`shift-e` | extend selected text to next word end
`shift-b` | extend selected text to previous word start
`shift-c` | copy selection line down
`shift-d` | copy selected lines down
`alt-shift-d` | move selected lines down
`x` | select whole lines or extend line down
`shift-x` | select whole lines
`/` | search forward for `{pattern}`
`?` | search backward for `{pattern}`
`f` | search forward for `{char}`
`shift-f` | search backward for `{char}`
`t` | search forward ’til `{char}`
`shift-t` | search backward ’til `{char}`
`n` | select next search match
`shift-n` | select previous search match
`alt-;` | flip selection direction
`,` | keep primary selection
`alt-,` | remove primary selection
`;` | collapse selections
`escape` | keep primary selection and collapse selections
`m` | enter match mode
`m m` | select next matching brackets
`m shift-m` | select previous matching brackets
`m i` | select inner surrounding objects
`m i w` | select inner words
`m i shift-w` | select inner long words
`m i` ... | ...
`m a` | select whole surrounding objects
`m shift-i` | select inner nested objects
`m shift-a` | select whole nested objects
`m s` | enter surround mode
`m s "` | surround selected text with double quote string
`m s` ... | ...
`g` | enter goto mode
`g j` | move cursor line down
`g k` | move cursor line up
`g shift-j` | extend cursor line down
`g shift-k` | extend cursor line up
`g a` | goto last accessed buffer
`g w` | enter jump mode (select mode: replace)
`g shift-w` | enter jump mode (select mode: extend)
`g alt-w` | enter jump mode (select mode: append)
`v` | enter extend mode
`v n` | add next search match
`v` ... | ...
`shift-y` | save selections in append mode
`ctrl-n` | iterate next selection
`ctrl-p` | iterate previous selection
`ctrl-e` | open file explorer
`space e` | open file explorer
`space f` | open file picker
`alt-space` | open text finder
`~` | enter letter case mode
`~` ... | ...
`i` | enter insert mode
`i ctrl-k` | enter digraphs mode
`[` | enter unimpaired left mode
`[ ;` | move selection face backward
`[ space` | add new line above selected text
`[ c` | copy selection line up
`[ d` | copy selected lines up
`[ shift-d` | move selected lines up
`[` ... | ...
`]` | enter unimpaired right mode
`] ;` | move selection face forward
`] space` | add new line below selected text
`] c` | copy selection line down
`] d` | copy selected lines down
`] shift-d` | move selected lines down
`]` ... | ...
`{` | enter sticky unimpaired left mode
`}` | enter sticky unimpaired right mode
`ctrl-w` | enter window mode
`ctrl-w ctrl-h` | new horizontal split
`ctrl-w ctrl-v` | new vertical split
`ctrl-w` ... | ...
`enter` | `*grep*` jump to references
`enter` | `*find*` jump to files
`enter` | `*ls*` jump to files or directories
`enter` | `*git_status*` jump to files
`enter` | `*git_blame*` show patches
`enter` | `*buffers*` jump to buffers
`enter` | `*themes*` load theme
`enter` | `*friendly_session_names*` rename session
`enter` | `*friendly_client_names*` rename client
`alt-0` | `*grep*` select whole entries; use `alt-1` through `alt-9` for field selection
`alt-1` | `*grep*` select first field of entries
`alt-2` | `*grep*` select second field of entries
`alt-3` | `*grep*` select third field of entries
`alt-0` | `*find*` select whole entries; use `alt-1` through `alt-9` for field selection
`alt-1` | `*find*` select first field of entries
`alt-0` | `*ls*` select whole entries; use `alt-1` through `alt-9` for field selection
`alt-1` | `*ls*` select first field of entries
`alt-0` | `*git_status*` select whole entries; use `alt-1` through `alt-9` for field selection
`alt-1` | `*git_status*` select first field of entries
`alt-2` | `*git_status*` select second field of entries
`alt-0` | `*git_blame*` select whole entries; use `alt-1` through `alt-9` for field selection
`alt-1` | `*git_blame*` select first field of entries
`alt-2` | `*git_blame*` select second field of entries
`alt-3` | `*git_blame*` select third field of entries
`alt-4` | `*git_blame*` select fourth field of entries
`alt-0` | `*buffers*` select whole entries; use `alt-1` through `alt-9` for field selection
`alt-1` | `*buffers*` select first field of entries
`alt-2` | `*buffers*` select second field of entries
`alt-0` | `*sessions*` select whole entries; use `alt-1` through `alt-9` for field selection
`alt-1` | `*sessions*` select first field of entries
`alt-0` | `*clients*` select whole entries; use `alt-1` through `alt-9` for field selection
`alt-1` | `*clients*` select first field of entries
`alt-0` | `*themes*` select whole entries; use `alt-1` through `alt-9` for field selection
`alt-1` | `*themes*` select first field of entries
`alt-0` | `*friendly_session_names*` select whole entries; use `alt-1` through `alt-9` for field selection
`alt-1` | `*friendly_session_names*` select first field of entries
`alt-0` | `*friendly_client_names*` select whole entries; use `alt-1` through `alt-9` for field selection
`alt-1` | `*friendly_client_names*` select first field of entries
`alt-:` | `*buffers*` enter command mode with buffer context
`alt-:` | `*sessions*` enter command mode with session context
`alt-:` | `*clients*` enter command mode with client context
`alt-:` | `*ls*` enter command mode with ls context
`alt-:` | `*find*` enter command mode with find context
TODO | TODO
