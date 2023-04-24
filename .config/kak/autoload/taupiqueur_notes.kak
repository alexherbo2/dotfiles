hook global BufCreate '.*/notes.txt' %{
  set-option buffer filetype notes
}

hook global BufSetOption filetype=notes %{
  add-highlighter buffer/notes ref notes
}

add-highlighter shared/notes regions
add-highlighter shared/notes/text default-region group
add-highlighter shared/notes/text/entry-date-year regex '^\d{4}' 0:comment
add-highlighter shared/notes/text/entry-date-year-month regex '^\d{4}-\d{2}' 0:comment
add-highlighter shared/notes/text/entry-date regex '^\d{4}-\d{2}-\d{2} \w{3}' 0:comment
add-highlighter shared/notes/text/entry-date-time regex '^\d{4}-\d{2}-\d{2} \w{3} \d{2}:\d{2}' 0:comment
add-highlighter shared/notes/text/keyword regex '\b(Buy|Go on|Go to|Read|Sign up|Update|Watch)\b' 0:keyword
add-highlighter shared/notes/text/url regex 'https?://\S+' 0:link
add-highlighter shared/notes/info region -recurse '\(' '\(' '\)' group
add-highlighter shared/notes/info/content fill string
add-highlighter shared/notes/info/url ref notes/text/url
add-highlighter shared/notes/info/delimiters regex '(?<opening>.).+(?<closing>.)' opening:string closing:string
add-highlighter shared/notes/tag region -recurse '\[' '\[' '\]' fill meta
