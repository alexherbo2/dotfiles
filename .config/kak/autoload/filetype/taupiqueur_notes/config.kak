hook global BufCreate '.*/notes.txt' %{
  set-option buffer filetype taupiqueur_notes
}

hook global BufSetOption filetype=taupiqueur_notes %{
  add-highlighter buffer/taupiqueur_notes ref taupiqueur_notes
}

add-highlighter shared/taupiqueur_notes regions
add-highlighter shared/taupiqueur_notes/text default-region group
add-highlighter shared/taupiqueur_notes/text/entry-date-year regex '^\d{4}' 0:comment
add-highlighter shared/taupiqueur_notes/text/entry-date-year-month regex '^\d{4}-\d{2}' 0:comment
add-highlighter shared/taupiqueur_notes/text/entry-date regex '^\d{4}-\d{2}-\d{2} \w{3}' 0:comment
add-highlighter shared/taupiqueur_notes/text/entry-date-time regex '^\d{4}-\d{2}-\d{2} \w{3} \d{2}:\d{2}' 0:comment
add-highlighter shared/taupiqueur_notes/text/keyword regex '\b(Buy|Go on|Go to|Read|Sign up|Update|Watch)\b' 0:keyword
add-highlighter shared/taupiqueur_notes/text/url regex 'https?://\S+' 0:link
add-highlighter shared/taupiqueur_notes/info region -recurse '\(' '\(' '\)' group
add-highlighter shared/taupiqueur_notes/info/content fill string
add-highlighter shared/taupiqueur_notes/info/url ref taupiqueur_notes/text/url
add-highlighter shared/taupiqueur_notes/info/delimiters regex '(?<opening>.).+(?<closing>.)' opening:string closing:string
add-highlighter shared/taupiqueur_notes/tag region -recurse '\[' '\[' '\]' fill meta
