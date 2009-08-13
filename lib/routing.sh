route() {
  local fn output template processed_template
  fn=`downcase ${REQUEST_METHOD}`"${PATH_INFO}"
  if type -t "${fn}" > /dev/null; then
    output=`"${fn}"`
    send_headers
    echo $output
  else
    echo "Status: 404"
    send_headers
    template "${ASTLEY_HOME}/errors/404.html"
  fi
}
