---
layout: post
title:  "Quick start with Electron"
date:   2015-08-25 19:30:00
categories: Electron
---

## Starter aplication with electron

Electron is a framework to build cross platform applications using only web technologies(like JavaScript, CSS and HTML),
this framework has a little api with some options that help us in this purpose.

Electron is based a light version of Chromium web browser to parse web pages like desktop applications.

One feature that makes so interesting this framework is the cross platform suport, for the applications developed,
we can create application distributions for windows, OSX and linux.

For this example we'll to create an example application and distribution for OSX, just follow the next steps:

* To Install "electron"  execute one of the following commands in your terminal:

  ~~~sh
    # Install the `electron` command globally
    npm install electron-prebuilt -g

    # Install as a development dependency
    npm install electron-prebuilt --save-dev
  ~~~

* 2.- After install it you must create a dir for your application and create three necessary files:

  ~~~sh
    mkdir example_electron && $_ && touch package.json main.js index.html
  ~~~

* 3.- Well if all it's ok at this poit, we must put into package.json the following code:

  ~~~json
    {
      "name"    : "your-app",
      "version" : "0.1.0",
      "main"    : "main.js"
    }
  ~~~

  this contains the name of our aplication his version and the main file just like any node module.

* 4.- In out main.js we must be something like this:

  ~~~js
    var app = require('app');  // Module to control application life.
    var BrowserWindow = require('browser-window');  // Module to create native browser window.

    // Report crashes to our server.
    require('crash-reporter').start();

    // Keep a global reference of the window object, if you don't, the window will
    // be closed automatically when the JavaScript object is GCed.
    var mainWindow = null;

    // Quit when all windows are closed.
    app.on('window-all-closed', function() {
      // On OS X it is common for applications and their menu bar
      // to stay active until the user quits explicitly with Cmd + Q
      if (process.platform != 'darwin') {
        app.quit();
      }
    });

    // This method will be called when Electron has finished
    // initialization and is ready to create browser windows.
    app.on('ready', function() {
      // Create the browser window.
      mainWindow = new BrowserWindow({width: 800, height: 600});

      // and load the index.html of the app.
      mainWindow.loadUrl('file://' + __dirname + '/index.html');

      // Open the devtools.
      mainWindow.openDevTools();

      // Emitted when the window is closed.
      mainWindow.on('closed', function() {
        // Dereference the window object, usually you would store windows
        // in an array if your app supports multi windows, this is the time
        // when you should delete the corresponding element.
        mainWindow = null;
      });
    });
  ~~~

* 5.- Finally in the index.html put the following code:

  ~~~html
    <!DOCTYPE html>
    <html>
      <head>
        <title>Hello World!</title>
      </head>
      <body>
        <h1>Hello World!</h1>
        We are using io.js <script>document.write(process.version)</script>
        and Electron <script>document.write(process.versions['electron'])</script>.
      </body>
    </html>
  ~~~

* 6.- Now in terminal just type:

  ~~~sh
  electron .
  ~~~

Well now let's create the application distribution. We must Copy electron.app(from your computer location) to our /desktop and change the name to app_example.app(or wathever) and then:
* 1.- Open electron.app with right click and select show package content option
* 2.- Then find Contents/Resources/default_app
* 3.- Remove the content of this dir and put inside our application files

Now just open app_example.app and as you can see now it shows your application !

Also we can use an asar package for this porpuse, for this you must:
* 1.- Install asar:

~~~sh
npm install -g asar
~~~

* 2.- Create a package with your app like this:

~~~sh
asar pack /your/app/path app.asar
~~~

* 3.- Open electron.app with right click and select show content option
* 4.- remove the dir Contents/Resources/default_app
* 5.- Put your asar file inside of Contents/Resources

Now just open app_example.app and as you can see now it shows your application !
