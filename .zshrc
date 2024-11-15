journalctl --vacuum-size=64M
clear
df -h | awk 'NR == 1 || NR == 10' 

# version control
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'

# colour codes
INTENSE_RED="%F{9}"
INTENSE_GREEN="%F{10}"
INTENSE_YELLOW="%F{11}"
INTENSE_BLUE="%F{12}"
INTENSE_MAGENTA="%F{13}"
INTENSE_CYAN="%F{14}"
RESET="%f"

# PROMPT
setopt PROMPT_SUBST

PROMPT='
┌${INTENSE_GREEN}%n${INTENSE_YELLOW} @ ${INTENSE_RED}%m%f
├╴${INTENSE_BLUE}%~ %F{red}${vcs_info_msg_0_}%f
└─: '
