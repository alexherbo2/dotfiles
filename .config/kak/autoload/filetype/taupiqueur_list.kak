hook -group config global BufCreate '.*/list.txt' %{
  set-option buffer filetype list
}

hook -group config global BufSetOption filetype=list %{
  add-highlighter buffer/list ref list
}

add-highlighter shared/list regions
add-highlighter shared/list/text default-region group
add-highlighter shared/list/text/number regex '\b\d{2}\b' 0:value
add-highlighter shared/list/text/date regex '\b\d{4}-\d{2}-\d{2}\b' 0:string
add-highlighter shared/list/text/year regex '\b\d{4}\b' 0:string
add-highlighter shared/list/text/keyword regex '\b(Movie|Special)\b' 0:keyword
add-highlighter shared/list/text/url regex 'https?://\S+' 0:link
