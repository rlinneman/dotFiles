# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PROMPT_COMMAND='__build_ps1'

__git_root_path() {
	git rev-parse --show-toplevel 2> /dev/null
}

__git_relative_path() {
	git rev-parse --show-prefix 2> /dev/null
}

__git_sha_short() {
	git rev-parse --short HEAD 2> /dev/null
}

__git_branch_name() {
	git symbolic-ref --short HEAD 2> /dev/null
}

__build_ps1(){
	local SHA="$(__git_sha_short)"

	local RESET="\[\033[0m\]"

	local BLACK="\[\033[0;30m\]"
	local BLUE="\[\033[0;34m\]"
	local GREEN="\[\033[0;32m\]"
	local CYAN="\[\033[0;36m\]"
	local RED="\[\033[0;31m\]"
	local PURPLE="\[\033[0;35m\]"
	local BROWN="\[\033[0;33m\]"
	local LIGHT_GRAY="\[\033[0;37m\]"

	local DARK_GRAY="\[\033[1;30m\]"
	local LIGHT_BLUE="\[\033[1;34m\]"
	local LIGHT_GREEN="\[\033[1;32m\]"
	local LIGHT_CYAN="\[\033[1;36m\]"
	local LIGHT_RED="\[\033[1;31m\]"
	local LIGHT_PURPLE="\[\033[1;35m\]"
	local YELLOW="\[\033[1;33m\]"
	local WHITE="\[\033[1;37m\]"


	if [ -n "${SHA}" ]; then
		local GROOT="$(__git_root_path)"
		local GPATH="$(__git_relative_path)"
		local BRANCH_NAME="$(__git_branch_name)"

		echo -ne "\e]0;$BRANCH_NAME\u2605$GROOT\007"

		PS1="$LIGHT_BLUE${GROOT##*/}$LIGHT_GRAY $(__git_sha_short) $LIGHT_GREEN$BRANCH_NAME$LIGHT_GRAY:$LIGHT_BLUE${GPATH:=/}$RESET "
	else
		echo -ne "\e]0;$PWD\007"
		PS1="[\u@\h $LIGHT_BLUE\W$RESET]\$ "
	fi
}
