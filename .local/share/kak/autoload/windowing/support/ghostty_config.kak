# Ghostty
hook global User 'TERM_PROGRAM=ghostty' %{
  trigger-user-hook "GHOSTTY_PLATFORM=%opt{platform_name}"
}
