# CleanupRules.md

## Goal

Fix syntax errors and common decompiler issues in Luau files with minimal changes.
DO NOT rewrite logic unless explicitly required.

---

## Core Rules

* Only fix what is broken
* Rename variables to better names than the default ones given by the decompiler
* Do not restructure code
* Preserve original behavior
* Prefer minimal edits over “clean” code

---

## Common Fixes

### 1. Invalid Color3 Values

Clamp all RGB values to 0–255

Bad:
Color3.fromRGB(320, 325, 0)

Fix:
Color3.fromRGB(255, 255, 0)

---

### 2. Missing Table Brackets

Ensure all tables are properly closed

Bad:
local t = {
a = 1,
b = 2

Fix:
local t = {
a = 1,
b = 2
}

---

### 3. Trailing Commas

Remove invalid trailing commas in arrays if they break parsing

---

### 4. Nil Indexing Protection (only if crashing)

If code directly indexes possibly nil values, wrap safely

Bad:
player.Character.Humanoid

Fix:
player.Character and player.Character:FindFirstChild("Humanoid")

---

### 5. Require Paths

Fix broken requires:

* Ensure modules exist
* Use correct service references

---

### 6. Decompiled Variable Names

Do not rename variables like v1, v2, v3 unless required to fix shadowing or syntax errors

---

### 7. Enum Fixes

Ensure enums are valid:
RobberyConsts.ENUM_ROBBERY.BANK

Do not guess missing enums; leave unchanged if uncertain

---

### 8. Function Syntax

Fix malformed functions

Bad:
function()
print("hi")

Fix:
function()
print("hi")
end

---

### 9. Return Statements

Ensure modules return a value

Missing return:
local module = {}

Fix:
return module

---

---

### 10. Invalid String format

It is very common for there to be errors concerning string.format. If you see a error that has something like "string %d":format(arg) please rewrite it to string.format("string %d", arg)

---

## Do Not Do

* Do not optimize code
* Do not refactor structure
* Do not change logic unless it is broken
    * If logic needs to be changed then add a "Logic Change" comment
* Do not add new features

---

## Validation

After fixes:

* File must compile in Luau
* No syntax errors
* No missing brackets or keywords

---

## Priority Order

1. Syntax errors (must fix)
2. Runtime crashes (fix minimally)
3. Invalid constants (e.g., RGB > 255)
4. Everything else should be ignored
