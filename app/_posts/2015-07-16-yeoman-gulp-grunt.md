---
layout: post
title:  "Front-end App Scaffolding with Yeoman, Grunt and Gulp"
date:   2015-07-16 12:00:00
categories: yeoman front-end javascript node
---
**[Yeoman](http://yeoman.io)** is a node-based tool for scaffolding new apps, whether they are simple web apps or complete full-stack solutions using pretty much any technology available. It works along with _generators_, which are responsible for most of the scaffolding itself, as well as providing some degree of customization.

Installing yeoman can be done like the following. Most generators also make use of [bower](http://bower.io), along with either [grunt](http://gruntjs.com) or [gulp](http://gulpjs.com), so we might as well do it all at once:

~~~sh
$ npm install -g yo grunt gulp
~~~

## Generators

A **generator** is what does most of the work in scaffolding a project. Generators are responsible for setting up the directory structure, preparing the files, customizing the app based on user prompts, and even setting up external or additional tools to work with the generated code.

Generators can be found on [yeoman's](http://yeoman.io/generators) website, or just by searching the npm registry for `yeoman generator`. They can be installed either globally or locally if you prefer to keep dependencies contained.

After installing a generator, it's used with the `yo` command:

~~~sh
$ npm install -g generator-<name>
# ...
$ yo <name>
~~~

Some generators also have _subtasks_ for creating new components, routes, or other framework-related tasks, like in [generator-angular](https://github.com/yeoman/generator-angular) (`yo angular:controller`, `yo angular:directive`, etc.) or [generator-polymer](https://github.com/yeoman/generator-polymer) (`yo polymer:element`, `yo polymer:seed`)

Yeoman even provides its own [generator-generator](https://github.com/yeoman/generator-generator), which scaffolds an actual yeoman generator if you can't find one that satisfies your needs.

## A quick example

Let's say we want a quick and simple webapp. The basic generators by the yeoman team are [generator-webapp](https://github.com/yeoman/generator-webapp) (which uses grunt) and [generator-gulp-webapp](https://github.com/yeoman/generator-gulp-webapp) (which uses gulp). We can install them both:

~~~sh
$ npm install -g generator-webapp generator-gulp-webapp
~~~

And then set up a new webapp:

~~~sh
$ mkdir -p ~/Dev/my-webapp && cd $_
$ yo webapp # or gulp-webapp for the gulp version
~~~

This presents us with a prompt that allows us to select whether to use sass (instead of plain css), bootstrap, and modernizr (other generators may present you with different choices, or none at all):

![yeoman prompt](/images/Screenshot 2015-07-13 18.30.31.png)

After choosing options, yeoman will go ahead and install everything it needs (as specified by the generator). Since this generator uses grunt and grunt plugins, as well as bower to manage browser packages, it will also do `npm install` and `bower install`.

When all's said and done, the final directory structure will be similar to this:

![all the files](/images/Screenshot 2015-07-13 18.42.40.png)

And you can start working on the `app` directory and run `grunt serve` or anything else you need.


## Grunt and Gulp

**[Grunt](http://gruntjs.com)** and **[Gulp](http://gulpjs.com)** are node-based task runners that work with a [plethora](http://gruntjs.com/plugins) of [plugins](http://gulpjs.com/plugins/), and are very commonly used as part of yeoman generators, although they can also be used on their own. The tasks that are available depend on the generator used, but common tasks include:

* Creating a light-weight, temporary web server to preview the webapp (and open your browser automatically), and reload browsers when changes are made
* Watching project files to trigger other tasks on save (compile coffeescript/sass files or linting javascript files, for example)
* Building a project to generate an optimized er... build, with concatenated/minified javascript, CSS and HTML, suitable for serving directly
* Run test suites on your app, using test frameworks such as mocha or jasmine

Tasks are available via the terminal:

~~~sh
$ grunt # same as grunt default
$ grunt serve
$ grunt build
$ grunt test
~~~

or, for gulp:

~~~sh
$ gulp # same as gulp default
$ gulp serve
$ gulp build
$ gulp test
~~~

In addition, both have the ability to use CoffeeScript for its configuration file (for gulp, since v3.9.0). All that is needed (aside from the actual gruntfile.coffee or gulpfile.coffee) is that you install the interpreter:

~~~sh
$ npm install coffee-script
~~~

## Differences between grunt and gulp

The main difference between grunt and gulp is the configuration file: `gruntfile.js` and `gulpfile.js`. In general, grunt is very configuration-heavy, while gulp is more declarative. I'll explain what this means in the next couple of sections, but suffice to say the choice of either grunt or gulp is mostly personal and depends largely on what one feels more comfortable working with.

### Grunt

**Grunt** configures its tasks as an array of plugins to call and work on files, one plugin at a time. Plugins can be configured with a 'global' set of options, and also a specific set of options depending on the _target_ specified when running grunt (or any specific task). This can be used, for example, to compile sass in expanded mode and with sourcemaps when developing, but in compressed mode without sourcemaps when doing a build.

~~~js
// grunt.initConfig
clean: { // No default options for this one
  dist: { // options for the dist target, e.g. grunt build calls clean:dist
    files: [{
      dot: true,
      src: [
        '.tmp',
        '<%= config.dist %>/*',
        '!<%= config.dist %>/.git*'
      ]
    }]
  },
  server: '.tmp' // server target; grunt serve calls clean:server
}
~~~

Grunt tasks are all run sequentially; that is, they run in the order in which they exist in the gruntfile, and only one at a time. This allows each task to finish completely before the next task is over. The downside of this is that for tasks that don't depend on other tasks, this approach is slower, but it can be mitigated with plugins like [grunt-concurrent](https://github.com/sindresorhus/grunt-concurrent).

### Gulp

**Gulp**'s main advantage is that it's much more declarative, and therefore more terse. It can be used to configure arbitrary tasks:

~~~js
var gulp = require('gulp');
var sass = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');

gulp.task('copyFiles', ['sass'], function (){
  gulp.src([
    'source/**/*',
    '!source/sass/**/*'
  ], {dot: true})
    .pipe(gulp.dest('target'));
});

gulp.task('sass', function (){
  gulp.src('source/sass/**/*.scss')
    .pipe(sass.sync({
      outputStyle: 'expanded',
      precision: 10,
      includePaths: ['sass-includes']
    }))
    .pipe(autoprefixer({browsers: ['last 2 versions']}))
    .pipe(gulp.dest('target/styles'));
});

gulp.task('default', ['copyFiles']);
~~~

Gulp works with files in _streams_, which means that it can read them (via `gulp.src`) and the contents piped through other gulp plugins, in a very similar way to how pipes work in unix systems, with the stream being written only after explicitely written (with `gulp.dest`). Configuration for each plugin is also done at that point (as you can see for the sass plugin).

Unlike grunt, gulp tasks can have explicit dependent tasks, and one task may depend on multiple other tasks, to be run after these dependencies are finished. In this case, gulp runs all the tasks concurrently, so tasks such as compilation and image optimization can run simultaneously.

However, gulp can't (yet) run tasks in an arbitrary order like grunt does, without having potentially complicated chains of dependencies. This too can also be solved with the [run-sequence](https://github.com/OverZealous/run-sequence) plugin.

On top of everything, gulp is able (thanks to [js-interpret](https://github.com/tkellen/js-interpret)) to read its configuration in any of the supported languages specified [here](https://github.com/tkellen/js-interpret/blob/master/index.js), provided the relevant interpreter is installed. For example, the package `babel-core` will allow gulp to read from a `gulpfile.babel.js` file with ES6 syntax.
