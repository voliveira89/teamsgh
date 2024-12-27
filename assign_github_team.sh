#!/bin/bash

# GitHub API settings
GITHUB_TOKEN="your_personal_access_token"  # Replace with your GitHub PAT
ORG="your_organization_name"              # Replace with your GitHub organization name
TEAM_SLUG="your_team_slug"                # Replace with the slug of the team to assign
INPUT_FILE="repos.txt"                    # File containing the list of repositories

# GitHub API base URL
API_URL="https://api.github.com"

echo "Reading file: $INPUT_FILE"
cat "$INPUT_FILE"

# Function to assign the team to a repository
assign_team_to_repo() {
  local repo=$1
  echo "Assigning team to repository: $repo"

  response=$(curl -s -o /dev/null -w "%{http_code}" \
    -X PUT \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    "$API_URL/orgs/$ORG/teams/$TEAM_SLUG/repos/$repo" \
    -d '{"permission": "push"}')

  if [ "$response" -eq 204 ]; then
    echo "Successfully assigned team '$TEAM_SLUG' to repository '$repo'."
  else
    echo "Failed to assign team '$TEAM_SLUG' to repository '$repo'. HTTP status: $response"
  fi
}

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: File '$INPUT_FILE' not found!"
  exit 1
fi

# Read the input file and process each repository
echo "Reading repositories from $INPUT_FILE..."
while IFS= read -r repo; do
  echo "Processing line: '$repo'"
  if [ -n "$repo" ]; then
    assign_team_to_repo "$repo"
  fi
done < "$INPUT_FILE"
