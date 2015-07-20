---
layout: post
title:  "Managing node.js and io.js with nvm"
date:   2015-07-20 12:00:00
categories: node nvm
author: jaromero
---
We use [node.js](https://nodejs.org) a lot (and [io.js](https://iojs.org) to a lesser degree) when doing development, powering a good portion of our toolkit like our [grunt](http://gruntjs.com) and [gulp](http://gulpjs.com) workflows, as well as running node.js itself as a server.

Because of the fast pace of development in these two projects, sometimes we also find ourselves having to juggle various node.js/io.js versions by installing or uninstalling quite a few times, or even resorting to virtualization tools like [vagrant](http://vagrantup.com) or [docker](https://docker.io) to lock a project down to a given node.js/io.js version.

[nvm](https://github.com/creationix/nvm) is a different solution. It's simply a helper bash script (for POSIX systems) that installs node.js/io.js into its own directory, as a subdirectory of nvm's install dir:

~~~sh
$ nvm install v0.12.7
# ...
$ which node
/home/nsdragon/Development/nvm/versions/node/v0.12.7/bin/node
# nvm is installed to /home/nsdragon/Development/nvm
~~~

This also allows us to run `npm install -g` without the need for superuser privileges:

~~~sh
$ npm install -g coffee-script
/home/nsdragon/Development/nvm/versions/node/v0.12.7/bin/coffee -> /home/nsdragon/Development/nvm/versions/node/v0.12.7/lib/node_modules/coffee-script/bin/coffee
/home/nsdragon/Development/nvm/versions/node/v0.12.7/bin/cake -> /home/nsdragon/Development/nvm/versions/node/v0.12.7/lib/node_modules/coffee-script/bin/cake
coffee-script@1.9.3 /home/nsdragon/Development/nvm/versions/node/v0.12.7/lib/node_modules/coffee-script
$ which coffee
/home/nsdragon/Development/nvm/versions/node/v0.12.7/bin/coffee
~~~

## Managing versions

Aside from the obvious convenience that this provides, nvm is also able to manage, install and switch between versions:

~~~sh
$ nvm install iojs-v2.4.0  # Install io.js v2.4.0
# ...

$ nvm ls                   # Shows versions installed
    iojs-v2.4.0
->      v0.12.7
default -> v0.12.7
node -> stable (-> v0.12.7) (default)
stable -> 0.12 (-> v0.12.7) (default)
iojs -> iojs-v2.4 (-> iojs-v2.4.0) (default)

$ nvm ls-remote            # Shows all versions available for install
# ...

$ nvm use iojs-v2.4.0      # Now use what we just installed
Now using io.js v2.4.0 (npm v2.13.0)

$ node -v
v2.4.0

$ which node
/home/nsdragon/Development/nvm/versions/io.js/v2.4.0/bin/node

$ nvm use v0.12.7          # Go back to using node.js v0.12.7
Now using node v0.12.7 (npm v2.11.3)

$ echo 'iojs-v2.4.0' > .nvmrc
$ nvm use                  # Reads the first .nvmrc file it finds
Now using io.js v2.4.0 (npm v2.13.0)

$ nvm alias default iojs-v2.4.0
$ nvm use default          # Set iojs-v2.4.0 as default when opening new shells
Now using io.js v2.4.0 (npm v2.13.0)
$ nvm ls                   # Shows that iojs-v2.4.0 is now default
->  iojs-v2.4.0
        v0.12.7
default -> iojs-v2.4.0
node -> stable (-> v0.12.7) (default)
stable -> 0.12 (-> v0.12.7) (default)
iojs -> iojs-v2.4 (-> iojs-v2.4.0) (default)
~~~

Even upgrading and migrating global node modules is straightforward:

~~~sh
$ nvm use iojs-v2.4.0
Now using io.js v2.4.0 (npm v2.13.0)
$ nvm reinstall-packages v0.12.7  # Install whatever packages v0.12.7 has
~~~

All this lets us quickly and easily manage whatever node.js/io.js version our project requires, as well as upgrade easily whenever needed.
