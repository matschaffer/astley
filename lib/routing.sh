convert_to_function() {
  if [ "$1" == "/" ]; then
    echo ""
  else
    echo "$1" | sed "s|/|_|"
  fi
}

route() {
  eval `downcase ${REQUEST_METHOD}``convert_to_function ${PATH_INFO}`
}
