route() {
  local fn
  fn=`downcase ${REQUEST_METHOD}`"${PATH_INFO}"
  if type -t "${fn}" > /dev/null; then
    "${fn}"
  else
    echo "Status: 404"
    send_headers
    echo "404'd!"
  fi
}
