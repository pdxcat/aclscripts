#!/bin/sh

if [ $# != 2 ] ; then
    echo "Usage: $0 <username> <classname>"
    exit;
fi

stash="/volumes/templar/stash/quizor"
username="$1"
class="$2"

if [ -d "${stash}/${username}/${class}" ] ; then
    echo "$class directory already exists for $1"
    exit
fi

if [ \! -d "${stash}/materials/${class}" ] ; then
    echo "No materials for $class"
    exit
fi

if [ \! -d "${stash}/${username}" ] ; then
    echo "No such user $username"
    exit
fi

mkdir "${stash}/${username}/${class}"
cp -r "${stash}/materials/$class/." "${stash}/${username}/${class}/."
chown -R ${username}:them "${stash}/${username}/${class}"

ACL='
     owner@:rwxpdDa-R-c--s:fd----:allow,
      group:quizadm:rwxpdDa-R-c--s:fd----:allow,
  everyone@:------a-------:fd----:allow
';

ACL=`echo $ACL | tr -d ' ' | tr -d '\n'`

chmod -R A=$ACL "${stash}/${username}/${class}"

echo "materials copied for ${class} to ${username}"
