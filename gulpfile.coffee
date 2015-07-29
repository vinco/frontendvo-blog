# Gulpfile

gulp        = require 'gulp'
browserSync = require 'browser-sync'
$           = require('gulp-load-plugins')()
wiredep     = require('wiredep').stream
shell       = require 'shelljs'
runSequence = require 'run-sequence'
del         = require 'del'

reload = browserSync.reload

userefOpts =
  jekylljs: (content, target) ->
    "<script src='{{ '/#{target}' | prepend: site.baseurl }}'></script>"
  jekyllcss: (content, target) ->
    "<link rel='stylesheet' href='{{ '/#{target}' |
        prepend: site.baseurl }}'>"

gulp.task 'styles', ->
  # Build scss styles into the staging and tmp directories
  gulp.src 'app/styles/**/*.scss'
    .pipe $.plumber()
    .pipe $.sourcemaps.init()
    .pipe $.sass.sync
      outputStyle: 'expanded'
      precision: 10
      includePaths: ['.']
    .on 'error', $.sass.logError
    .pipe $.autoprefixer browsers: ['last 2 versions']
    .pipe $.sourcemaps.write()
    .pipe gulp.dest '.staging/styles'
    .pipe gulp.dest '.tmp/styles'
    .pipe reload stream: true

gulp.task 'scripts', ->
  # Build coffeescript files into staging and tmp
  gulp.src 'app/scripts/**/*.{coffee,litcoffee}'
    .pipe $.coffee()
    .on 'error', (err) -> console.log 'Error!', err.message
    .pipe gulp.dest '.staging/scripts'
    .pipe gulp.dest '.tmp/scripts'

gulp.task 'jekyll', ['moveAssets'], ->
  # Build the jekyll site for deployment
  # Uses _config.yml only
  # Run after useref to make sure all the files are prepared correctly
  shell.exec 'bundle exec jekyll build'

gulp.task 'jekyll:tmp', ['moveFiles'], ->
  # Build the jekyll site for serving with livereload
  # Uses both _config.yml and _config.serve.yml
  shell.exec 'bundle exec jekyll build --config \
        _config.yml,_config.serve.yml'

# These two tasks are to be able to force a reload
gulp.task 'reloadAfterBuild', ['jekyll:tmp'], reload
gulp.task 'reloadAfterScripts', ['scripts'], reload

gulp.task 'moveFiles', ['scripts', 'styles'], ->
  # Moves files to the staging directory to prepare for thejekyll build tasks
  # We're doing this to avoid modifying the files in our working directory,
  # and also because of how jekyll works re: building files and basedir
  files = [
    'app/.no-jekyll'
    'app/*.md'
    'app/*.xml'
    'app/*.html'
    'app/_data/**/*'
    'app/_layouts/**/*'
    'app/_posts/**/*'
    'app/_includes/**/*'
    'app/p/**/*' # Pagination template
    # 'app/images/**/*'
    'app/fonts/**/*'
  ]

  gulp.src files, base: './app/'
    .pipe gulp.dest '.staging'

gulp.task 'moveAssets', ['useref'], ->
  # Move compiled, useref'd CSS and JS files to where they belong
  gulp.src '.staging/_includes/scripts/**/*.js'
    .pipe $.rename dirname: 'scripts'
    .pipe gulp.dest '.staging'

  gulp.src '.staging/_includes/styles/**/*.css'
    .pipe $.rename dirname: 'styles'
    .pipe gulp.dest '.staging'

gulp.task 'useref', ['moveFiles'], ->
  # Do the useref on files in the staging directory
  assets = $.useref.assets
    searchPath: ['.', '.staging']

  gulp.src '.staging/_includes/*.html'
    .pipe assets
    .pipe $.if '*.js', $.uglify()
    .pipe $.if '*.css', $.minifyCss compatibility: '*'
    .pipe assets.restore()
    .pipe $.replace /build:(.*?)\ /g, 'build:jekyll$1 '
    .pipe $.useref userefOpts
    .pipe gulp.dest '.staging/_includes'

gulp.task 'images', ->
  # Optimize images
  gulp.src 'app/images/**/*'
    .pipe $.if $.if.isFile, $.cache $.imagemin
      progressive: true
      interlaced: true
      svgoPlugins: [{cleanupIDs: false}]
    .on 'error', (err) ->
      console.log err
      this.end()
    .pipe gulp.dest 'dist/images'

gulp.task 'fonts', ->
  # Copy font files obtained with bower
  bowerFiles = require 'main-bower-files'

  gulp.src bowerFiles({filter: '**/*.{eot,svg,ttf,woff,woff2}'
  }).concat 'app/fonts/**/*'
    .pipe gulp.dest '.tmp/fonts'
    .pipe gulp.dest 'dist/fonts'

gulp.task 'extras', ->
  # Copy all files not handled by jekyll or other gulp tasks
  gulp.src [
    'app/*.*'
    '!app/*.{html,md}'
  ],
    dot: true
  .pipe gulp.dest 'dist'

gulp.task 'clean', ->
  # Clean staging, tmp and _site dirs
  # Only really necessary for build
  del [
    '.staging'
    '.tmp'
    'dist/**/*'
    'dist/.*'
  ]

gulp.task 'cleanStray', ->
  # Removes stray files from staging after useref is done with them
  del [
    '.staging/_includes/scripts'
    '.staging/_includes/styles'
  ]

# Basic entry point
gulp.task 'build', ['clean'], ->
  # Clean first, then the rest
  runSequence ['jekyll', 'fonts', 'extras'],
    'images',
    ['cleanStray', 'size']

gulp.task 'size', ->
  # Size up the whole thing
  gulp.src 'dist/**/*'
    .pipe $.size {title: 'build', gzip: true}

gulp.task 'serve', ['clean'], ->
  # Clean first, then the rest
  runSequence ['jekyll:tmp', 'fonts'], 'browsersync'

gulp.task 'browsersync', ->
  # Run the web server
  browserSync
    notify: false
    port: 9000
    server:
      baseDir: ['.tmp', 'app']
      routes:
        '/bower_components': 'bower_components'

  # Trigger a full rebuild when these change
  gulp.watch [
    'app/*.md'
    'app/*.html'
    'app/_data/**/*'
    'app/_includes/**/*'
    'app/_layouts/**/*'
    'app/_posts/**/*'
    'app/p/**/*'
    '_config.yml'
    '_config.serve.yml'
  ]
  , ['reloadAfterBuild']

  # Trigger just a browser reload
  gulp.watch [
    'app/images/**/*',
    '.tmp/fonts/**/*'
  ]
  .on 'change', reload

  # Path-specific tasks
  gulp.watch 'app/scripts/**/*.{coffee,litcoffee}', ['reloadAfterScripts']
  gulp.watch 'app/styles/**/*.scss', ['styles']
  gulp.watch 'app/fonts/**/*', ['fonts']
  gulp.watch 'bower.json', ['wiredep', 'fonts']

gulp.task 'wiredep', ->
  # Insert bower dependencies into files
  gulp.src 'app/_sass/*.scss'
    .pipe $.debug()
    .pipe wiredep
      ignorePath: /^(\.\.\/)+/
    .pipe gulp.dest 'app/_sass'

  gulp.src 'app/_includes/*.html'
    .pipe $.debug()
    .pipe wiredep
      ignorePath: /^(\.\.\/)*\.\./
    .pipe gulp.dest 'app/_includes'

gulp.task 'deploy', ['build'], ->
  # Deploy to Github Pages
  gulp.src 'dist'
    .pipe $.subtree()

  del ['dist']

# Default task
gulp.task 'default', ['build']
