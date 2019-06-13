#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

FILES=`git -C "$DIR" ls-files`

for f in $FILES
do
  if [ -f "$HOME/$f" ]; then
    cp --force -T "$HOME/$f" "$DIR/$f";
  fi
done

git -C "$DIR" add -i . && git -C "$DIR" commit
