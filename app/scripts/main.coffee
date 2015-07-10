# console.log 'Hello world!'

# Get author info from github, by using the page.author jekyll var
do ->
  $postAuthor = $ '.post .post-author-link'
  if $postAuthor.length > 0
    $postAuthorAvatar = $ '.post .post-author-avatar'
    $postAuthorName = $ '.post .post-author-name'

    postAuthor = $postAuthor.data 'post-author'
    ghURL = "https://api.github.com/users/#{postAuthor}"

    $.getJSON ghURL, (d, s) ->
      return false if s isnt 'success'
      $postAuthor.attr 'href', d.html_url
      $postAuthorAvatar.attr 'src', d.avatar_url
      $postAuthorName.text d.name
