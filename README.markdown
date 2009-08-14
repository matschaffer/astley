Astley
======

A web framework written in Bash. It's kinda like Sinatra, but only really enjoyable as a joke.

This project started with [a vision](http://twitter.com/matschaffer/status/2687123743) and was [spurred on](http://twitter.com/javallone/status/2688925657) by the support of good friends. Now it's reached the point where you might actually be able to do something with it. But probably not.

Really?
=======

Seriously. Well maybe serious is the wrong word. Check it out for yourself if you want. You can skip the apache config if you want and try it out using rack. Just do this:

    cd examples
    rack astley.ru
    open http://localhost:9292

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

Writing controller methods
--------------------------

Astley currently just tries to map REQUEST_METHOD and PATH_INFO to a command. This is usually a function, but a regular executable should work too. Of course, since the path maps directly to a command, you'll be limited to urls that are legal identifiers. Thankfully Bash supports most of the usual URL characters as identifiers.

So a GET request for "/" will map to the function `get/`. Or a POST to "/give/you/up" will try to call `post/give/you/up`.

Additionally you can prefix the function name with `before_` or `after_` (e.g., `before_get/`). I intended the `before_` to be used to control how headers are sent out like status and content type. Not sure what after_ would do but it's there for sake of consistency.

See `examples/index.cgi` for some examples.

Rendering templates
-------------------

You can also render templates using the "render" function. This takes a file path to a template as an argument like `render "views/form.html"`. Templates are resolved as if they were inside double quoted strings, cause they are. So be careful to escape any usages of \, backticks, $ and probably other characters, or you may end up with an error. And if you want to include any variables just use `${MYVAR}` or you can use backticks to call functions. See examples `examples/views/response.html`