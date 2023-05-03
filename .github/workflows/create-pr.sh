#!/bin/bash

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
git remote set-url origin https://${GH_PERSONAL_ACCESS_TOKEN}@github.com/$(git config --get remote.origin.url | sed 's/.*@\(.*\)/\1/')

# Push the new branch
git push origin $NEW_BRANCH_NAME

# Create a pull request using 'hub'
hub pull-request -m "$PR_TITLE" -b main -h $NEW_BRANCH_NAME