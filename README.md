# Roblox + Rojo Collaborator Onboarding Guide

> **Important:** This project uses a **hybrid workflow**.
>
> - **Roblox Studio / Roblox cloud experience** stores the actual place: map, parts, terrain, lighting, manually placed objects, attributes, UI layout, and Team Create changes.
> - **VS Code + Rojo + GitHub** stores the code: server scripts, client scripts, shared modules, config, and toolchain files.
>
> Do **not** build a new `.rbxl` file as your normal startup flow. Open the real Roblox experience in Studio, then connect Rojo to sync the code into that place.

---

## 1. What you need before starting

Ask the project owner to give you:

- Access to the **Roblox experience** or the **Roblox group** that owns it.
- Access to the **GitHub repository**.
- Permission to use **Team Create**, if the project uses it.
- The correct Roblox experience/place name, for example: `Gebo Fighting Test`.
- The correct Git branch to work from, usually `main` or `develop`.

Install these locally:

- Roblox Studio
- VS Code
- Git
- Rokit
- Rojo Studio plugin

Optional but useful:

- GitHub Desktop, if you do not want to use Git from terminal.
- Roblox LSP / Luau VS Code extensions.

---

## 2. Clone the code repository

Open a terminal in the folder where you keep projects:

```powershell
git clone <REPOSITORY_URL>
cd <PROJECT_FOLDER>
```

Then open the folder in VS Code:

```powershell
code .
```

You should see files/folders similar to:

```text
rokit.toml
default.project.json
src/
  server/
  client/
  shared/
```

If you do not see `default.project.json`, you are probably in the wrong folder.

---

## 3. Install project tools with Rokit

From the project root in VS Code terminal:

```powershell
rokit install
```

Check that Rojo is available:

```powershell
rojo --version
```

If `rojo` is not recognized, try:

```powershell
rokit self-install
rokit install
```

Then close and reopen VS Code.

---

## 4. Do **not** build the project

Do **not** run this as your normal workflow:

```powershell
rojo build -o game.rbxl
```

Why?

Because this project keeps the map and manually placed objects in the **Roblox Studio cloud experience**, not fully inside Rojo.

If you build a fresh `.rbxl` from Rojo, you may open a file that only contains whatever exists in the Rojo project tree. That can make it look like objects are missing, such as:

```text
Workspace/JumpPads/JumpPad1
ReplicatedStorage/Remotes/JumpPadBoost
Lighting changes
Terrain
UI placed in Studio
Map parts
Attributes on parts
```

The correct flow is:

```text
Open the real Roblox experience from Studio
→ run rojo serve
→ connect the Rojo plugin
→ sync code into the existing place
```

---

## 5. Open the actual Roblox experience in Studio

Open Roblox Studio and sign in.

Then open the shared project from Roblox cloud:

```text
Roblox Studio
→ My Experiences / Group Experiences
→ Select the project experience
→ Open it
```

If the project belongs to a Roblox group, make sure you are viewing the group’s experiences, not only your personal experiences.

Do **not** open a local `build.rbxl` unless the team specifically tells you to.

---

## 6. Start Rojo sync

In VS Code terminal, from the project root, run:

```powershell
rojo serve
```

You should see something like:

```text
Rojo server listening on localhost:34872
```

Keep this terminal running while you work.

---

## 7. Connect Roblox Studio to Rojo

In Roblox Studio:

```text
Plugins
→ Rojo
→ Connect
```

Usually the server is:

```text
localhost:34872
```

After connecting, Rojo will sync the code from VS Code into the open Roblox place.

For example, these files:

```text
src/server/JumpPadService.server.lua
src/client/JumpPadController.client.lua
src/shared/SomeModule.lua
```

may appear in Studio as:

```text
ServerScriptService/JumpPadService
StarterPlayer/StarterPlayerScripts/JumpPadController
ReplicatedStorage/Shared/SomeModule
```

The exact locations depend on `default.project.json`.

---

## 8. Daily startup checklist

Every time you start working:

```text
1. Pull latest code from GitHub.
2. Open the Roblox cloud experience in Roblox Studio.
3. Open the repo folder in VS Code.
4. Run `rokit install` if tools changed or after first clone.
5. Run `rojo serve`.
6. Connect the Rojo plugin in Studio.
7. Make code changes in VS Code.
8. Make map/object changes in Studio.
9. Save/publish the Roblox place.
10. Commit and push code changes to GitHub.
```

Command version:

```powershell
git pull
rokit install
rojo serve
```

---

## 9. What to edit where

### Edit in VS Code

Use VS Code for Rojo-managed code:

```text
src/server/
  Server scripts
  Game services
  Combat logic
  Damage logic
  Data saving logic

src/client/
  Client scripts
  Input handling
  Camera logic
  Local VFX
  UI controllers

src/shared/
  Shared modules
  Configs
  Constants
  Type definitions
```

Examples:

```text
JumpPadService.server.lua
JumpPadController.client.lua
WeaponConfig.lua
CombatTypes.lua
```

### Edit in Roblox Studio

Use Studio for the actual world and visual setup:

```text
Workspace objects
Map parts
Terrain
Lighting
Manually placed jump pads
Attributes on parts
UI layout
Models
NPC placement
RemoteEvents if the team has not moved them into Rojo yet
```

Examples:

```text
Workspace/JumpPads/JumpPad1
JumpPad1 attribute: BoostPower = 300
ReplicatedStorage/Remotes/JumpPadBoost
Lighting settings
```

---

## 10. Do not edit Rojo-managed scripts directly in Studio

If a script came from Rojo, edit it in VS Code.

Do not edit this directly in Studio:

```text
ServerScriptService/JumpPadService
```

Instead edit:

```text
src/server/JumpPadService.server.lua
```

Why?

Because Rojo sync can overwrite Studio-side script edits with the VS Code version.

---

## 11. Save Studio changes properly

When you change objects, map parts, attributes, lighting, UI, or anything visual in Roblox Studio, save the place:

```text
File → Save to Roblox
```

or publish changes:

```text
File → Publish to Roblox
```

The exact option depends on whether the place is already published.

For safer local backups, the project owner may also periodically do:

```text
File → Save to File As...
```

and save a local `.rbxl` backup, for example:

```text
places/GeboFightingGame-dev.rbxl
```

But the normal shared source of truth for the place is the Roblox cloud experience.

---

## 12. Git workflow for code changes

Before starting a task:

```powershell
git checkout main
git pull
git checkout -b feature/my-feature-name
```

Example:

```powershell
git checkout -b feature/jump-pad-vfx
```

After making changes:

```powershell
git status
git add .
git commit -m "Add jump pad VFX controller"
git push -u origin feature/jump-pad-vfx
```

Then open a pull request on GitHub.

Recommended rule:

```text
Do not commit directly to main.
Use feature branches and pull requests.
```

---

## 13. File naming rules for Rojo scripts

Rojo uses file names to decide what Roblox script type to create:

```text
.server.lua  → Script
.client.lua  → LocalScript
.lua         → ModuleScript
```

Examples:

```text
JumpPadService.server.lua      → server Script
JumpPadController.client.lua   → client LocalScript
WeaponConfig.lua               → ModuleScript
```

If you accidentally name a server script like this:

```text
JumpPadService.lua
```

Rojo will treat it as a `ModuleScript`, not a running server `Script`.

---

## 14. Common mistakes

### Mistake: Running `rojo build` and opening the result

Bad normal workflow:

```powershell
rojo build -o game.rbxl
```

Then opening `game.rbxl` and wondering why Studio-created objects are missing.

Correct workflow:

```text
Open the real Roblox cloud experience in Studio
→ run `rojo serve`
→ connect plugin
```

---

### Mistake: Editing scripts in Studio

Bad:

```text
Edit ServerScriptService/JumpPadService directly in Studio
```

Correct:

```text
Edit src/server/JumpPadService.server.lua in VS Code
```

---

### Mistake: Creating important Studio objects but not saving the place

If you create this in Studio:

```text
Workspace/JumpPads/JumpPad1
```

but do not save/publish the place, other collaborators may not see it.

Correct:

```text
Create object in Studio
→ Save/Publish to Roblox
→ Tell team if needed
```

---

### Mistake: Rojo not connected

If code changes do not appear in Studio:

Check:

```text
Is `rojo serve` running?
Is the Rojo plugin connected?
Did you save the file in VS Code?
Are you in the correct project folder?
```

---

## 15. Troubleshooting

### `rojo` is not recognized

Run:

```powershell
rokit self-install
rokit install
```

Then reopen VS Code.

---

### Rojo plugin cannot connect

Check that this is running in VS Code terminal:

```powershell
rojo serve
```

Then reconnect from:

```text
Roblox Studio → Plugins → Rojo → Connect
```

Default address:

```text
localhost:34872
```

---

### My script does not run

Check the file name:

```text
Server script should end with `.server.lua`
Client script should end with `.client.lua`
Shared module should end with `.lua`
```

Check Studio Explorer:

```text
ServerScriptService should contain server Scripts
StarterPlayerScripts should contain LocalScripts
ReplicatedStorage/shared folders should contain ModuleScripts
```

---

### My object disappeared

Ask:

```text
Did I open the real Roblox cloud experience?
Or did I open a freshly built `.rbxl` file?
```

If you opened a `build.rbxl`, close it and open the real Roblox experience from Studio.

---

## 16. Recommended mental model

Think of the project like this:

```text
Roblox cloud experience
  Owns the world/place:
  - map
  - parts
  - terrain
  - lighting
  - attributes
  - placed models
  - UI layout

GitHub + Rojo
  Owns the code:
  - server scripts
  - client scripts
  - shared modules
  - config files
  - tests/tooling later
```

Normal development:

```text
Studio = build the world
VS Code = write the code
Rojo = sync the code into Studio
GitHub = review and version the code
Roblox cloud = save and share the actual place
```

---

## 17. Code Quality Checks

This project uses **StyLua** to check and format Luau/Lua files.

StyLua can be used in two ways:

* `stylua --check .` checks formatting and shows what would change.
* `stylua .` automatically formats the files.

### Check Formatting

From the project folder where `check-quality.ps1` is located, run:

```powershell
.\check-quality.ps1
```

This script runs the formatting check.

If all files are formatted correctly, you should see output similar to:

```text
Checking formatting...
All quality checks passed.
```

If StyLua finds formatting issues, it will print a diff showing what needs to change. For example:

```text
Checking formatting...
Diff in .\server\JumpPadService.server.lua:
1 |-local Players = game:GetService("Players")
1 |+local Players = game:GetService("Players")
```

This means the code is not formatted according to StyLua’s rules yet.

### Automatically Format Files

To let StyLua fix the formatting automatically, run:

```powershell
stylua .
```

After formatting, run the check again:

```powershell
.\check-quality.ps1
```

### Recommended Local Workflow

Before committing changes, run:

```powershell
stylua .
.\check-quality.ps1
```

This will:

1. Format the Luau/Lua files.
2. Check that the formatting now passes.
3. Show any remaining quality check errors in the terminal.

### Notes

If the script says that formatting failed, the code may still work in Roblox Studio. The failure only means that the files do not match the project’s formatting rules.

If the diff looks almost identical, the issue is probably whitespace-related, such as indentation, tabs, spaces, line endings, or missing final newlines.

---

## 18. Official references

- Rojo project format: https://rojo.space/docs/v7/project-format/
- Rojo sync details and script naming: https://rojo.space/docs/v7/sync-details/
- Roblox publishing experiences and places: https://create.roblox.com/docs/production/publishing/publish-experiences-and-places
- Roblox collaboration / Team Create: https://create.roblox.com/docs/projects/collaboration
