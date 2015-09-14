---
layout: post
title:  "Create your first emberjs application"
date:   2015-09-07 21:00:00
categories: ember emberjs javascript front-end frameworks
author: carolfc
---

The JavaScript frameworks world is getting more and more crowded. Together with such famous frameworks as angularJS and backboneJS, we find emberJS. The main advantage of EmberJS against its competitors is that it can be used for both, major and minor projects. In this article we will learn how to install and create our first application thanks to emberJS.


## Installation

The installation is very easy. Previously, we should have installed git and nodeJS and its package manager npm (Who hasn't done it yet?).

To check if we have already installed nodeJS or not or its version, we must write to the console:

    `node --version`

After this, we can install emberJS and its dependencies, using the nodeJS package manager: npm.

    `npm install -g ember-cli`

Linux and Mac users must be logged in as the root user, Windows users as the administrator.

We will also install phantomJS to perform and run our tests.

    `npm install -g phanthomjs2`

That is all! EmberJS is already installed in our computer. Let's check:

    `ember -v`


## Creating my first app

EmberJS has its own generator for most everyday tasks we have to perform when we are developing an app with it. We should use this generator to create the basic structure of our application:

    `ember new name-my-vinco-app`

So, a new folder will be created with the name we provided to our application; in this case: name-my-vinco-app. After this, if we go into our folder and we run our server, we will see our first application running!.

    `cd name-my-vinco-app`
    `ember server`

If all goes well, our local testing and development address will be [http://localhost:4200](http://localhost:4200).

As our future intention is to have our application in a production server, we will need to compile our environment when we finish working with it and want to move it:

    `ember build --environment=production`

This will generate a folder on our dist/directory with everything we need to run in a production environment.

With this we will have the basics to start our journey with emberJS!

## Basic concepts

EmberJS is not a MVC* framework like anything else, since it has models, views (templates), controllers and routes, apart from components.


##### **MODEL, VIEW, CONTROLLER**

EmberJS creates the first model, view and controller in our application automatically. However, we can create our MVC manually or through ember generator as well.

In this case, almost everything works like in any other framework: in the view we can call the instances we have generated on the controller, always with {{ }}, and use our models in our controller.

##### **COMPONENTS**

Components are small code pieces that we can include as tags in a view. We can create them adding certain logic through our controller or the component itself.

And you, you not created your first application with emberjs yet? what are you waiting for?!!
