hook -group config global BufCreate '.*/list.txt' %{
  set-option buffer filetype taupiqueur_list
}

hook -group config global BufSetOption filetype=taupiqueur_list %{
  add-highlighter buffer/taupiqueur_list ref taupiqueur_list
}

add-highlighter shared/taupiqueur_list regions
add-highlighter shared/taupiqueur_list/text default-region group
add-highlighter shared/taupiqueur_list/text/number regex '\b\d{2}\b' 0:value
add-highlighter shared/taupiqueur_list/text/date regex '\b\d{4}-\d{2}-\d{2}\b' 0:string
add-highlighter shared/taupiqueur_list/text/year regex '\b\d{4}\b' 0:string
add-highlighter shared/taupiqueur_list/text/keyword regex '\b(Movie|Special)\b' 0:keyword
add-highlighter shared/taupiqueur_list/text/url regex 'https?://\S+' 0:link
