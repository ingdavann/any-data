#!/bin/bash

# Define variables
COMMIT_MESSAGE=${1:-"Auto-commit: $(date)"}
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Check if inside a git repo
if [ ! -d .git ]; then
  echo "❌ Not inside a Git repository."
  exit 1
fi

# Stage all changes
git add .

# Commit with message (skip if no changes)
if git diff --cached --quiet; then
  echo "⚠️ No changes to commit."
else
  git commit -m "$COMMIT_MESSAGE"
fi

# Push to all configured remotes
for remote in $(git remote); do
  echo "🚀 Pushing to '$remote' on branch '$BRANCH'..."
  git push "$remote" "$BRANCH"
done

echo "✅ Push completed to all remotes!"