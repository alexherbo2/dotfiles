# Keymap

TODO: Document keyboard mappings.

Command | Description
--- | ---
j | move cursor visual line down
k | move cursor visual line up
shift-j | extend cursor visual line down
shift-k | extend cursor visual line up
w | move selected text to next word start
e | move selected text to next word end
b | move selected text to previous word start
shift-w | extend selected text to next word start
shift-e | extend selected text to next word end
shift-b | extend selected text to previous word start
m | enter match mode
m m | select next matching brackets
m shift-m | select previous matching brackets
m i | select inner surrounding objects
m i w | select inner words
m i shift-w | select inner long words
m i ... | ...
m a | select whole surrounding objects
m shift-i | select inner nested objects
m shift-a | select whole nested objects
m s | enter surround mode
m s " | surround selected text with double quote string
m s ... | ...
g a | goto last accessed buffer
g w | enter jump mode (select mode: replace)
g shift-w | enter jump mode (select mode: extend)
g alt-w | enter jump mode (select mode: append)
v | enter extend mode
shift-n | select previous search match
? | search backward for regex pattern
shift-f | search backward for {char}
shift-t | search backward ’til {char}
shift-y | save selections in append mode
ctrl-n | iterate next selection
ctrl-p | iterate previous selection
ctrl-e | open file explorer
space e | open file explorer
~ | enter letter case mode
~ ... | ...
i | enter insert mode
i ctrl-k | enter digraphs mode
[ | enter unimpaired left mode
] | enter unimpaired right mode
{ | enter sticky unimpaired left mode
} | enter sticky unimpaired right mode
ctrl-w | enter window mode
ctrl-w ctrl-h | new horizontal split
ctrl-w ctrl-v | new vertical split
ctrl-w ... | ...
TODO | TODO
