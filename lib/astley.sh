ASTLEY_HOME=`dirname "${BASH_ARGV[0]}"`
. "${ASTLEY_HOME}/routing.sh"
. "${ASTLEY_HOME}/strings.sh"
. "${ASTLEY_HOME}/views.sh"
. "${ASTLEY_HOME}/hashes.sh"

if is_valid_action "init"; then
  init && route
else
  route
fi