add-highlighter shared/git_status group
add-highlighter shared/git_status/ regex '^([ ACDMRTU])([ ACDMRTU])' 1:added 2:deleted
add-highlighter shared/git_status/ regex '^\?\?|!!' 0:deleted
