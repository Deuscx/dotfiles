Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme atomic
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# https://github.com/antfu/ni/issues/21 
# Remove-Alias 
Remove-Alias -Name ni -Force
Remove-Alias -Name gcm -Force
Remove-Alias -Name gp -Force
Remove-Alias -Name gc -Force
# Alias
Set-Alias -Name vim -Value nvim
Set-Alias ll ls
Set-Alias g git
Function nio{ni --prefer-offline} 
Function s{nr start} 
Function d{nr dev $args} 
Function b{nr build $args} 
Function bw{nr build --watch} 
Function t{nr test $args} 
Function tu{nr test -u} 
Function tw{nr test --watch} 
Function w{nr watch $args} 
Function p{nr play $args} 
Function c{nr typecheck $args} 
Function lint{nr lint} 
Function lintf{nr lint --fix} 
Function release{nr release $args} 
Function re{nr release $args} 


# -------------------------------- #
# Git
# https://github.com/cli/cli
# -------------------------------- #

# Use github/hub
Set-Alias git hub

# Go to project root
Function grt {cd "$(git rev-parse --show-toplevel)"}

Function gs {git status $args}
Function gp {git push $args}
Function gpf {git push --force}
Function gpft {git push --follow-tags}
Function gpl {git pull --rebase}
Function gcl {git clone $args}
Function gst {git stash $args}
Function grm {git rm}
Function gmv {git mv}

Function main {git checkout main}

Function gco {git checkout $args}
Function gcob {git checkout -b $args}

Function gb {git branch $args}
Function gbd {git branch -d $args}

Function grb {git rebase $args}
Function grbom {git rebase origin/master}
Function grbc {git rebase --continue}

Function gl {git log $args}
Function glo {git log --oneline --graph}

Function grh {git reset HEAD}
Function grh1 {git reset HEAD~1}

Function ga {git add $args}
Function gA {git add -A}

Function gc {git commit $args}
Function gcm {git commit -m $args}
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
  cd D:/z/$project
}

function repros($repro) {
  cd D:/r/$repro
}

function forks($fork) {
  cd D:/f/$fork
}

# function pr() {
#   if [ $1 = "ls" ]; then
#     gh pr list
#   else
#     gh pr checkout $1
#   fi
# }

function ndir($1) {
  mkdir $1 && cd $1
}

# https://docs.microsoft.com/zh-cn/powershell/scripting/learn/deep-dives/everything-about-if
function clone() {
  $repo = $args[0]
  $rename = $args[1]
  if ( $rename -eq $null){
    $basename =  [System.IO.Path]::GetFileNameWithoutExtension($repo)
    git clone $args && cd $basename
  }else {
    git clone $args && cd $rename
  }
}

# Clone to ~/z and cd to it
function clonez() {
  z && clone($args) && code .
}

function cloner() {
  repros && clone $args && code . 
}

function clonef() {
  forks && clone $args && code . 
}

function codez() {
  z && code $args && cd -
}

# function serve() {
#   if [[ -z $1 ]] then
#     live-server dist
#   else
#     live-server $1
#   fi
# }
