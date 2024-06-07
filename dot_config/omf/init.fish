# 1) Set environment variables.
set -gx WORKSPACE_PATH $HOME/Workspace 
set -gx FLUTTER_ROOT $WORKSPACE_PATH/bin/flutter
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx N_PREFIX $HOME/.n
set -gx HOMEBREW_PATH /opt/homebrew

fish_add_path $N_PREFIX/bin
fish_add_path $WORKSPACE_PATH/bin
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/build-tools/28.0.3
fish_add_path $ANDROID_HOME/tools
fish_add_path $HOMEBREW_PATH/bin/
fish_add_path $HOMEBREW_PATH/Cellar/postgresql@11/11.20_1/bin
fish_add_path $HOMEBREW_PATH/Cellar/python@3.12/3.12.2_1/libexec/bin
fish_add_path /usr/local/Cellar/ruby/2.7.0/bin/

# 2) Set aliases.
# git aliases.
alias gp="git push" 
alias gl="git pull"
alias gc="git add . && git commit -m" 
alias gs="git stash"
alias gk="git checkout"
# rosetta aliases.
alias x86="arch -x86_64"
# misc aliases
alias postgre="postgres -D ~/Workspace/bin/postgres/data"
# aws vault aliases
alias qa="aws-vault exec qa --"
# Turbokat aliases
function enter
  code $WORKSPACE_PATH/ClearGlass/$argv
end
alias base="docker exec -u root -it  $(docker ps -f name=base  --format "{{.ID}}") php artisan --"
alias tlog="turbokat log"
alias release="release.sh"

# 3) iTerm integration.
set ITERM_INTEGRATION_FILE ~/.iterm2_shell_integration.fish 
if test -e $ITERM_INTEGRATION_FILE
   source $ITERM_INTEGRATION_FILE 
end

# 4) Starship prompt integration.
if test -n (which starship)
   starship init fish | source
end

# 5) SDKMAN integration.
set -gx SDKMAN_DIR ~/.sdkman
if test -e $SDKMAN_DIR
  function sdk
    bash -c "source '$HOME/.sdkman/bin/sdkman-init.sh'; sdk $argv[1..]"
  end
  fish_add_path (find "$SDKMAN_DIR/candidates/maven/current/bin" -maxdepth 0)
  # fish_add_path (find "$SDKMAN_DIR/candidates/kotlin/current/bin" -maxdepth 0)
  fish_add_path (find "$SDKMAN_DIR/candidates/java/current/bin" -maxdepth 0)
  # fish_add_path (find "$SDKMAN_DIR/candidates/gradle/current/bin" -maxdepth 0)
end 

# Set my shell greeting message.
set -U fish_greeting
echo (set_color cyan) '
Welcome Mustansir! What will it be today?
' (set_color normal)

