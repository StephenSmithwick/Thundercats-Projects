### Helper Functions
__p_projects=""

__p_header() {
	printf "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
	clear

  echo "░░░░░░▄▄▀▀▀▀▀▀▀▀▀▀▄░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ "
  echo "░░░░▄▀░░░░░░░░░░▄▄▄▀▀▄░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ "
  echo "░░▄▀░░░░░░░░░▄███▀▄██▄▀▄░░░░░░░░░░░░░░░░░░░░░░░ "
  echo "░█░░░░░░░░▄████▄▄█████▄▀▄░░░░░░░░░░░░░░░░░░░░░░ "
  echo "█░░░░░░░▄▀▄████████████▄▀▄░░░░░░░░░░░░░░ "
  echo "█░░░░▄▄███████████▄▀████░█░░░░░░░ "
  echo "█░▄█████████████████░███░█░░░░░░░ $@ "
  echo "█▀█████▀░░░░░███████▀███░█░░░░░░░ "
  echo "▀▄▀███░░░░░░░██████▀░░▀▀▄▀░░░░░░░░░░░░░░ "
  echo "░▀▄░▀█▄░░░░░▄██▀▀░░░░░░▄▀░░░░░░░░░░░░░░░░░░░░░░ "
  echo "░░▀▄░░░░▄▄▄████▄▄░░░░▄▄▀░░░░░░░░░░░░░░░░░░░░░░░ "
  echo "░░░░▀▄▄░░▀▀▀██▀▀░░░▄▄▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ "
  echo "░░░░░░░▀▀▄▄▄▄▄▄▄▄▀▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ "
	echo
}

function __p_project() {
	__p_projects="${__p_projects} $1"
	eval "function __p_${1}() ${2}"
}

function __p_choose() {
	if echo "${__p_projects}" | grep -q "${1}"; then
		eval "__p_$1"
	else
		echo "" >&2
		echo "Usage: $(basename $0) [${__p_projects}]" >&2
		return -1
	fi
}

### Project Helpers
function __p_use_project_helpers() {
function s_jboss() {
  __p_header "Starting JBOSS"
  $JBOSS_HOME/bin/run.sh
}

function s_tomcat() {
  __p_header "Starting Tomcat"
  $TOMCAT_HOME/bin/startup.sh
}
}

### Projects
__p_project thundercats '{
  __p_header "Thundercats Ho"
  cd ~/Thundercats-Projects
  
  alias edit="subl -nw"
}'

function __p() {
  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  if [ ${prev} == "p"  ]; then
    COMPREPLY=( $(compgen -W "${__p_projects}" -- ${cur}) )
    return 0
  fi
}
complete -F __p p

##################
# Public methods #
##################

### Project Loader
function p() {
  if __p_choose $1; then
    __p_use_project_helpers
  else
    return -1
  fi
}

### Project Configuration
function p_config() {
  subl -nw ~/Thundercats-Projects/setup.bash && source ~/Thundercats-Projects/setup.bash
}
