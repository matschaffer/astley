#!/bin/bash

get/() {
  cat <<EOF
    <html>
      <head>
        <title>A form in astley</title>
      </head>
      <body>
        <form action="/saymyname" method="post">
          <input type="text" name="name" /><input type="submit" value="Say it" />
        </form>
      </body>
    </html>
EOF
}

get/thingie() {
  render "views/testView.html"
}

post/saymyname() {
  echo "you're no stranger to love `params "name"`"
}

. "../lib/astley.sh"
