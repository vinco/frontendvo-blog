---
layout: post
title:  "Introduction to CoffeeScript"
date:   2015-09-01 11:00:00
categories: coffescript javascript front-end
author: zesk8
---

CoffeeScript is the most used pre-compiled language to code in javascript. In this post we cover some basic aspects about CoffeeScript and why it's so attractive to many developers.

### Pros and cons

Some benefits of using CoffeeScript are:

+ code in a more readable syntax
+ code is more easy to maintain
+ apply best practices at the moment of campilation
+ shorter development time
+ no more ";"
+ a complete class system
+ identation is part of the language

On the other hand many people mention some disadvantages of using CoffeeScript:

+ A compilation step is necessary (we can use a yeoman generator to deal with this)
+ difficult to debug (solved with source maps)
+ difficult to learn (not really, with 2 hours of reading [The Little Book on CoffeeScript](http://arcturo.github.io/library/coffeescript/) we can learn a lot)

As we can see there is really no disadvantages to using CoffeeScript, in fact, a technical reason not to use it doesn't exist. But one important thing to consider is that CoffeeScript isn't a substitute to learning javascript **it's just a beautiful way to write javascript**.

### General overview

#### Variables
We don't have to use the keyword **var**, CoffeeScript automatically adds this for us at the moment of campilation, so we don't have to worry about variable hoisting or undeclared variables.

~~~coffee
# string
foo = 'bar'

# number
num = 4000

# boolean, instead of true or false values we can use more descriptive words: is, yes, not, isnt
isTrue = true 

#array
numbers = [0, 1, 2, 3]

#objects
student =
  height: '1.65 m'
  age: 33
  gender: 'male'
  brothers: ['Jess', 'Tom']
~~~
In CoffeeScript we can assign values from an array to differente variables:

~~~coffee
[foo, bar] = [1, 2] # compile in: va ref = [1, 2], var foo = ref[0], var bar = ref[1];
~~~

#### Arrays
Arrays don't suffer great changes, the easiest way to declare an array is:

~~~coffee
numbers = [0, 1, 2, 3]
~~~

But if we have an array with multiples values, we can declare our array like this:

~~~coffee
# note that at the end of every line there isn't a comma, CoffeeScript does it for us.
numbers = [
  0, 1, 2
  3, 4, 5
  6, 7, 8
  9, 10, 11
]
~~~

Also we can define an array with a range:

~~~coffee
range = [1..5] # compile in: var range = [1, 2, 3, 4, 5]
~~~

#### Objects
To define an object, we don't need curly braces instead of that, we use indentation to define our object.

~~~coffee
student =
  height: '1.65 m'
  age: 33
  gender: 'male'
  brothers: ['Jess', 'Tom']
~~~

#### Conditionals

In conditionals we can use more descriptive words:

~~~coffee
test = true

if (test is true)
  console.log('is true');
  
if (test isnt true)
  console.log('is not true');
  
# a ternary operation
result = if test then 'is true' else 'is not true'
~~~

#### Loops
To loop through an array:

~~~coffee
for num in [1..5]
  console.log(num)
~~~

To loop through an object:

~~~coffee
people =
  tom: 31
  billy: 25
  jess: 19

for person, age of people
  console.log(person + 'is' + age)
~~~

#### Functions
To define a function we don't need the keyword **function** and also we don't need curly braces, to define the body of our function we use **->**.

~~~coffee
foo = ->
  console.log('foo')

# with parameters:
foo = (bar) ->
  console.log(bar)
  
# with parameters initialized
foo = (bar = 'start') ->
  console.log(bar)
~~~

#### Interpolation string 
Quotes aren't only used to define strings, we can interpolate strings with them if we use simple quotes, anything we put inside them will be treat as a string:

~~~coffee
word = '123 - this is a simple...string!!'
~~~

But if we use double quotes we can use a special syntax to concatenate variables with strings:

~~~coffee
age = 24
name = daniel
console.log("#{name} is #{age}") # compile into: console.log(name + " is " + age)
~~~

And if we use triple double quotes we can write strings blocks and they can maintain their indentation:

~~~coffee
text = """
  line one
  line two
"""

console.log(text) # print: line one\nline two
~~~
#### Classes

CoffeeScript has an excellent abstraction of prototypal inheritance, so we can use **classes** in javascript, we don't have to deal with prototypes, CoffeeScript does the hard work for us and implement the best practices, let's check an example:

~~~coffee
class Animal
  constructor: (@name) ->

  move: (meters) ->
    alert @name + " moved " + meters + "m."

class Snake extends Animal
  move: ->
    alert "Slithering..."
    super 5

class Horse extends Animal
  move: ->
    alert "Galloping..."
    super 45

sam = new Snake "Sammy the Python"
tom = new Horse "Tommy the Palomino"
~~~

In the code above we see some interesting things:

+ **@name** : this is the short code for: **this.name**
+ A parent class (Animal) exists as well as 2 classes (Snake, Horse) which extend the parent class
+ **extends** : the keyword to extend a class
+ In both sub-classes we can see that both overwrite the move method and inside of them we see the keyword **super** which is the reference of the parent method.

If we put the compiled code in a browser console we'll see that works perfectly.

#### Conclusion

CoffeeScript is a great tool which helps us improve our work and save development time, if you want to learn more about CoffeeScript you can check their own [site](http://coffeescript.org/).
