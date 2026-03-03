Create a pull request in GitHub with the changes we've worked on so far.

- If you're not already in a git branch for these changes, create a new branch
- Run all checks in CI related to testing for all services and languages in the repo (unit tests, integration tests etc.)
- Fix all failing tests
- Then run all typechecks defined in CI for all services and languages in the repo
- Fix all typing issues
- Then run all linting/formatting checks defined in CI for all services and languages in the repo. Include all testing code when checking for linting/formatting checks.
- Fix all linting/formatting issues
- Then, create logically chunked commits for the changes
- Create a PR for the branch in GitHub
- For both commit and PR descriptions, do not reference the fact that these changes were created using Claude or AI
