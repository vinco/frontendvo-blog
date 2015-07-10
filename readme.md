# vincoorbis' front-end blog

Front-end stuff by our team!

## TODO

* Multi-author support
  * Including the ability to list all post by a given author, with pagination
  * Also the ability to have each author have their own directory, e.g. `app/blogs/<author name>`
* Make it not look ugly
* Use a proper domain name other than github.io (this will also require changes to `_config.yml`)

## Requirements

* ruby (> 2.0)
* bundler (`gem install bundler`)
* node.js (> 0.10) or io.js (> 2.0)
* gulp (`npm install -g gulp`)

## Quick start

1. `$ bundle install`
2. `$ npm install`
3. `$ bower install`
4. `$ gulp serve` runs a webserver and opens your default browser
5. `$ gulp build` runs jekyll to build the site into `dest`
6. `$ gulp deploy` runs jekyll and deploys using [gulp-subtree](https://github.com/Snugug/gulp-subtree) straight into your `gh-pages` branch

## How to contribute

There are various ways to contribute, depending on the type of contribution. But in general the steps are:

1. Fork the repo
2. Make your changes in a new branch
3. [Squash your commits](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History#Squashing-Commits)
4. Submit a PR


Keep each PR focused on a specific type of contribution. For example, don't mix a post with a general code fix in a single PR. Instead, submit the post and the fix as two separate PRs.

## Your authorship

Make sure your own info is located in `app/_data/authors/<name>.yml`. You can pick any name, but this is what you will need to use in the front matter of your posts.

Take this example: ([app/_data/authors/jaromero.yml](app/_data/authors/jaromero.yml))

    name: 'Antonio Romero'
    email: 'ar@manoderecha.mx'
    url: 'http://pulsar.mx/'
    twitter: 'ja_romero'
    github: 'jaromero'
    avatar: 'https://avatars.githubusercontent.com/u/794031?v3'

Currently `name`, `url` and `avatar` are required, but only because that's what the templates use. Suggestions on how to display author info are welcome.

### Commit messages

Your commit summary should be prefixed with the following, depending on the type of contribution:

* **post** for blog posts
* **page** for pages
* **tool** for build process changes (e.g. changes to the gulpfile or the jekyll config)
* **style** for code style changes (e.g. formatting, alignment, etc.)
* **front** for general site changes like stylesheets and javascript

For example, your commit summary should look like this:

    post: Browserify vs. Webpack by @jaromero

or:

    tool: Make wiredep work on all html files

Add more details in the message body if necessary. [Try to follow this guideline, too](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).

## Types of contribution

In general, this instance of Jekyll follows [Github Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/), with some caveats:

1. Obviously, Github-specific extensions don't work (like auto-linking to issues and to users)
2. Jekyll is really greedy when parsing pages for Liquid template tags (e.g. `{{ }}` and `{% %}`). If your post contains these sequences of characters, wrap it in `{% raw %}` and `{% endraw %}`, or try escaping them with quotation marks like so: `{{" {{ "}}`

In addition, plain .html files are fine (in case you require a different html structure), but markdown files are still preferred.

### Posts

_([Jekyll documentation](http://jekyllrb.com/docs/posts/))_

Write your post in markdown format in the `app/_posts/` directory, with a name with the format `YYYY-MM-DD-whatever-name.md`.

Posts require [front matter](http://jekyllrb.com/docs/frontmatter/) at the very start. At minimum it should be:

    ---
    layout: post
    title:  "Welcome to Jekyll!"
    date:   2015-07-09 17:30:47
    tags:   tag1 tag2 tag3
    author: your_own_authors_yml_file
    ---

_(See above for authorship info)_

### Pages

_([Jekyll documentation](http://jekyllrb.com/docs/pages/))_

Pages live at the root of the website, that is, in `app/`. They also require front matter. However, for pages the only required fields are `layout` and `title`.

The `permalink` front matter setting determines where it will be located in the final build (for example, see [about.md](about.md)). This is not strictly required, but it's strongly encouraged.

## Other stuff

All of the following is things you should keep in mind if you want to hack at this thing more deeply.

### jekyll build

Two config files are required. Properties in `_config.serve.yml` override the ones in `_config.yml`, and they get used only for `gulp serve`

Both `gulp serve` and `gulp build` (and therefore `gulp deploy`) create two additional directories: `.staging` and `.tmp`. These are necessary for the following reasons:

* We want to control the preprocessing of scss and coffeescript, therefore we copy only html/md files into `.staging` so that jekyll only processes those
* wiredep doesn't work with the way jekyll expects script and stylesheet tags, so we also must process these and place them somewhere without modifying our working directory
* jekyll still needs to process the files so that it can create the right final structure, along with the right paths for links and etc.

### gulp

gulp should work just fine. It does most of the things that you're already used to:

* Install bower packages with `bower install`, which get inserted automatically into `app/_includes/*.html` with wiredep (or manually with `gulp wiredep`)
* Watch files, and reload your browser(s) with browsersync. CSS changes don't trigger a full reload; anything else does
* Compile SASS into CSS with sourcemaps, and compile coffeescript into javascript
* On build: optimize images, concat and uglify CSS and JS

### gulp.subtree

By default, [gulp-subtree](https://github.com/Snugug/gulp-subtree) pushes to the `gh-pages` branch of the `origin` remote (and will create the branch if needed), with the message 'Distribution Commit'. Passing an options object will allow you to override these defaults.

Do note that it will **delete the target branch completely** before pushing, and thus the branch will always contain one commit with the entire build. So don't use it to push to `master` or to any other branch you actually care about.
