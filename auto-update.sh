#!/bin/bash

copy_if_exists() {
  if [ -e "$1" ]; then
    cp "$1" "$2"
  else
    echo "File $1 does not exist."
  fi
}

mkdir -p ./.config/

copy_if_exists ~/.tmux.conf .
copy_if_exists ~/.tmux-cht-command
copy_if_exists ~/.tmux-cht-languages
copy_if_exists ~/.zsh_profile .
copy_if_exists ~/.zshrc .
copy_if_exists ~/.zshrc.pre-oh-my-zsh .

copy_if_exists ~/.config/i3 ./.config/
copy_if_exists ~/.config/i3status ./.config/
copy_if_exists ~/.config/kitty ./.config/
copy_if_exists ~/.config/personal ./.config/
copy_if_exists ~/.config/scripts ./.config/
copy_if_exists ~/.config/picom.conf ./.config/

cd "$(dirname "$0")"

if [ ! -d .git ]; then
    echo "This is not a Git repository."
    exit 1
fi

git add -A

COMMIT_MESSAGE="Update dotfiles $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$COMMIT_MESSAGE"

git push origin master
