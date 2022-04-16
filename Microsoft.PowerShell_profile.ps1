Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme atomic
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Alias
Set-Alias -Name vim -Value nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias nio -Value "ni --prefer-offline"
Set-Alias s -Value "nr start"
Set-Alias d -Value "nr dev"
Set-Alias b -Value "nr build"
Set-Alias bw -Value "nr build --watch"
Set-Alias t -Value "nr test"
Set-Alias tu -Value "nr test -u"
Set-Alias tw -Value "nr test --watch"
Set-Alias w -Value "nr watch"
Set-Alias p -Value "nr play"
Set-Alias c -Value "nr typecheck"
Set-Alias lint -Value "nr lint"
Set-Alias lintf -Value "nr lint --fix"
Set-Alias release -Value "nr release"
Set-Alias re -Value "nr release"


# -------------------------------- #
# Git
# -------------------------------- #

# Use github/hub
Set-Alias git hub

# Go to project root
Function grt {cd "$(git rev-parse --show-toplevel)"}

Function gs {git status}
Function gp {git push}
Function gpf {git push --force}
Function gpft {git push --follow-tags}
Function gpl {git pull --rebase}
Function gcl {git clone}
Function gst {git stash}
Function grm {git rm}
Function gmv {git mv}

Function main {git checkout main}

Function gco {git checkout}
Function gcob {git checkout -b}

Function gb {git branch}
Function gbd {git branch -d}

Function grb {git rebase}
Function grbom {git rebase origin/master}
Function grbc {git rebase --continue}

Function gl {git log}
Function glo {git log --oneline --graph}

Function grh {git reset HEAD}
Function grh1 {git reset HEAD~1}

Function ga {git add}
Function gA {git add -A}

Function gc {git commit}
Function gcm {git commit -m}
Function gca {git commit -a}
Function gcam {git add -A && git commit -m}
Function gfrb {git fetch origin && git rebase origin/master}

Function gxn {git clean -dn}
Function gx {git clean -df}

Function gsha {git rev-parse HEAD | pbcopy}

Function ghci {gh run list -L 1}


# -------------------------------- #
# Directories
#
# I put
# `~/z` for my projects
# `~/f` for forks
# `~/r` for reproductions
# -------------------------------- #

function z($project) {
  cd ~/z/$project
}

# function repros() {
#   cd ~/r/$1
# }

function forks($fork) {
  cd ~/f/$fork
}

# function pr() {
#   if [ $1 = "ls" ]; then
#     gh pr list
#   else
#     gh pr checkout $1
#   fi
# }

function dir($1) {
  mkdir $1 && cd $1
}

# function clone() {
#   if [[ -z $2 ]] then
#     hub clone "$@" && cd "$(basename "$1" .git)"
#   else
#     hub clone "$@" && cd "$2"
#   fi
# }

# Clone to ~/z and cd to it
# function clonez() {
#   z && clone "$@" && code . && cd ~2
# }

# function cloner() {
#   repros && clone "$@" && code . && cd ~2
# }

# function clonef() {
#   forks && clone "$@" && code . && cd ~2
# }

function codez() {
  z && code "$@" && cd -
}

# function serve() {
#   if [[ -z $1 ]] then
#     live-server dist
#   else
#     live-server $1
#   fi
# }
