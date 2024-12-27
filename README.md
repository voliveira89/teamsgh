# Assign team to GitHub repositories

Shell script to assign a GitHub team to a list of repositories using the GitHub REST API.

## Before running the script, ensure you have the following:
1. A Personal Access Token (PAT) with the necessary permissions (e.g., repo and read:org or write:org).
2. A text file (e.g., repos.txt) with one repository name per line in the format owner/repo.
3. The team slug of the GitHub team to assign (you can find this in your organization’s settings under the team name).

## Steps to Run
1. Replace your_personal_access_token, your_organization_name, and your_team_slug with your actual values in the script.
2. Create a file named repos.txt in the same directory as the script and populate it with repository names, one per line (e.g., org/repo1, org/repo2).
3. Save the script as assign_team.sh and make it executable: 

    ```chmod +x assign_team.sh```
4. Run the script: 

    ```./assign_team.sh```
