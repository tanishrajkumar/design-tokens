#!/bin/bash

env:
    GH_TOKEN: ${{ github.token }}

# Set your GitHub username and email
GIT_USER_NAME="tanishrajkumar"
GIT_USER_EMAIL="tanishraj.k@bsfdv.com"

# Set your GitHub Personal Access Token
GH_PERSONAL_ACCESS_TOKEN="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"

# Set the new branch name and PR title
NEW_BRANCH_NAME="new-feature-branch"
PR_TITLE="New changes"

# Configure Git
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# Create a new branch
git checkout -b $NEW_BRANCH_NAME

# Add and commit changes
git add .
git commit -m "Add new changes"

# Set the remote URL using the access token
REPO_OWNER=$(git config --get remote.origin.url | sed -E 's/.*:([^/]+)\/.*/\1/')
REPO_NAME=$(git config --get remote.origin.url | sed -E 's/.*\/([^/]+)\.git/\1/')
echo "REPO_OWNDER = $REPO_OWNER"
echo "REPO_NAME = $REPO_NAME"
git remote set-url origin https://${GH_PERSONAL_ACCESS_TOKEN}@github.com/${REPO_OWNER}/${REPO_NAME}.git

# Push the new branch
git push origin $NEW_BRANCH_NAME

# Create a pull request using 'gh'
gh auth login --with-token <<< "${GH_PERSONAL_ACCESS_TOKEN}"
gh pr create --title "$PR_TITLE" --base main --head $NEW_BRANCH_NAME