# Set environment variables.
set -gx WORKSPACE_PATH $HOME/Workspace 
set -gx FLUTTER_ROOT $WORKSPACE_PATH/bin/flutter
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx N_PREFIX $HOME/.n

set -gx PATH $PATH:$N_PREFIX/bin:
set -gx PATH $PATH:$WORKSPACE_PATH/bin
set -gx PATH $PATH:$ANDROID_HOME/platform-tools
set -gx PATH $PATH:$ANDROID_HOME/build-tools/28.0.3
set -gx PATH $PATH:$ANDROID_HOME/tools
set -gx PATH $PATH:/opt/homebrew/Cellar/postgresql@11/11.20_1/bin
set -gx PATH $PATH:/opt/homebrew/opt/python@3.11/libexec/bin
set -gx PATH $PATH:/usr/local/Cellar/ruby/2.7.0/bin/

# Set all aliase
# git aliases
alias gp="git push" 
alias gl="git pull"
alias gc="git add . && git commit -m" 
alias gs="git stash"
# rosetta aliases
alias x86='arch -x86_64'
# misc aliases
alias postgre='postgres -D ~/Workspace/bin/postgres/data'

# iTerm integration
set ITERM_INTEGRATION_FILE ~/.iterm2_shell_integration.fish 
if test -e $ITERM_INTEGRATION_FILE
   source $ITERM_INTEGRATION_FILE 
end

# Starship prompt integration.
if test starship
   starship init fish | source
end

# To set shell greeting message.
set -U fish_greeting
echo (set_color cyan) '
Welcome Mustansir! What will it be today?
' (set_color normal)

