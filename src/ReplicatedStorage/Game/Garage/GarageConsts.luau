-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local t = {}
t.SPAWN_DEBOUNCE_NON_PREMIUM = if RunUtils.isMainWorld() then 90 else 30
t.SPAWN_DEBOUNCE_PREMIUM = if RunUtils.isMainWorld() then 60 else 10
t.SPAWN_DEBOUNCE_PHYSICAL = 5
t.NUM_SAVE_SLOTS = 20
t.NUM_FREE_SAVE_SLOTS = 10
return TableUtils.requireValidIndexAndFreeze(t)