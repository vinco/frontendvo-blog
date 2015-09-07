---
layout: post
title:  "Create your first emberjs application"
date:   2015-09-07 21:00:00
categories: ember emberjs javascript front-end frameworks
author: carolfc
---

The world of **JavaScript** frameworks in increasingly crowded is among the most prominent with **Angularjs and BackboneJS**, we find **EmberJS.** This could be considered a powerful intermediary between its competitors, it serves to both major projects and those who do not need too many features. In this article we will learn how to install and create our first application, EmberJS.


## Installation

Installation is very simple, we'll just have installed on your computer: nodejs and **NPM** system packages (Who does not already have it?), we also need have git installed.

To verify that we have installed and which version nodejs have write in a console:

    `node --version`

With this you can start installing **emberJS** and its dependencies, using the packaging system of nodejs (NPM):

    `npm install -g ember-cli`

If we're on Linux or Mac, you should do so as root, if we are in Windows as administrator.

We will also install **PhanthomJS** to perform and run our **test**.

    `npm install -g phanthomjs2`

This is all !! we have emberjs!!.

 Check our version:

    `ember -v`


## Creating my first app

**Ember** has its own **generator** for most everyday tasks we have to perform when we're developing an app with it. We started using this generator to create the basic structure of our application:

    `ember new name-my-vinco-app`

This creates a folder with the name that you have given to your application, in this case name-my-vinco-app. Now if we go into our folder and we started our server, we see our first application running!!.

    `cd name-my-vinco-app`
    `ember server`

If all goes well, we will see our first application running on [http://localhost:4200](http://localhost:4200) . This will be our address local testing and development.

As our future intention is to have our application in a production server, when we finish working with her and want to move it, we will compile our environment:

    `ember build --environment=production`

This will create a folder on us dist / directory with everything you need to run in a production environment.

With this we would have the basics to start our journey with ember!

## Basic concepts

Emberjs is not a MVC framework * anyone as components have also apart from models, views (templates), controllers and routes.


##### **MODEL, VIEW, CONTROLLER**

Emberjs automatically creates us once our application we created our first model and the view or controller. We all prepared to work anyway if we need anything extra, we can also create it manually or through ember generator.

In this case almost everything works like any framework, in the view we can call the instances we created on the controller, always with {{ }}, and use our models in our controller.

##### **COMPONENTS**

The components are small pieces of code that can include tags in the  views. We can create them through a certain logic in controller or enter them.

And you, you have not already created your first application with emberjs? what are you waiting for?!!
