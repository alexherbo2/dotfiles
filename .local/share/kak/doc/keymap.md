# Keymap

TODO: Document keyboard mappings.

Command | Description
--- | ---
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
`/` | search forward for `{pattern}`
`?` | search backward for `{pattern}`
`f` | search forward for `{char}`
`shift-f` | search backward for `{char}`
`t` | search forward ’til `{char}`
`shift-t` | search backward ’til `{char}`
`n` | select next search match
`shift-n` | select previous search match
`alt-;` | flip selection direction
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
`[ space` | add new line above selection
`[ c` | copy selection line up
`[ d` | copy selected lines up
`[` ... | ...
`]` | enter unimpaired right mode
`] ;` | move selection face forward
`] space` | add new line below selection
`] c` | copy selection line down
`] d` | copy selected lines down
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
`ctrl-enter` | `*grep*` select entries; use count for field selection
`ctrl-enter` | `*find*` select entries; use count for field selection
`ctrl-enter` | `*ls*` select entries; use count for field selection
`ctrl-enter` | `*git_status*` select entries; use count for field selection
`ctrl-enter` | `*git_blame*` select entries; use count for field selection
`ctrl-enter` | `*buffers*` select entries; use count for field selection
`ctrl-enter` | `*sessions*` select entries; use count for field selection
`ctrl-enter` | `*clients*` select entries; use count for field selection
`ctrl-enter` | `*themes*` select entries; use count for field selection
`ctrl-enter` | `*friendly_session_names*` select entries; use count for field selection
`ctrl-enter` | `*friendly_client_names*` select entries; use count for field selection
`alt-:` | `*buffers*` enter command mode with buffer context
`alt-:` | `*sessions*` enter command mode with session context
`alt-:` | `*clients*` enter command mode with client context
TODO | TODO
