-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMXBHR5cGUFdmFsdWUOc2V0VG9vbHRpcFRleHQIZGlzcGF0Y2gQc2V0VG9vbHRpcENvbmZpZwRtYXRoBnJhbmRvbQVldmVyeRZUT09MVElQX0NZQ0xFX0lOVEVSVkFMB0Nvbm5lY3QEaW5pdARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNBcHAFc3RvcmUGc2NyaXB0BlBhcmVudA1Ub29sdGlwQ29uc3RzC1Rvb2x0aXBEYXRhA1N0ZAhJbnRlcnZhbAADBgAEAAAAE/sAAADiAgIAbwMDADADAnEAAAAA+wQBAPsFAgCHAwQFMAMCzAEAAAC8AABMBAAAAJ8AAwH7AgIA+wMDAM8BAgOVAAEF3gACAIIAAQAGAwEDAgUCAAEDAwMEAgAAAAAAAPA/AAsFARgAAAEAAAEAAAAA/gAABAAAAAABDAAAAAAIAAQAAAAm+wEAABwAAQCkAQIAAAQAgFICAACfAQIC2QIAABICAQASAgAAEgEB/xIAAAD7AwIATQMDxAMAAAD7BAMATQQE7gQAAACfAwICUgUCALwDA8cFAAAAnwMDAfsDAQDiBQgAbwYJADAGBXEGAAAA+wcAAIcGBwEwBgXMBwAAALwDA0wKAAAAnwMDAc8DAQCVAQMLwQEAAIIAAQAMAwYDBwQABACAAwgDCQMKAwEDAgUCBgcDAwMEAgAAAAAAAPA/AQAICwEYAAABAAAAAQAAAAAHAAAAAAAAAAAAAPoAAQAAAQAAAP4AAAQABAAJAAAAAAcAAAECADGjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgDBBgAAAE0CAn4HAAAAnwECAqQCBQAAAEBApAMJAAAAgEBNAwMkCgAAAE0DAysLAAAAnwICAqQDBQAAAEBApAQJAAAAgEBNBAQkCgAAAE0EBFEMAAAAnwMCAqQEBQAAAEBATQUAoQ0AAABNBQWsDgAAAJ8EAgL/BQEAAAAAAMAGDwASAAMAEgABABIABAASAAIAMAYFExAAAACCBQIAEQMMBAAAAEADDQMOAw8EAABAQAMQAxEDEgQAAIBAAxMDFAMVAxYDFwYBAwsBAQEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAAAAAEAAAAAAAAAAAEAAAAAAAABAAIAAAAAAAAOAQAAAAACvilDVk2EzP1ycoXLfrnHcc4xVCKM7SlX

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:02
-- Luau version 6, Types version 3
-- Time taken: 0.001388 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local TooltipData_upvr = require(script.Parent.TooltipData)
local store_upvr = require(ReplicatedStorage.App.store)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local TooltipConsts_upvr = require(script.Parent.TooltipConsts)
function module.init() -- Line 8
    --[[ Upvalues[4]:
        [1]: TooltipData_upvr (readonly)
        [2]: store_upvr (readonly)
        [3]: Interval_upvr (readonly)
        [4]: TooltipConsts_upvr (readonly)
    ]]
    local len_upvr = #TooltipData_upvr
    local randint_from_1_upvw = math.random(len_upvr)
    Interval_upvr.every(TooltipConsts_upvr.TOOLTIP_CYCLE_INTERVAL):Connect(function() -- Line 11, Named "setTooltipConfig"
        --[[ Upvalues[4]:
            [1]: store_upvr (copied, readonly)
            [2]: TooltipData_upvr (copied, readonly)
            [3]: randint_from_1_upvw (read and write)
            [4]: len_upvr (readonly)
        ]]
        store_upvr:dispatch({
            type = "setTooltipText";
            value = TooltipData_upvr[randint_from_1_upvw];
        })
        randint_from_1_upvw = randint_from_1_upvw % len_upvr + 1
    end)
    store_upvr:dispatch({
        type = "setTooltipText";
        value = TooltipData_upvr[randint_from_1_upvw];
    })
    randint_from_1_upvw = randint_from_1_upvw % len_upvr + 1
end
return module