---
layout: post
title:  "Nightwatch.js"
date:   2015-07-16 12:58:00
categories: testing nightwatch end-to-end
author: zesk8
---

Not long ago I started using [Nightwatch.js](http://nightwatchjs.org/) as a testing framework. Previously I had only tried [Casper.js](http://casperjs.org/)  but once I made my first test, I was convinced to use Nightwatch in my upcoming developments. But what is the difference between Nightwatch and Casper? Well, both provide a simple syntax as well as methods to make assertions and methods for performing commands (expect some element to be visible, click an item, etc.), both are well documented, but what makes the difference for me is that Casper makes use of [Phantom.js](http://phantomjs.org/) to run the test while Nightwatch makes use of [Selenium](http://www.seleniumhq.org/).

Selenium and Phantom.js both have the same purpose (automated browsers), but Selenium provides the advantage of running the test in real browsers, which is very useful when you want to test your application to have consistency between browsers and on different operating systems.

But, what exactly is Nightwatch.js?

*"Nightwatch is a framework written in Node.js for End-to-End testing. It uses Selenium WebDriver to run tests on the browser"*

Well, now we can do a little test to see how Nightwatch works, but before that we need to have installed java and Nightwatch through npm:

~~~sh
$ npm install nightwatch -g
~~~

The basic structure we need is:

~~~
├── bin/
|   └── selenium-server-standalone-{VERSION}.jar
├── tests/
|   └── test.js
└── nightwatch.json
~~~

Selenium jar can be downloaded at the following [URL](http://selenium-release.storage.googleapis.com/index.html), antes de escribir nuestro test de ejemplo hay que establecer la configuración de nuestro archivo nightwatch.json (muy sencilla por cierto):

~~~
{
  "src_folders" : ["tests"], // Test folder

  // Default configuration for Selenium
  "selenium" : {
    "start_process" : true,
    "start_session" : true,
    "server_path" : "bin/selenium-server-standalone-{VERSION}.jar",
    "host" : "127.0.0.1",
    "port" : 4444
  },

  // Default configuration for tests
  "test_settings" : {
    "default" : {
      "launch_url" : "http://localhost",
      "selenium_port"  : 4444,
      "selenium_host"  : "localhost",
      "silent": true,
      "screenshots" : {
        "enabled" : false,
        "path" : ""
      },
     // Browser configuration
      "desiredCapabilities": {
        "browserName": "firefox",
        "javascriptEnabled": true,
        "acceptSslCerts": true
      }
    }
  }
}
~~~

Well now that we have the settings, we can write our simple test that simply visits the Nightwatch page through google.

~~~js
module.exports  = {
  'Find nightwatch in google' : function (browser) {
    browser
      .url('https://www.google.com.mx/')
      .waitForElementVisible('body', 4000)
      .setValue('input[type=text]', 'nightwatchjs')
      .waitForElementVisible('button[name=btnG]', 4000)
      .click('button[name=btnG]')
      .pause(4000)
      .click('.srg .g:first-child h3 a')
      .waitForElementVisible('body', 4000)
      .assert.containsText('.jumbotron h1', 'Nightwatch')
      .end();
  }
};
~~~
As you can see in the code, there are two kinds of methods, one that belongs to the browser object (to perform commands, eg click, pause, etc) and others belonging to assert object (to make assertions) and each has a descriptive name according to their function.

In all methods, in order to locate the elements on the page, CSS selectors are used, but we are not limited to them, you can also use [XPath](http://doc.scrapy.org/en/0.12/topics/selectors.html) selectors.

All that remains is to run our test and see how Nightwatch works. For that, we go to the root of our project in our terminal and run:

~~~sh
$ nightwatch
~~~

As you can see, after running our test, it opened a new browser window indicated in our configuration file (firefox in our case). In addition, actions outlined in our test were executed, and the results sent to our terminal.

This was just a small example of how Nightwatch works but clearly not everything that can be done, the possibilities of this framework are many, such as creating our own methods of assertions, our own methods of commands, running our tests in parallel (in different browsers at the same time) and much more, but we'll see that in a future post, if you want to investigate further and review the list of methods of assertions and commands you can visit the [API](http://nightwatchjs.org/api) documentation Nightwatch.
