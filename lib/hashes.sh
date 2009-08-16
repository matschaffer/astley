create_hash() {
  local hash_name assign_to index
  hash_name="$1"
  shift

  assign_to="keys"
  index=`eval echo \$\{\#${hash_name}_keys[@]\}`
  for arg in "$@"; do
    eval "${hash_name}_${assign_to}[${index}]=\"${arg}\""
    if [ "${assign_to}" == "keys" ]; then
      assign_to="values"
    else
      let index=index+1
      assign_to="keys"
    fi
  done
}

access_hash() {
  local i hash_name hash_length current_key
  hash_name="$1"
  hash_length=`eval echo \$\{\#${hash_name}_keys[@]\}`
  for ((i=0;i<$hash_length;i++)); do
    current_key="`eval echo \$\{${hash_name}_keys[$i]\}`"
    if [ "${current_key}" == "$2" ]; then
      echo "`eval echo \$\{${hash_name}_values[$i]\}`"
    fi
  done
}

add_to_hash() {
  create_hash "$@"
}

destroy_hash() {
  eval "unset $1_keys"
  eval "unset $1_values"
}