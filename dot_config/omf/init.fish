# 1) Set environment variables.
set -gx WORKSPACE_PATH $HOME/Workspace 
set -gx FLUTTER_ROOT $WORKSPACE_PATH/bin/flutter
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx N_PREFIX $HOME/.n
set -gx HOMEBREW_PATH /opt/homebrew
set -gx ZELLIJ_AUTO_EXIT true

fish_add_path $N_PREFIX/bin
fish_add_path $WORKSPACE_PATH/bin
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/build-tools/28.0.3
fish_add_path $ANDROID_HOME/tools
fish_add_path $HOMEBREW_PATH/bin/
fish_add_path $HOMEBREW_PATH/Cellar/postgresql@11/11.20_1/bin
fish_add_path $HOMEBREW_PATH/Cellar/python@3.12/3.12.2_1/libexec/bin
fish_add_path /usr/local/Cellar/ruby/2.7.0/bin/
fish_add_path /usr/local/bin

# 2) Set aliases.
# git aliases.
alias gp='git push' 
alias gl='git pull'
alias gc='git add . && git commit -m' 
alias gs='git stash'
alias gk='git checkout'
# rosetta aliases.
alias x86='arch -x86_64'
# misc aliases
alias postgre="postgres -D ~/Workspace/bin/postgres/data"
# Turbokat aliases
function enter
  code $WORKSPACE_PATH/ClearGlass/$argv
end
alias base='docker exec -u root -it  $(docker ps -f name=base  --format "{{.ID}}") php artisan --'
alias tlog='turbokat log'
function trs
  docker restart  $(docker ps -f name=$argv --format "{{.ID}}")
end
function texec 
  docker exec -u root -it $(docker ps -f name=$argv --format "{{.ID}}") sh
end
# release aliases
alias release="release.sh"
# aws aliases
alias sshcg="sshcg.sh"
alias lgn="aws-vault login"
alias qa="aws-vault exec qa --"
alias tst="aws-vault exec test --"
alias dev="aws-vault exec dev --" 

# 3) Starship prompt integration.
if test -n (which starship)
   starship init fish | source
end

# 4) SDKMAN integration.
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

function start_zellij
    set ZJ_SESSIONS (zellij list-sessions)
    set NO_SESSIONS (echo "$ZJ_SESSIONS" | wc -l)
    if [ "$NO_SESSIONS" -ge 2 ]; then
        zellij attach \
        "(echo "$ZJ_SESSIONS" | sk)"
    else
        zellij attach -c
    end
end

# 5) Test if zellij is available.
if test (which zellij)
    # Start zellij if not started already.
    if set -q ZELLIJ
    else
        echo "starting"
        start_zellij
    end
end

# 6) Hook direnv if available.
if test (which direnv)
    direnv hook fish | source
end 

# 7) Set my shell greeting message.
set -U fish_greeting
echo (set_color cyan) '
Welcome Mustansir! What will it be today?
' (set_color normal)
