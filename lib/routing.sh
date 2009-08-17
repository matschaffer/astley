route() {
  local direct_method regex_method
  run_action `resolve_controller_method`
}

resolve_controller_method() {
  local direct_method regex_method
  direct_method=`direct_method`
  if is_valid_action "${direct_method}"; then
    echo "${direct_method}"
  else
    matched_method=`resolve_matched_route "${PATH_INFO}"`
    if is_valid_action "${matched_method}"; then
      echo "${matched_method}"
    else
      echo "get/_astley/error/404"
    fi
  fi
}

direct_method() {
  echo `downcase ${REQUEST_METHOD}`"${PATH_INFO}"
}

is_valid_action() {
  type -t "$1" > /dev/null
  return "$?"
}

run_action() {
  is_valid_action "before_$1" && "before_$1"
  send_headers
  "$1"
  is_valid_action "after_$1" && "after_$1"
}

match_route() {
  add_to_hash matched_routes "$1" "$2"
}

resolve_matched_route() {
  local hash_length i regex
  hash_length=`hash_length matched_routes`
  for ((i=0;i<$hash_length;i++)); do
    regex="${matched_routes_keys[$i]}"
    if echo "$1" | grep -sq -e "${regex}"; then
      echo "${matched_routes_values[$i]}"
    fi
  done
}

before_get/_astley/error/404() {
  STATUS=404
  RESPONSE_CONTENT_TYPE="application/xhtml+xml; charset=utf-8"
}

get/_astley/error/404() {
  render "${ASTLEY_HOME}/views/404.html"
}
