-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMOA25ldwhUQUdfTkFNRQdyZXF1aXJlC1RvcEV4cEJvYXJkBnNjcmlwdAZQYXJlbnQFU3RhcnQEaW5pdARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UDU3RkBkJpbmRlchFUb3BFeHBCb2FyZENvbnN0cwACBQACAAAAFPsAAABNAADvAAAAAPsBAQBNAQG0AQAAAKQCAwAAACBApAQGAAAAUEBNBAQkBwAAAE0DBIIEAAAAnwICAJ8AAAK8AQAcCAAAAJ8BAgGCAAEACQMBAwIDAwQAACBAAwQDBQQAAFBAAwYDBwAHCAEYAAAAAAAAAAAAAAAAAAAAAAEAAAEIAAAAAAUAAAECAB+jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgChBgAAAE0CAn8HAAAAnwECAqQCBQAAAEBApAQKAAAAkEBNBAQkCwAAAE0DBIUIAAAAnwICAv8DAQAAAAAAwAQMABIAAQASAAIAMAQDEw0AAACCAwIADgMJBAAAAEADCgMLAwMEAABAQAMMAw0DDgMFBAAAkEADBgYAAwgBAAEAARgAAAAAAAAAAQAAAAAAAAIAAAAAAAAAAAIAAQAAAAAEAQAAAAABb8tm2DnSJ0GuUNCnCucmNR/TcaxdDwzZ

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:09
-- Luau version 6, Types version 3
-- Time taken: 0.000753 seconds

local module = {}
local Binder_upvr = require(game:GetService("ReplicatedStorage").Std.Binder)
local TopExpBoardConsts_upvr = require(script.Parent.TopExpBoardConsts)
function module.init() -- Line 7
    --[[ Upvalues[2]:
        [1]: Binder_upvr (readonly)
        [2]: TopExpBoardConsts_upvr (readonly)
    ]]
    Binder_upvr.new(TopExpBoardConsts_upvr.TAG_NAME, require(script.Parent.TopExpBoard)):Start()
end
return module