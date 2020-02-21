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

echo $(getCommitType)
echo $(extractJiraStoryFromBranch)