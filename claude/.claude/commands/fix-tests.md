Run all CI checks and fix anything that's broken with the following steps:
- First, run all checks in CI related to testing for all services and languages in the repo (unit tests, integration tests etc.)
- Fix all failing tests
- Then run all typechecks defined in CI for all services and languages in the repo
- Fix all typing issues
- Then run all linting/formatting checks defined in CI for all services and languages in the repo. Include all testing code when checking for linting/formatting checks.
- Fix all linting/formatting issues

Make sure to do it in that order.
