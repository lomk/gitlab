#!/bin/bash

BRANCH_NAME="$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)"
COMMIT_ID="$(git rev-parse HEAD)"

echo "Working in directory `pwd`"
echo "Checking for local changes"
echo ""

if [[ `git status --porcelain --untracked-files=no` ]]; then
        echo "There are some changes was finded. We need to reset it for updating local repository"
        echo "Reseting local changes"
        git reset --hard
        echo ""
else
        echo "There are no local changes"
        echo ""
fi

echo "trying to update local repository from origin origin $BRANCH_NAME"

git pull origin master
NEW_ID="$(git rev-parse HEAD)"

if [[ "$COMMIT_ID" == "$NEW_ID" ]]
then
    echo ""
    EXITCODE="1"
else
    echo "Updated sucsessfully"
    echo "Saving previos commit id to file .lastcommitid"
    echo $COMMIT_ID > .lastcommitid
    echo ""
    EXITCODE="0"
fi

exit $EXITCODE
