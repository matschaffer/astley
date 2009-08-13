send_headers() {
  echo "Content-type: ${RESPONSE_CONTENT_TYPE:-text/html}"
  echo "Status: ${STATUS:-200}"
  echo
}

combined_params() {
  read REQUEST_BODY
  echo "${QUERY_STRING}&${REQUEST_BODY}"
}

params() {
  for pair in `combined_params | tr "&" "\\n"`; do
    if echo "${pair}" | grep -e "^$1" > /dev/null; then
      echo "$pair" | cut -d= -f2 | tr + ' '
    fi
  done
}

render() {
  eval "echo \"$(sed 's/\"/\\"/g' "$1")\""
}