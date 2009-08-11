#!/bin/bash

get/() {
  send_headers
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
  send_headers
  echo "you got /thingie"
}

post/saymyname() {
  send_headers
  echo "you're no stranger to love `params "name"`"
}

. "../lib/astley.sh"
