#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

TREE=`git -C "$DIR" ls-tree -rd --name-only HEAD`

for d in $TREE
do
  if [ ! -d "$HOME/$d" ]; then
    mkdir -p "$HOME/$d"
  fi
done

FILES=`git -C "$DIR" ls-files`

for f in $FILES
do
  if [ ! -e "$HOME/$f" -a "$f" != "deploy.sh" -a "$f" != "import.sh" ]; then
    cp "$DIR/$f" "$HOME/$f"
    echo  "Deploy \"$HOME/$f\""
  fi
done
