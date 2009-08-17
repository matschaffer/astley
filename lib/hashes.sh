create_hash() {
  local arg hash_name assign_to index
  hash_name="$1"
  shift

  assign_to="keys"
  index=`hash_length ${hash_name}`
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

hash_length() {
  echo `eval echo \$\{\#$1_keys[@]\}`
}

access_hash() {
  local i hash_name hash_length desired_key
  hash_name="$1"
  hash_length=`hash_length ${hash_name}`
  desired_key="$2"

  hash_key_matches() {
    if [ "$1" == "${desired_key}" ]; then
      echo "$2"
    fi
  }

  iterate_hash "${hash_name}" hash_key_matches
}

iterate_hash() {
  local hash_name fn hash_length i
  hash_name="$1"
  fn="$2"
  hash_length=`hash_length ${hash_name}`
  for ((i=0;i<$hash_length;i++)); do
    "${fn}" "`eval echo \$\{${hash_name}_keys[$i]\}`" "`eval echo \$\{${hash_name}_values[$i]\}`" $i
  done
}

add_to_hash() {
  create_hash "$@"
}

destroy_hash() {
  eval "unset $1_keys"
  eval "unset $1_values"
}
