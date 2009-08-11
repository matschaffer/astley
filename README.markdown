Astley
======

A web framework written in Bash. 

This project started with [a vision](http://twitter.com/matschaffer/status/2687123743) and was [spurred on](http://twitter.com/javallone/status/2688925657) by the support of good friends. Now it's reached the point where you might actually be able to do something with it. But probably not.

Usage
=====

Setup
-----

So far this is all wired up through CGI. So you'll need something like this in your apache configuration:

    <VirtualHost *:80>
      ServerName astley.local
      DocumentRoot "/path/to/astley/examples"
    </VirtualHost>

And you'll probably want some of the magic included in `examples/.htaccess` to make URLs a little nicer.

Writing apps
------------

Astley currently just tries to map the request method and PATH_INFO to a command (usually a function, but a regular executable should work too).

So a GET request for "/" will map to the function `get/`. Or a POST to "/give/you/up" will try to call `post/give/you/up`.

See `examples/index.cgi` for more examples.