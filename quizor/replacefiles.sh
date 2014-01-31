#!/bin/sh

prefix="/volumes/templar/stash/quizor"

for user in `cat .users`
do
    for sub in `cat fixfiles`
    do
        if [ -f ${prefix}/${user}/${sub} ]; then
            cp ${prefix}/materials/${sub} ${prefix}/${user}/${sub}
	fi
    done
done
