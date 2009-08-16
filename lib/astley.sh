ASTLEY_HOME=`dirname "${BASH_ARGV[0]}"`
. "${ASTLEY_HOME}/routing.sh"
. "${ASTLEY_HOME}/strings.sh"
. "${ASTLEY_HOME}/views.sh"
. "${ASTLEY_HOME}/hashes.sh"

# Only auto-route if getting called from CGI
[ -n "${GATEWAY_INTERFACE}" ] && route