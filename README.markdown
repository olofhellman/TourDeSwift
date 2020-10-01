## What is Tour de Swift?

In July 2019, I did a presentation for Xcoders (seattlexcoders.com) which was an introduction to the swift programming language.  As part of the presentation, I prepared a simple Mac application written in swift that would illustrate all the basic features of the language. I didn't go into depth on any features, but tried to highlight the most common patterns that would be interesting to experienced programmers new to swift.

The presentation ended up going slightly over an hour and a half, and touched on these areas of swift:

* let and var
* tuples
* optionals 
* guard and 'if let' 
* structs
* classes
* enums
* parameter labels and _  
* loops
* arrays 
* dictionaries 
* extensions
* closures
* filter / map / reduce
* nil coalescing
* ranges 

The accompanying keynote file is a rather long 261 slides, but many of those are 
sequences where one slide simply adds one line of code to the previous slide, as the presentation walks through code examples.

The demo Mac application is a very primitive survey-taking application, and the example code builds a three question survey, each of which has a different answer format:

1. What is your name?

1. What is swift?
 * A bird
 * A musician named Taylor
 * A bank transfer system
 * A programming language
 
1. Do you like Swift?
 * scale from 1 to 7 
   
And shows how one might analyze results from such a survey.