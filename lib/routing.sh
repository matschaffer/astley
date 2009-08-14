route() {
  local fn
  fn=`resolve_controller_method`
  if type -t "${fn}" > /dev/null; then
    run_controller_method "${fn}"
  else
    run_controller_method "get/_astley/error/404"
  fi
}

resolve_controller_method() {
  echo `downcase ${REQUEST_METHOD}`"${PATH_INFO}"
}

run_controller_method() {
  type -t "before_$1" > /dev/null && "before_$1"
  send_headers
  "$1"
  type -t "after_$1" > /dev/null && "after_$1"
}

before_get/_astley/error/404() {
  STATUS=404
  RESPONSE_CONTENT_TYPE="application/xhtml+xml; charset=utf-8"
}

get/_astley/error/404() {
  render "${ASTLEY_HOME}/views/404.html"
}
