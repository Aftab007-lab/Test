#!/bin/bash
##############################
## author: Aftab
## Date: 21-08-2025
## This script is to check how all have the access for repo
##############################

set -e #to stop the script when there is any error.

# Git API URL 
APT_URL = "https:\\api.github.com"

# GitHub username and token access
USERNAME= $username
TOKEN= $token

# User and repository information
REPO_OWNER = $1
REPO_NAME = $2

# Fuction to make a get request to the GitHub API
function github_get_api {
    local endpoint= $1
    local url= "${API_URL}/${endpoint}"

    #Send a Get request to the github api with authentication
    curl -s -u "${USERNAME}:/${Token}" "$url"
}

# Function to list user with read access to the repository.
function list_user_with_read_access {
    local endpoint= "repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository.
    "$(github_get_api "endpoint" | jq -r '.[] | select(.permissions.pull == ture) | .login')"

    # Display the list of collaborator with read access.
    if [[ -z "$collaborators" ]] then
        echo "No user with read only access found $REPO_OWNER $REPO_NAME"
    else 
        echo "User with read access to $REPO_OWNER $REPO_NAME | $collaborators"

}
