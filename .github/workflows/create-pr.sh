#!/bin/bash

# Set your GitHub username and email
GIT_USER_NAME="tanishrajkumar"
GIT_USER_EMAIL="tanishraj.k@bsfdv.com"

# Set the new branch name and PR title
NEW_BRANCH_NAME="new-feature-branch"
PR_TITLE="New changes"
PR_BODY="Figma tokens has been updated"

# Configure Git
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# Create a new branch
git checkout -b $NEW_BRANCH_NAME

# Add and commit changes
git add .
git commit -m "Add new changes"

# # Set the remote URL using the access token
# echo "=========== https://${GH_TOKEN}@github.com/"
# git remote set-url origin https://${GH_TOKEN}@github.com/tanishrajkumar/design-tokens/

# # Push the new branch
REPO_URL=$(git config --get remote.origin.url)
REPO_URL_WITH_TOKEN=${REPO_URL/https:\/\//https://${GH_TOKEN}@}
git push $REPO_URL_WITH_TOKEN $NEW_BRANCH_NAME

# # Create a pull request using 'gh'
# gh auth login --with-token <<< "${GH_TOKEN}"
# gh pr create --title "$PR_TITLE" --body "$PR_BODY" --base main --head $NEW_BRANCH_NAME