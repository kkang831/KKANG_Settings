# build_prompt() {
#   RETVAL=$?
#   prompt_status     # success or failure if failure output x
#   prompt_virtualenv
#   prompt_aws
#   prompt_context
#   prompt_dir
#   prompt_git
#   prompt_bzr
#   prompt_hg
#   prompt_end
# }

build_prompt() {
  RETVAL=$?
  prompt_status
  # prompt_virtualenv
  # prompt_aws
  prompt_context
  prompt_dir
  # prompt_git
  # prompt_bzr
  # prompt_hg
  prompt_end
}

######################################################
# Begin a segment
# Takes three arguments, background and foreground, some string. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

######################################################
# Status:
# - was there an error
# - are there background jobs?
# - am I root
prompt_status() {
  local -a symbols

  # [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}❌"
  # [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}💿"
  # [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}🐳"
  [[ $RETVAL -ne 0 ]] && symbols+="❌"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="💿"
  [[ $UID -eq 0 ]] && symbols+="🐳"

  # [[ -n "$symbols" ]] && [[ $UID -ne 0 ]] && symbols+=""
  # [[ -n "$symbols" ]] && prompt_segment '' '' "$symbols"
  [[ -n "$symbols" ]] && echo -n "$symbols" && echo -n " "
}

######################################################
# Context: user_hostname (who am I and where am I)
prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    # echo %n # kkang
    # echo %m # cglabmark
    # echo $CURRENT_BG # None
    # echo $CURRENT_FG # black
    # color candidates: 11d, 75d, 226d
    prompt_segment 226d black "%n_%m" 
  fi
}

######################################################
# Show only current directory
prompt_dir() {
  # color candidates: 39d, 51d
  # prompt_segment 51d black "%8~"
  prompt_segment 147d black "%8~"
}

######################################################
# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    echo -ne "\e[5 q"  # Change cursor shape (note: this should be here)
  else
    # abnormal case
    echo -n "%{%k%}"
    echo unintended case please check ~/.zsh/set_agnoster.zsh
  fi
  echo -n "\n➜%{%f%}"
  CURRENT_BG=''
}

PROMPT='%{%f%b%k%}$(build_prompt) '