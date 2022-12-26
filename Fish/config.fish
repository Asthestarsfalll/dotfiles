set CONDA_PATH /opt/miniconda3
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
export TERMINFO=/usr/share/terminfo

function fish_greeting
  set_color purple
  echo "As The Stars Fall"
end

function fish_title
  prompt_pwd
end
