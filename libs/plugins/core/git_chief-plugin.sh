#!/usr/bin/env bash

# Chief Plugin File: git_chief-plugin.sh
# Author: Randy E. Oyarzabal
# ver. 1.0
# Functions and aliases that are development to Git.

alias chief.git_url='git config --get remote.origin.url'

function chief.git_clone() {
    local USAGE="Usage: $FUNCNAME <repo URL>

Modified version of git clone that also grabs submodules automatically."

    if [[ $1 == "-?" ]]; then
        echo "${USAGE}"
        return;
    fi

    git clone --recurse-submodules --remote-submodules "$1"
}

function chief.git_update() {
    local USAGE="Usage: $FUNCNAME

Perform a pull and push to update local (and submodules) with remote/server origin."

    if [[ $1 == "-?" ]]; then
        echo "${USAGE}"
        return;
    fi

    git config --get remote.origin.url
    git pull;
    git push;
}

function chief.git_commit {
    local USAGE="Usage: $FUNCNAME <commit message>

Commit (if necessary) any changes to Git and apply message."

    if [[ -z $1 ]] || [[ $1 == "-?" ]]; then
        echo "${USAGE}"
        return;
    fi

    git config --get remote.origin.url
    git pull;
    git add .;
    if [[ -z $1 ]]; then
        git commit -a;
    else
        git commit -a -m "$1";
    fi
    git push;
}

function chief.git_reset-local() {
    local USAGE="Usage: $FUNCNAME

Reset local branch repo to match latest server version."

    if [[ $1 == "-?" ]]; then
        echo "${USAGE}"
        return;
    fi

    git config --get remote.origin.url
    git reset --hard
}

function chief.git_untrack() {
    local USAGE="Usage: $FUNCNAME <file>

Untrack a file from being versioned in Git."

    if [[ -z $1 ]] || [[ $1 == "-?" ]]; then
        echo "${USAGE}"
        return;
    fi

    git config --get remote.origin.url
    git update-index --no-assume-unchanged $1
    git rm -r --cached $1
}

function chief.git_legend {
    local USAGE="Usage: $FUNCNAME

Display character legend for git prompt."
    echo "Git Prompt Legend:"
    echo "  '*' = unstaged changes"
    echo "  '+' = staged changes"
    echo "  '$' = stashed changes"
    echo "  '%' = untracked changes"
}