#!/bin/sh

git pull origin scs_dotfiles
while read f; do
    echo "Backup file $f..."
    cp -rf $HOME/$f ./
done < Dotfiles
echo "Backup files done, please commit!"

git add . -A
git commit -m "Backup at $(date)"
git push origin scs_dotfiles