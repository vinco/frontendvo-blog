---
layout: post
title:  "Unit testing with Mocha"
date:   2015-11-07 23:00:00
categories: coffescript javascript front-end mocha unit testing chai phantomjs
author: zesk8
---

Currently testing has become an essential part of every development, it helps us to detect errors in an automatized way, we only need to write our suite test and every time we want to test our application we only run a simple command, There are different types of testing, such as:

+ End-to-End testing
+ Integration testing
+ Functional testing
+ Unit testing

But in this post we'll focus on unit testing which are in charge of testing our code as a unit that we define, in this case a unit will be a javascript function.

In this post we'll learn how to write tests with Mocha and use Phantom.js to run our tests.

First of all we need to install our dependencies:

Phantom.js:

The easiest way to install phantom (in OS X) is through [Homebrew](http://brew.sh/):

~~~~
$ brew install phantomjs
~~~~

If you are using a different OS, you can install the [binary](http://phantomjs.org/download.html)

mocha-phantomjs:

We'll use this module to run our mocha tests through phantom, we install it through npm:

~~~~
$ npm install -g mocha-phantomjs
~~~~

Our project structure will be like this:

~~~~
├── tests/
|   └── test.js
├── index.html
└── package.json
~~~~

In our package.json we define mocha and chai:

~~~js
{
  "name": "mocha",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "devDependencies": {
    "mocha": "*",
  "chai" : "*"
  },
  "author": "",
  "license": "ISC"
}
~~~

Our index.html will have the configuration for mocha:

~~~html
<html>
    <head>
        <title> Tests </title>
        <link rel="stylesheet" href="./node_modules/mocha/mocha.css" />
    </head>
    <body>
        <div id="mocha"></div>
        <script src="./node_modules/mocha/mocha.js"></script>
        <script src="./node_modules/chai/chai.js"></script>
        <!-- Inital configuration for mocha -->
        <script>
            mocha.ui('bdd');
            mocha.reporter('html');
            var expect = chai.expect;
        </script>
        <!-- Our test -->
        <script src="test/test.js"></script>
        <!-- Run mocha through phantom or in browser-->
        <script>
            if (window.mochaPhantomJS) { mochaPhantomJS.run(); }
            else { mocha.run(); }
        </script>
    </body>
</html>
~~~

Our script file:

~~~js
(function() {
  window.Person = function(name) {
    this.name = name;
  };

  Person.prototype = {
    saySomething : function(word) {
      return this.name + " wants to say: " + word;
    }
  };
})();
~~~

Our script is a simple self invoked function with a main function and a prototype function which return a string with the values passed to both functions, our main function (and its prototype function) will be our unit to test.

And our test will look like this:

~~~js
describe("Person", function() {
  describe("constructor", function() {
    // Test if our function person has a default value for variable name, this test will fail
    it("should have a default name", function() {
      var person = new Person();
      expect(person.name).to.equal('Jimi');
    });
  // Test if the initial value is the same after call the variable directly
    it("should set person's name", function() {
      var person = new Person("Daniel");
      expect(person.name).to.equal("Daniel");
    });
  });
  // Test if the return message is correct
  describe("say something", function() {
    it("should say something", function() {
      var person = new Person('Daniel').saySomething('Hi Friends!!');
      expect(person).to.equal("Daniel wants to say: Hi Friends!!");
    });
  });
});
~~~

Let's dive into our code test:

**describe** - The main purpose for the **describe** function is grouping test cases, we can think of these functions as containers, we see two **describe** functions inside the first one, in that case they have the same purpose, serve as containers, our first **describe** function is our container for all our tests, and the second ones are containers for a specific group of test.

**it** - Function to write a test case, inside every **it** function we'll put our assertions commands for our test case.

Inside our **it** function there're some assertions commands from chai library

**expect** - With chai we can write our test in two different styles, assertion style and BDD style, in this case we use a BDD style exposed through **expect** function, we use BDD style because it provides us a more descriptive methods at the moment to read our test, but if you want to know more about the different styles, you can check the [documentation](http://chaijs.com/guide/styles/).

## Run our tests

In the root of our folder we type this into our console:

~~~
mocha-phantomjs index.html
~~~

and in our console we'll see the results:

![Mocha test](/images/mocha-test.png)  

As you can see, it is really easy to test our code using mocha, chai and phantom and now we can write tests for our projects, a more advanced use could be, using phantom.js in a different server where we'll run our tests and use something like [Jenkins](https://jenkins-ci.org/) for reporting results.
