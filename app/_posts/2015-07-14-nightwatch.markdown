---
layout: post
title:  "Nightwatch.js"
date:   2015-07-16 12:58:00
categories: testing nightwatch end-to-end
author: zesk8
---

No hace mucho que comencé a utilizar [Nightwatch.js](http://nightwatchjs.org/) como framework de testing, anteriormente solo había probado [Casper.js](http://casperjs.org/) pero desde que hice mi primer test me convenció para utilizarlo en mis próximos desarrollos, pero en qué se diferencia Nightwatch de Casper, bien, ambos proveen una sintaxis sencilla al igual que métodos para hacer aserciones y métodos para realizar comandos (esperar que algún elemento esté visible, hacer click en algún elemento, etc), ambos están bien documentados, pero lo que para mi hace la diferencia al momento de elegir es que casper utiliza [Phantom.js](http://phantomjs.org/) para ejecutar los test mientras que Nightwatch utiliza [Selenium](http://www.seleniumhq.org/).

Tanto Phantom.js como Selenium sirven para lo mismo (automatizar navegadores), pero Selenium provee la ventaja de ejecutar los test en navegadores reales, lo cual es muy útil cuando quieres probar que tu aplicación tenga consistencia entre navegadores y en diferentes sistemas operativos.

Bueno y a todo esto, qué es exactamente Nightwatch.js?

*"Nightwatch es un framework escrito en node.js para realizar pruebas End-to-End (punto a punto) que utiliza Selenium web driver para ejecutar los test en el navegador"*

Bien, ahora podemos realizar un pequeño test para ver como trabaja Nightwatch, pero antes de ello necesitamos tener instalado java y Nightwatch a través de npm:

~~~sh
$ npm install nightwatch -g
~~~

Bien la estructura básica que necesitamos es la siguiente:

~~~
├── bin/
|   └── selenium-server-standalone-{VERSION}.jar
├── tests/
|   └── test.js
└── nightwatch.json
~~~

El jar de Selenium se puede descargar en la [siguiente url](http://selenium-release.storage.googleapis.com/index.html), antes de escribir nuestro test de ejemplo hay que establecer la configuración de nuestro archivo nightwatch.json (muy sencilla por cierto):

~~~
{
  "src_folders" : ["tests"], // Carpeta donde estarán nuestros test

  // Configuración default para el servidor de selenium
  "selenium" : {
    "start_process" : true,
    "start_session" : true,
    "server_path" : "bin/selenium-server-standalone-{VERSION}.jar",
    "host" : "127.0.0.1",
    "port" : 4444
  },

  // Configuración default para los test
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
     // Configuración del navegador a utilizar
      "desiredCapabilities": {
        "browserName": "firefox",
        "javascriptEnabled": true,
        "acceptSslCerts": true
      }
    }
  }
}
~~~

Bien ahora que ya tenemos la configuración, podemos escribir nuestro sencillo test que lo único que hará es visitar la paginar de Nightwatch a traves de google.

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
Como se puede ver en el código, hay dos tipos de métodos, unos que pertenecen directamente al objeto browser (para realizar comandos, ej: click, pause, etc) y otros que pertenecen al objeto assert (para hacer aserciones) y cada uno tiene un nombre muy descriptivo de acuerdo a su función.

En todos los métodos, para poder ubicar los elementos en la página se utilizan selectores de CSS, pero no se limita a ellos, también se pueden utilizar selectores [XPATH](http://doc.scrapy.org/en/0.12/topics/selectors.html).

Lo único que falta es ejecutar nuestro test y ver de qué forma trabaja Nightwatch, para ello situándonos en la raíz de nuestra carpeta ejecutamos en nuestra terminal:

~~~sh
$ nightwatch
~~~

Como se pudo apreciar, después de ejecutar nuestro test se abrió una nueva ventana del navegador indicado en nuestro archivo de configuración (en este caso firefox) y se ejecutaron las acciones indicadas en nuestro test además de que en nuestra terminal se mostraron los resultados.

Esto fue solo un pequeño ejemplo de cómo funciona Nightwatch aunque claramente no es todo lo que se puede hacer, las posibilidades que ofrece este framework son muchas, tales como crear nuestros propios métodos de aserciones, nuestros propios métodos de comandos, correr nuestros test en paralelo (en diferentes navegadores al mismo tiempo) y muchas cosas mas, pero eso lo veremos en un próximo post, si deseas investigar más y revisar la lista completa de métodos de aserciones y comandos puedes visitar la documentación de la [api](http://nightwatchjs.org/api) de Nightwatch.
