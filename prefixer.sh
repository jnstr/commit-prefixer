#!/bin/bash

function getCommitType() {
    options=(
        "[+] Adding a file or feature"
        "[B] Fixing a bug"
        "[-] Removing code or files"
        "[M] Moving or renaming files"
        "[L] Fixing linter errors & warnings"
        "[R] Refactoring existing code"
        "[T] Adding or updating tests"
        "[!] Bad code that needs to be improved"
    )

    select commitType in "${options[@]}"; do
        if [ -z "$commitType" ]; then
            echo $commitType
        else
            ## extract the prefix (the part before the first whitespace)
            echo $commitType | sed 's/\s.*$//'
        fi
        break
    done
}

function extractJiraStoryFromBranch() {
    branchName=$(git rev-parse --abbrev-ref HEAD)

    # remove everything before last slash
    bareBranchName=${branchName##*/}

    jiraStory=$(echo "${bareBranchName}" | grep -o "^[^-]*-\?[^-]*" | grep -oP "([a-zA-Z0-9]{2,5})(-)([0-9]+[0-9]+)")

    ## uppercase
    jiraStory=$(echo ${jiraStory^^})

    echo $jiraStory
}

function createPrefix() {
    commitType=$(getCommitType)
    jiraStory=$(extractJiraStoryFromBranch)

    prefixItems=()
    if [ ! -z "$commitType" ]; then
        prefixItems+=($commitType)
    fi
    if [ ! -z "$jiraStory" ]; then
        prefixItems+=("[${jiraStory}]")
    fi

    ## join the array items
    commitPrefix=$(printf "%s" "${prefixItems[@]}")

    echo $commitPrefix
}

function gitCommit() {
    ## tip: add this file to your global gitignore file
    commitFile="./.commit-template"

    touch $commitFile
    echo $1 > $commitFile
    git commit --verbose --template=$commitFile
    rm -f $commitFile
}

echo "Please enter your commit type: "

gitCommit $(createPrefix)
