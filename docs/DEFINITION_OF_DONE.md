# Definition of Done (DoD)

This checklist defines what must be completed before a task, feature, bug fix, or pull request is considered done.

The goal is to keep the Roblox project stable, reviewable, and easy for the whole team to work on.

---

## Before Starting Work

- [ ] I pulled the latest changes from `main`.
- [ ] I created a new branch from `main`.
- [ ] My branch name clearly describes the work.

Example branch names:

```text
feature/jump-pad-service
feature/currency-system
bugfix/leaderboard-score-bug
refactor/teleport-module
```

---

## During Development

- [ ] I made changes in the correct project folders.
- [ ] I followed the agreed project structure.
- [ ] I kept scripts organized in the correct client, server, or shared location.
- [ ] I used clear and meaningful names for files, variables, functions, and modules.
- [ ] I avoided adding unnecessary or duplicate code.
- [ ] I committed regularly with clear commit messages.
- [ ] I kept commits focused on the current task.

Good commit examples:

```text
Add jump pad service
Fix leaderboard score sorting
Create currency reward module
Refactor teleport destination config
```

---

## Code Quality

- [ ] I ran the project formatting and quality checks.

```powershell
.\check-quality.ps1
```

- [ ] Formatting passes successfully.
- [ ] Linter checks pass successfully.
- [ ] Any issues reported by the tools were fixed or intentionally discussed with the team.
- [ ] I did not leave unused variables, unused functions, or dead code.
- [ ] I removed unnecessary comments.
- [ ] I removed temporary code.
- [ ] I removed debug-only prints unless they are intentionally needed.

Examples of things that should usually be removed before opening a PR:

```lua
print("test")
print("here")
warn("debug")
-- TODO: fix this later
-- temporary hack
```

If a `TODO` is still needed, it should be clear, useful, and preferably linked to a future task.

---

## Testing

- [ ] I tested the change locally.
- [ ] I tested the change in Roblox Studio when relevant.
- [ ] I confirmed the feature works in the expected normal case.
- [ ] I tested important edge cases.
- [ ] I checked that the change does not break existing behavior.
- [ ] I added or updated tests when the change affects reusable logic.
- [ ] I ran the test suite if tests exist for this area.

Examples of systems that should usually have tests:

- Currency calculations
- Score calculations
- Reward logic
- Leaderboard sorting
- Minigame registration
- Teleport destination validation
- Player data validation

If tests were not added, the PR should explain why.

---

## Roblox Studio Validation

- [ ] I connected the project with Rojo successfully.
- [ ] I opened the place in Roblox Studio.
- [ ] I confirmed there are no obvious runtime errors in the Output window.
- [ ] I tested the feature as a player when relevant.
- [ ] I tested server/client behavior when relevant.
- [ ] I checked that new objects, scripts, remotes, and folders appear in the expected locations.

For gameplay features, also check:

- [ ] The feature works after restarting Play mode.
- [ ] The feature works for more than one player if multiplayer behavior is involved.
- [ ] The feature handles missing or invalid data safely.

---

## Documentation

- [ ] I updated the README if setup, commands, or workflow changed.
- [ ] I documented any new important module, service, or system.
- [ ] I added comments only where they explain non-obvious logic.
- [ ] I avoided comments that only repeat what the code already says.

---

## Before Opening a Pull Request

- [ ] I pulled/rebased/merged the latest `main` into my branch.
- [ ] I resolved merge conflicts if there were any.
- [ ] I ran the quality checks again after resolving conflicts.
- [ ] I tested the final version after resolving conflicts.
- [ ] I reviewed my own changes before pushing.
- [ ] I checked `git diff` to make sure only intended files changed.
- [ ] I pushed my branch to GitHub.

Useful commands:

```powershell
git status
git diff
git add .
git commit -m "Describe the change"
git push
```

---

## Pull Request Requirements

- [ ] I created a pull request targeting `main`.
- [ ] The PR title clearly describes the change.
- [ ] The PR description explains what changed and why.
- [ ] I added screenshots or videos if the change affects gameplay, UI, or visuals.
- [ ] I described how I tested the change.
- [ ] I requested reviewers.
- [ ] I responded to reviewer comments.
- [ ] I made requested changes or explained why a change was not needed.
- [ ] I did not merge the PR until approval was received.

---

## Pull Request Description Template

Use this structure when opening a PR:

```markdown
## What changed?

-

## Why was this change needed?

-

## How was it tested?

-

## Screenshots / Videos

-

## Checklist

- [ ] I branched from the latest `main`
- [ ] I ran `./check-quality.ps1`
- [ ] I tested the change locally
- [ ] I tested in Roblox Studio where relevant
- [ ] I removed debug code and temporary prints
- [ ] I updated documentation if needed
- [ ] I requested reviewers
```

---

## Done Means

A task is considered done only when:

- [ ] The code is committed and pushed.
- [ ] The pull request is open against `main`.
- [ ] Quality checks pass.
- [ ] The change was tested.
- [ ] Debug code was removed.
- [ ] Documentation was updated if needed.
- [ ] Reviewers were requested.
- [ ] Review feedback was handled.
- [ ] The pull request was approved.
- [ ] The pull request was merged into `main`.

---

## Not Done Means

A task is not done if:

- Code only exists locally.
- Code only exists in Roblox Studio and was not committed.
- The branch was not pushed.
- The pull request was not created.
- Quality checks were not run.
- The feature was not tested.
- Debug prints or temporary code are still present.
- Reviewers were not added.
- The PR has unresolved comments.
- The PR has not been merged into `main`.

---

## Team Rule

If it is not committed, pushed, reviewed, tested, and merged, it is not done.
