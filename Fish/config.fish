set CONDA_PATH /opt/miniconda3
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
export TERMINFO=/usr/share/terminfo

function fish_greeting
  echo "As The Stars Fall" | figlet | lolcat
end

function fish_title
  prompt_pwd
end


# set alias

# set git alias
alias gal 'git add --all'
alias gst 'git status'
alias gcommit 'git commit -m'
alias gamend 'git commit --amend'
alias gpf 'git push -f'
alias gpull 'git pull'
alias gpush 'git push'
alias gmerge 'git merge'
alias grebase 'git rebase'
alias grc 'git rebase --continue'
alias gri 'git rebase -i'
alias gnew 'git checkout -b'
alias gswich 'git checkout'
alias gbranch 'git branch'

# set system alias

alias coreUpdate 'sudo pacman -Syyu'
alias cleanOrphan 'sudo pacman -Rscn $(pacman -Qdtq)'
alias cleanCache 'sudo pacman -Scc'
alias checkInstall 'sudo pacman -Q'
alias Search 'sudo pacman -Ss'
alias Install 'sudo pacman -S'
alias baibai 'sudo pacman -R'

alias SystemCache 'du -sh ~/.cache/* | sort -h'
alias autoClean 'find ~/.cache/ -type f -atime +100 -delete'
alias makeGrub 'sudo grub-mkconfig -o /boot/grub/grub.cfg'

alias setWallpaper 'feh --randomize --bg-fill'
