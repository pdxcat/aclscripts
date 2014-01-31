#!/bin/sh

stash="/volumes/templar/stash/quizor"
username="$1"

ACL='
     owner@:rwxpdDa-R-c--s:fd----:allow,
      group:quizadm:rwxpdDa-R-c--s:fd----:allow,
  everyone@:------a-------:fd----:allow
';

ACL=`echo $ACL | tr -d ' ' | tr -d '\n'`

chmod -R A=$ACL "${stash}/${username}"
chmod -R A=$ACL "${stash}/submit/${username}"
chmod -R A=$ACL "${stash}/quiz/${username}"



