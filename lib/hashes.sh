createHash() {
  local hashName assignTo index
  hashName="$1"
  shift

  assignTo="keys"
  index=`eval echo \$\{\#${hashName}_keys[@]\}`
  for arg in "$@"; do
    eval "${hashName}_${assignTo}[${index}]=\"${arg}\""
    if [ "${assignTo}" == "keys" ]; then
      assignTo="values"
    else
      let index=index+1
      assignTo="keys"
    fi
  done
}

accessHash() {
  local i hashName hashLength currentKey
  hashName="$1"
  hashLength=`eval echo \$\{\#${hashName}_keys[@]\}`
  for ((i=0;i<$hashLength;i++)); do
    currentKey="`eval echo \$\{${hashName}_keys[$i]\}`"
    if [ "${currentKey}" == "$2" ]; then
      echo "`eval echo \$\{${hashName}_values[$i]\}`"
    fi
  done
}

addToHash() {
  createHash "$@"
}

destroyHash() {
  eval "unset $1_keys"
  eval "unset $1_values"
}