#!/bin/bash

# This script:
# 1) Copies dotfiles from user's homedir to user's quizor homedir
# 2) Copies quiz materials from stash to user's quizor homedir

### Change these: ####
HOME_PREFIX=''
QUIZ_PREFIX='/volumes/templar/stash/quizor'
QUIZ_MATERIALS='/volumes/templar/stash/quizor/quizmaterials'
######################

if [ $# != 2 ]; then
  echo "Usage: $0 USER CLASS"
  exit 1
fi

USER=$1
CLASS=$2

if [ ! -d $QUIZ_PREFIX/$USER/quizmaterials/$CLASS ]; then
    echo "Quiz directory for $CLASS already exists for $USER"
    exit 1
fi    

if [ ! -d $QUIZ_MATERIALS/$CLASS ]; then
    echo "Class directory $CLASS does not exist."
    exit 1
fi

if [ ! -d $HOME_PREFIX/$USER ]; then
    echo "User $USER's home directory does not exist."
    exit 1
fi

if [ ! -d $QUIZ_PREFIX/$USER ]; then
    echo "User $USER's quizor directory does not exist."
    exit 1
fi

for dot in ".vimrc" ".emacs"; do
  if [ -e $HOME_PREFIX/$USER/$dot ]; then
      echo "Copying $HOME_PREFIX/$USER/$dot to $QUIZ_PREFIX/$USER/$dot..."
      cp $HOME_PREFIX/$USER/$dot $QUIZ_PREFIX/$USER/$dot
  fi
done

echo "Copying $QUIZ_MATERIALS/$CLASS to $QUIZ_PREFIX/$USER/quizmaterials/$CLASS..."

mkdir $QUIZ_PREFIX/$USER/quizmaterials/$CLASS
cp -r $QUIZ_MATERIALS/$CLASS/. $QUIZ_PREFIX/$USER/quizmaterials/$CLASS/.
chown -R $USER:them $QUIZ_PREFIX/$USER/quizmaterials/$CLASS

ACL='
     owner@:rwxpdDa-R-c--s:fd----:allow,
      group:quizadm:rwxpdDa-R-c--s:fd----:allow,
  everyone@:------a-------:fd----:allow
';

ACL=`echo $ACL | tr -d ' ' | tr -d '\n'`

chmod -R A=$ACL "$QUIZ_PREFIX/$USER/quizmaterials/$CLASS"


