#!/bin/bash

# export TERM=screen-256color
export TERM=xterm-256color
# export TERM=tmux-256color

#########################################
# ZSH configuration
ZSH=$HOME/.oh-my-zsh                                # Path to your oh-my-zsh configuration.
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom                  # Path to your oh-my-zsh configuration.
ZSH_CUSTOM_THEMES=$HOME/.oh-my-zsh/custom/themes    # Path to your oh-my-zsh configuration.
ZSH_CUSTOM_PLUGINS=$HOME/.oh-my-zsh/custom/plugins  # Path to your oh-my-zsh configuration.

ZSH_DISABLE_COMPFIX=true                            # Disable compfix which checks insecureness of folders (disabling it for docker).
DISABLE_AUTO_TITLE=true                             # Disable shell name change (for TMUX).
DISABLE_AUTO_UPDATE=true                            # Disable auto update
HIST_STAMPS="mm/dd/yyyy"                            # Unable hisotry time stamp.
skip_global_compinit=1                              # For speed-up oh-my-zsh startup time.

#########################################
# Setting
umask 000              # umask, which sets the default file permissions for newly created files and directories.
                       # 000 means that new files will have permissions 666 (read and write for everyone),
                       # and new directories will have permissions 777 (read, write, and execute for everyone).
                       # This is generally not recommended for security reasons.
                       # Note: umask does not affect existing files or directories.
TZ=Asia/Seoul          # Time zone

#########################################
# THEME
ZSH_THEME="agnoster"
# ZSH_THEME="robbyrussell"              

#########################################
# Device specific settings
DEVICES_LIST=(
    "HOME_WSL"
    "LAB_WSL"
    "NOTEBOOK_WSL"
    "LAB_MARK"
    "LAB_GSAI"
)

DEVICE=""
DEVICE_GROUP=""
if [[ "$(uname -r)" =~ WSL2$ ]]; then
    # WSL environment
    export DEVICE_GROUP="WSL"
else
    # Not WSL environment (like Mark or GSAI)
    export DEVICE_GROUP="NON_WSL"
fi

if [[ "$HOST" == *cgmark*]]; then
    export DEVICE="LAB_MARK"
elif [[ "$HOST" == *gsai* ]]; then
    export DEVICE="LAB_GSAI"
fi

#########################################
# PLUGINS
if [ ! -d $ZSH_CUSTOM_PLUGINS/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM_PLUGINS/zsh-autosuggestions
fi
if [ ! -d $ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting
fi
if [ ! -d $ZSH_CUSTOM_THEMES/spaceship-prompt ]; then
    git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CUSTOM_THEMES/spaceship-prompt
fi
if [ ! -d $ZSH_CUSTOM_THEMES/agnoster-zsh-theme ]; then
    git clone https://github.com/agnoster/agnoster-zsh-theme.git $ZSH_CUSTOM_THEMES/agnoster-zsh-theme
fi
if [[ ! -d ~/.fzf ]]; then
    echo "Installing fzf..."
    install_fzf
fi

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
  fzf
)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#########################################
# Source oh my zsh
source $ZSH/oh-my-zsh.sh

#########################################
# Agnoster THEME SETTING 
# (this should be after source oh-my-zsh)
source $HOME/.zsh/set_agnoster.zsh

#########################################
# compinit
autoload -Uz compinit
# set zcompdump to be saved in different directory
compinit -u $HOME/.cache/zsh/zcompdump-$ZSH_VERSION

#########################################
# MISC
## Set tab color completion as the same as dircolros ##
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

#########################################
# KEY BINDINGS
bindkey -M menuselect '^[[Z' reverse-menu-complete # Enable shift-tab
bindkey '^l' autosuggest-accept
bindkey '^h' autosuggest-clear
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey '^[[3~' delete-char
bindkey '^H' backward-delete-char

#########################################
# Alias
tmux_version=$(tmux -V | cut -d ' ' -f 2 | cut -d '.' -f 1)
if [[ $tmux_version -eq 3 ]]; then
    alias tmux="tmux -2 -u -f $HOME/.tmux3.conf"
else
    alias tmux="tmux -2 -u -f $HOME/.tmux2.conf"
fi
# alias tmux="tmux -2 -u -f $HOME/.tmux2.conf"
# tmux -2 : force tmux to assume the terminal supports 256 colours
# tmux -u : tmux attempts to guess if the terminal is likely to support UTF-8 by checking
#           the first of the LC_ALL, LC_CTYPE and LANG environment variables to be set for
#           the string "UTF-8".  This is not always correct: the -u flag explicitly
#           informs tmux that UTF-8 is supported.
#           If the server is started from a client passed -u or where UTF-8 is detected,
#           the utf8 and status-utf8 options are enabled in the global window and session
#           options respectively.
if [[ -n "$TMUX" ]]; then
    bindkey "^[[1~" beginning-of-line
    bindkey '^[[4~' end-of-line
fi

#########################################
# If device_group is WSL, then set WSL specific variables
if [[ "$DEVICE_GROUP" == "WSL" ]]; then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/kkang/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/kkang/anaconda3/etc/profile.d/conda.sh" ]; then
    # . "/home/kkang/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        else
    # export PATH="/home/kkang/anaconda3/bin:$PATH"  # commented out by conda initialize
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    echo -----------------------------------------
    echo Hello Kyoungkook Kang
    echo
    echo "You are in WSL environment. (KKANG_Settings)"
    echo $(uname -r)
    echo
    eval "echo LANG: $LANG"
    eval "echo TERM: $TERM"
    eval "echo -n 'TMUX: '"
    eval tmux -V
    echo -----------------------------------------
    export link_dir=$(dirname "$(realpath ~/.zshrc)")

    # MISC 
    export PATH=/usr/local/cuda-11.4/bin:$PATH
    # export LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64:$LD_LIBRARY_PATH
    export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
    export LIBGL_ALWAYS_INDIRECT=0
    export GEM_HOME=$HOME/gems
    export PATH=$HOME/gems/bin:$PATH
    alias "bundle_run=bundle exec jekyll serve"
elif [[ "$DEVICE_GROUP" == "NON_WSL" ]] && [[ "$DEVICES" == "LAB_MARK"]]; then
    # Not WSL environment (Docker container)
    
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/opt/conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
    # . "/opt/conda/etc/profile.d/conda.sh"  # commented out by conda initialize
        else
            export PATH="/opt/conda/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    echo --------------------------------------------
    echo Hello Kyoungkook Kang
    echo
    echo "You are in Ubuntu environment. (KKANG_Vault)"
    echo $DEVICES
    echo
    eval "echo LANG: $LANG"
    eval "echo TERM: $TERM"
    eval "echo -n 'TMUX: '"
    eval tmux -V
    echo --------------------------------------------
    export link_dir=$(dirname "$(realpath ~/.zshrc)")
    # export link_dir='/Jarvis/workspace/kkang/KKANG_Vault'
elif [[ "$DEVICE_GROUP" == "NON_WSL" ]] && [[ "$DEVICES" == "LAB_GSAI" ]]; then
    # Not WSL environment (GSAI)
    
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/kkang831/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
            # . "/opt/conda/etc/profile.d/conda.sh"  # commented out by conda initialize
        else
            # export PATH="/opt/conda/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    echo --------------------------------------------
    echo Hello Kyoungkook Kang
    echo
    echo "You are in GSAI environment. (KKANG_Vault)"
    echo $DEVICES
    echo
    eval "echo LANG: $LANG"
    eval "echo TERM: $TERM"
    eval "echo -n 'TMUX: '"
    eval tmux -V
    echo --------------------------------------------
    export link_dir=$(dirname "$(realpath ~/.zshrc)")
fi

#########################################
# Custom variables
export PATH="$HOME:$PATH"
export PATH="$HOME:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/bin/kkang_core:$PATH"
export PATH="$HOME/bin/kkang_core/git:$PATH"
export PATH="$HOME/bin/kkang_core/environments:$PATH"
export PATH="$HOME/bin/kkang_core/img_processing:$PATH"
export PATH="$HOME/bin/kkang_core/install:$PATH"
export PATH="$HOME/bin/kkang_core/temp:$PATH"
export PATH="$HOME/bin/kkang_core/utils:$PATH"
export PATH="$HOME/bin/vscode_snippet:$PATH"
export PATH="$HOME/bin/kkang_core/autofig_developed:$PATH"

export MY_CACHE_CP="$HOME/.cache/cpscript.txt"
export MY_CACHE_MV="$HOME/.cache/mvscript.txt"
export MY_CACHE_LN="$HOME/.cache/lnscript.txt"

export my_jarvis=/Jarvis/workspace/kkang
export my_workspace=/Jarvis/workspace/kkang/Workspace
export my_gan=/Jarvis/workspace/kkang/GANModels
export my_diffusion=/Jarvis/workspace/kkang/DiffusionModels
export my_fonts=$link_dir/fonts
export KKANG_Bin=/Jarvis/workspace/kkang/KKANG_Bin
export KKANG_Vault=/Jarvis/workspace/kkang/KKANG_Vault
export KKANG_Docker=/Jarvis/workspace/kkang/KKANG_Docker
export KKANG_Functions=/Jarvis/workspace/kkang/KKANG_Functions

if [ -d "/mnt/c/Users/Kyoun/Desktop" ]; then
    export desktop='/mnt/c/Users/Kyoun/Desktop'
    export my_drive='/mnt/c/Users/Kyoun/OneDrive - postech.ac.kr'
elif [ -d "/mnt/c/Users/owner/Desktop" ]; then
    export desktop='/mnt/c/Users/owner/Desktop'
    export my_drive='/mnt/c/Users/owner/OneDrive - postech.ac.kr'
fi

#########################################
# Custom alias
alias "kk_link=$link_dir/kk_link"
# alias "nv=nvim"
alias "cl=clear"
# alias "pip=pip3"
# alias "python=python3"
alias "stat=easy_stat"

#########################################
# Custom function
cd(){builtin cd "$@" && pwd && ls;}
ntop(){
    python -m nvitop -m --pid "0" $@
    # Check the exit status of the previous command
    if [ $? -ne 0 ]; then
        pip install --upgrade nvitop && python -m nvitop -m --pid "0" --mem-util-thresh "98" "99" $@
    fi
}
rmcd(){ 
    cd "$(_del_cur_dir $1)"
}
mkcd () {
    mkdir -p "$1" && cd "$1"
}
kk_echo() {
    echo ""
    cat $link_dir/_kk_echo.md
    echo ""
    echo ""
}

# enter
enter_vssnips(){
    cd $HOME/bin/vscode_snippet
    echo "--------------------------------"
    echo "vssnips directory"
    ./vssnips -h
    # echo "./vssnips [-h] [--name NAME] [--target TARGET]"
}

#########################################
# Syntax highlighing plugin
# This should be at the end of zshrc file
source $ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

