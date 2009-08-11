send_headers() {
  echo "Content-type: ${1:-text/html}"
  echo 
}

params_string() {
  read REQUEST_BODY
  echo "${QUERY_STRING}&${REQUEST_BODY}"
}

params() {
  for pair in `params_string | tr "&" "\\n"`; do
    if echo "${pair}" | grep -e "^$1" > /dev/null; then
      echo "$pair" | cut -d= -f2 | tr + ' '
    fi
  done
}