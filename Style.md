Write this in my Lua/Roblox style.

My style is practical, fast-moving, and utility-first. I usually optimize for getting working behavior in-game over making everything overly abstract. Keep the code feeling like something I would actually write, not like a sanitized tutorial.

Style rules:
- Use Roblox Lua and direct `game:GetService(...)` patterns.
- Usually start with load guards like `repeat task.wait() until game:IsLoaded()` and other readiness waits for character, camera, or UI before doing work.
- Prefer lots of top-level locals for services, config values, IDs, flags, and state.
- Use simple, descriptive variable names, often in PascalCase or camelCase for locals like `LocalPlayer`, `PlaceId`, `JobId`, `Camera`, `HopTime`, `AllowedAccountUsers`, `tradeClientName`, `finishedSafes`.
- I often organize code as:
  1. wait/load guards
  2. service locals
  3. config/constants/tables
  4. helper functions
  5. main execution / spawned tasks / hooks
- Prefer helper functions for every meaningful action, like `ServerHop`, `getCasinoCode`, `GetTowTruck`, `NearestPlayer`, `GetRandomServer`, `loadMap`, `getDrop`, `openSafes`, `readStats`, `updateStats`.
- Use early returns instead of deep nesting, like `if not TowTruck then Notif("Please Enter A Tow Truck") return end` or `if not Drop then return end`.
- I like small utility wrappers such as `Notif`, `round`, `TeleportToPlace`, `GetHashMeaning`, `FormatValue`, and data formatting functions.
- Keep comments casual and human, not corporate. Short notes are good. It’s fine to use comments like:
  - `-- Api fr`
  - `--if game isnt ban jail`
  - `-- we need to find a solution because of new tp detections`
  - `-- part isn't always loaded in fr`
  - `-- Chat GPT`
  - `-- Logic fr`
  - `-- user whitelist check`
- It’s okay for the tone inside comments and strings to sound informal, with phrases like `fr`, `lowk`, `wtv`, `uh what`, `broke fr`, and similar natural shorthand.
- Prefer concrete tables for mappings and config instead of over-engineering, like `dropData`, `bankFloors`, `robberies`, `actionMessages`, `defaultStats`, `Hashes`, and blacklist tables.
- I often use loops directly with `for i, v in pairs(...) do`, `for i, v in next, ... do`, and repeated retry loops with `repeat task.wait() until ...`.
- Keep the code action-oriented: lots of direct `FireServer`, `TeleportService`, `request`, `hookfunction`, `task.spawn`, `task.delay`, and `repeat task.wait()` flows.
- When useful, include lightweight type annotations on functions, but don’t force them everywhere. I sometimes write things like `local function serverHop() : ()`, `local function getCasinoCode() : string`, or typed params like `position: Vector3`.
- For UI/debug tools, it should still feel hands-on and builder-style, with toggles, labels, dropdowns, buttons, notifications, and background threads updating labels or state.
- Don’t over-explain. Keep momentum. The code should feel like it was written by someone actively testing in-game and iterating quickly.

What to imitate specifically:
- Direct service setup and constants near the top.
- Practical helper names like `GetTowTruck`, `NearestVehicle`, `ServerHop`, `RespawnOnDeath`, `HookObject`, `GrabCircleSpec`.
- Inline guards and short notifications when something is missing.
- Data collection into tables that get JSON-encoded or sent to an API.
- Casual but intentional comments.
- A mix of scripting pragmatism and game-specific logic.

What to avoid:
- Overly formal enterprise architecture.
- Too many layers of abstraction for simple actions.
- Excessive class-like patterns unless clearly helpful.
- Robotic comments or tutorial-style narration.
- Renaming everything into ultra-clean “best practice” names if the natural, practical name is clearer.

Make it feel like code written by a real Roblox developer moving fast, solving game-specific problems, and adding helpers as needed.