# console.log 'Hello world!'

# Global authors variable
window.authors = {}

# Get author info from github, by using the page.author jekyll var
getGithubUserInfo = (username) ->
  ghURL = "https://api.github.com/users/#{username}"
  result = ''
  $.getJSON ghURL, (d, s) ->
    window.authors[username] = if s is 'success' then d else null

getAuthors = ->
  authors = []
  $('.post-author-link').each (i, e) ->
    authors.push $(@).data 'post-author'

  authors = _.uniq authors.sort()
  for author in authors
    getGithubUserInfo author

do ->
  # console.log getAuthors()
