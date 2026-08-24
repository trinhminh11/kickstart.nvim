#!/bin/bash
set -e

# Verify that at least the repository link is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <repo-link-or-path> [commit-id]"
    exit 1
fi

INPUT_URL=$1
COMMIT_ID=$2

# Format the URL based on your constraints
if [[ "$INPUT_URL" == https://github.com* ]]; then
    REPO_URL="$INPUT_URL"
elif [[ "$INPUT_URL" == github.com* ]]; then
    REPO_URL="https://$INPUT_URL"
else
    # Removes leading slash if present to avoid double slashes
    CLEAN_PATH=$(echo "$INPUT_URL" | sed 's|^/||')
    REPO_URL="https://github.com/$CLEAN_PATH"
fi

echo "Formatted URL: $REPO_URL"

# Extract directory name
REPO_NAME=$(basename -s .git "$REPO_URL")

# Initialize directory
mkdir -p "$REPO_NAME"
cd "$REPO_NAME"
git init
git remote add origin "$REPO_URL"

# Handle optional or empty commit_id
if [ -z "$COMMIT_ID" ]; then
    echo "No commit ID specified. Fetching the latest commit..."
    # Query the default remote branch name (e.g., main or master)
    DEFAULT_BRANCH=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
    # Fallback default if git remote show fails or isn't accessible
    DEFAULT_BRANCH=${DEFAULT_BRANCH:-HEAD}
    git fetch --depth 1 origin "$DEFAULT_BRANCH"
    git checkout FETCH_HEAD
    echo "Success! Latest commit from '$DEFAULT_BRANCH' cloned into ./$REPO_NAME"
else
    echo "Fetching specific commit: $COMMIT_ID..."
    git fetch --depth 1 origin "$COMMIT_ID"
    git checkout FETCH_HEAD
    echo "Success! Exact commit $COMMIT_ID cloned into ./$REPO_NAME"
fi

