1. Open `todo.md` and select the first unchecked items to work on.
2. Open `plan.md` and review the corresponding plan to the todo item you're working on for guidance on how to complete the todo item
3. Carefully plan each item, then post your plan as a comment on GitHub issue #X.
4. Create a new branch and implement your plan:
    - Write robust, well-documented code.
    - Include comprehensive tests and debug logging.
5. Run all CI checks and fix anything that's broken with the following steps
    - Run all checks in CI related to testing for all services and languages in the repo (unit tests, integration tests etc.)
    - Fix all failing tests
    - Then run all typechecks defined in CI for all services and languages in the repo
    - Fix all typing issues
    - Then run all linting/formatting checks defined in CI for all services and languages in the repo. Include all testing code when checking for linting/formatting checks.
    - Fix all linting/formatting issues
6. Simplify the code using the code-simplifier plugin
7. Commit your changes and open a pull request referencing the issue.
8. Check off the items on todo.md
9. Review and consider updates for all documentation you're aware of, but definitely review CLAUDE.md and README.md
