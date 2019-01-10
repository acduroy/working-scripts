#! /bin/bash

# Program Name	: add-file-to-github.sh
# Purpose	: to automate in adding file to your github account at the command line
# Usage		: ./add-file-to-github.sh <file-to-add>
# Build Date	: 1-10-2019

# usage function
usage(){
  echo "The script needs what folder to store the file to be added"
  echo "Pls rerun the script again using this format --> ./add-file-to-github.sh <folder-at-github>"
  read -p "Press [enter-key] to continue, thanks ..."
  exit 1
} 

# check number of arguments supplied by end-user
[ $# -eq 0 ]] && usage

# Steps to add a file to your github account:
# 1. On your computer, move the file you'd like to upload to GitHub into the local directory that
#    was created when you cloned the repository
# 2. Open Git Bash
# 3. Change the current working directory to your local repository
# 4. Stage the file for commit to your local repository

# Adds the file to your local repository and stage it for commit
# To unstage a file, use 'git reset HEAD <YOUR-FILE>'
git add .

# 5. Commit the file that you've staged in your local repository.

# Commits the tracked changes and prepares them to be pushed to a remote repository. To remove this 
# commit and modify the file, use 'git reset --soft HEAD-1" and commit and add the file again.
git commit -m "Add existing file"

# 6. Push the changes in your local repository to GitHub.

# Pushes the changes in your local repository up to the remote repository you specified as the origin
echo "Pls. enter the folder you want the file to be stored in your gisthub account [ex. working-scripts]: "; read YOUR-BRANCH
git push origin $YOUR-BRANCH

echo "adding file to github is completed, thanks ..."
