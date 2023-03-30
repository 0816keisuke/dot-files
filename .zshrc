# ===========================
# ========== PATH  ==========
# ===========================
# brew (handle for M1-Mac)
if ! which brew > /dev/null; then
    export PATH="/opt/homebrew/bin:$PATH"
fi
# Rust
export PATH="$PATH:$HOME/.cargo/bin"


# ===========================
# ========== alias ==========
# ===========================
# exa-command
alias ls="exa -F"
alias la="exa -aF"
alias ll="exa -hlF --git"
alias lla="exa -ahlF --git"
alias lt="exa -FT"
alias lta="exa -FTa"
alias llt="exa -hlFT --git"
alias llta="exa -hlFTa --git"

# Delete .DS_Store
alias delds="find . -name '.DS_Store' -delete"

# Back-up local "~/lab" data to server (eiwa) 
function backup_lab() {
    cur_dir=$(pwd)
    cd ~/lab || exit 1
    find . -name ".DS_Store" -delete
    cd ~ || exit 1
    rsync -ahvz ~/lab eiwa:~/backup/
    cd "${cur_dir}" || exit 1
}
alias backuplab=backup_lab

# Syncronize local "~/lab" data to server (eiwa) 
function sync_lab() {
    cur_dir=$(pwd)
    cd ~/lab || exit 1
    find . -name ".DS_Store" -delete
    cd ~ || exit 1
    rsync -ahvz --delete ~/lab eiwa:~/backup/
    cd "${cur_dir}" || exit 1
}
alias synclab=sync_lab

# Back-up local "~/dev" data to server (eiwa) 
function backup_dev() {
    cur_dir=$(pwd)
    cd ~/dev || exit 1
    find . -name ".DS_Store" -delete
    cd ~ || exit 1
    rsync -ahvz ~/dev eiwa:~/backup/
    cd "${cur_dir}" || exit 1
}
alias backupdev=backup_dev

# Syncronize local "~/dev" data to server (eiwa) 
function sync_dev() {
    cur_dir=$(pwd)
    cd ~/dev || exit 1
    find . -name ".DS_Store" -delete
    cd ~ || exit 1
    rsync -ahvz --delete ~/dev eiwa:~/backup/
    cd "${cur_dir}" || exit 1
}
alias syncdev=sync_dev

# Back-up local "~/spaceshift" data to server (eiwa) 
function backup_ss() {
    cur_dir=$(pwd)
    cd ~/spaceshift || exit 1
    find . -name ".DS_Store" -delete
    cd ~ || exit 1
    rsync -ahvz ~/spaceshift eiwa:~/backup/
    cd "${cur_dir}" || exit 1
}
alias backupss=backup_ss

# Syncronize local "~/spaceshift" data to server (eiwa) 
function sync_ss() {
    cur_dir=$(pwd)
    cd ~/spaceshift || exit 1
    find . -name ".DS_Store" -delete
    cd ~ || exit 1
    rsync -ahvz --delete ~/spaceshift eiwa:~/backup/
    cd "${cur_dir}" || exit 1
}
alias syncss=sync_ss

# Back-up local "~/Desktop" data to server (eiwa) 
function backup_desktop() {
    cur_dir=$(pwd)
    cd ~/Desktop || exit 1
    find . -name ".DS_Store" -delete
    cd ~ || exit 1
    rsync -ahvz ~/Desktop eiwa:~/backup/
    cd "${cur_dir}" || exit 1
}
alias backupdesk=backup_desktop

# Syncronize local "~/Desktop" data to server (eiwa) 
function sync_desktop() {
    cur_dir=$(pwd)
    cd ~/Desktop || exit 1
    find . -name ".DS_Store" -delete
    cd ~ || exit 1
    rsync -ahvz --delete ~/Desktop eiwa:~/backup/
    cd "${cur_dir}" || exit 1
}
alias syncdesk=sync_desktop

# Back-up local dot-files to server (eiwa) 
function backup_dot_files() {
    cur_dir=$(pwd)
    cd ~ || exit 1
    rsync -ahvz ~/.aws eiwa:~/backup/dot-files/
    rsync -ahvz ~/.gitconfig eiwa:~/backup/dot-files/
    rsync -ahvz ~/.ssh eiwa:~/backup/dot-files/dot-files/
    rsync -ahvz ~/.vscode/argv.json eiwa:~/backup/dot-files/.vscode/
    rsync -ahvz ~/.zshrc eiwa:~/backup/dot-files/
    cd "${cur_dir}" || exit 1
}
alias backupdot=backup_dot_files

# Syncronize local dot-files to server (eiwa) 
function sync_dot_files() {
    cur_dir=$(pwd)
    cd ~ || exit 1
    rsync -ahvz ~/.aws eiwa:~/backup/dot-files/
    rsync -ahvz ~/.gitconfig eiwa:~/backup/dot-files/
    rsync -ahvz ~/.ssh eiwa:~/backup/dot-files/dot-files/
    rsync -ahvz ~/.vscode/argv.json eiwa:~/backup/dot-files/.vscode/
    rsync -ahvz ~/.zshrc eiwa:~/backup/dot-files/
    cd "${cur_dir}" || exit 1
}
alias syncdot=sync_dot_files


# =====================================
# ========== git on terminal ==========
# =====================================
# An function to display colored git branch name
function prompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # Return nothing if an directory is not tracking
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # When all files is commited
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # When there is a file not tracking by git
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # When there is a file not adding
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # When there is a file not commited
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # When an conflict is occured
    echo "%F{red}!(no branch)"
    return
  else
    # Other
    branch_status="%F{blue}"
  fi
  # Display colored git branch name
  echo "${branch_status}[$branch_name]"
}

# Evaluate and replacement prompt strings every time prompt is displayed
setopt prompt_subst

# Dipslay the function result right side of the prompt
RPROMPT='`prompt-git-current-branch`'


# ===============================
# ========== Terminal  ==========
# ===============================
# Display only path on prompt & start a new line after command execution
PS1=""$'\n'"%B%F{cyan}%~%f%b $ "

# Ignore dupulicate command history
setopt hist_ignore_dups

eval "$(starship init zsh)"
