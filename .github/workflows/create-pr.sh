#!/bin/bash

# Set the new branch name and PR title
NEW_FEATURE_BRANCH="new-feature-branch"
PR_TITLE=${GH_PR_TITLE}
PR_BODY="Figma tokens has been updated"

# Configure Git
git config --global user.name "${GH_USER_NAME}"
git config --global user.email "${GH_USER_EMAIL}"

# Create a new branch
git checkout -b $NEW_FEATURE_BRANCH

# Add and commit changes
git add .
git commit -m "Add new changes"

# Set the remote URL using the access token
git remote set-url origin https://${GH_TOKEN}@github.com/tanishrajkumar/design-tokens/

# Push the new branch
git push -f origin $NEW_FEATURE_BRANCH

# Create a pull request using 'gh'
gh auth login --with-token <<< "${GH_TOKEN}"
gh pr create --title "$PR_TITLE" --body "$PR_BODY" --base main --head $NEW_FEATURE_BRANCH

# merge the pull request
PR_NUMBER=$(gh pr list --state open --base main --head "$(git symbolic-ref --short HEAD)" --json number -q '.[0].number')
echo "Pull request number: $PR_NUMBER"
gh pr merge $PR_NUMBER --squash -d

