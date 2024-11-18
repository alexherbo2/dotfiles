hook global BufOpenFile '.*' %{
  echo -markup "{Information}""%val{bufname}"" %val{buf_line_count}L"
}

hook global BufWritePost '.*' %{
  echo -markup "{Information}""%val{bufname}"" %val{buf_line_count}L written"
}
