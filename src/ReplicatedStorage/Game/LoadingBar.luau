-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMcDHNldG1ldGF0YWJsZQNuZXcETWFpZA1Mb2FkaW5nQmFyR3VpCFJlc291cmNlCkxvYWRpbmdCYXIFQ2xvbmUDR3VpCVBsYXllckd1aQZQYXJlbnQHRW5hYmxlZAhHaXZlVGFzawhTZXRWYWx1ZQpCYWNrZ3JvdW5kBVZhbHVlBVVEaW0yBFNpemUIUG9zaXRpb24LU2V0UG9zaXRpb24HRGVzdHJveQRnYW1lB1BsYXllcnMKR2V0U2VydmljZQtMb2NhbFBsYXllchFSZXBsaWNhdGVkU3RvcmFnZQdyZXF1aXJlA1N0ZAdfX2luZGV4AAUEAAQAAAAz/wACAAAAAAD7AwAAnj0ABAMAAABSAgAApAEBAAAAAECfAQMB+wEBAE0BAe8CAAAAnwEBAjABAHYDAAAA+wICAE0CAmIFAAAATQICOQYAAABNAQJRBAAAALwBAToHAAAAnwECAjABAB8IAAAATQEAHwgAAAD7AgMATQICmQkAAAAwAgEkCgAAAE0BAB8IAAAAqQIBADACAfALAAAATQEAdgMAAABNAwAfCAAAALwBAf0MAAAAnwEDAYwDAAC8AQD/DQAAAJ8BAwGCAAIADgMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwMMAw0ACAIBGAAAAQAAAAAAAAIAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAABAAAAAAEAAAAAAAACAAAAAgkAAAAACAIAAAAAEE0CAB8AAAAATQIC7QEAAABNAgLsAgAAAKQDBQAAEDCAUgQBAIwFAACMBgEAjAcAAJ8DBQIwAwIvBgAAAIIAAQAHAwgDDgMPAxADAgQAEDCAAxEAFg0BGAAAAAAAAAAAAAAAAAAAAAEXAAAAAAMCAAAAAAdNAgAfAAAAAE0CAu0BAAAAMAECOwIAAACCAAEAAwMIAw4DEgAZEwEYAAAAAAAAARoAAAAAAwEAAAAACU0BAHYAAAAAvAEBUAEAAACfAQIBxgEAADABAHYAAAAAggABAAIDAwMUABwUARgAAAAAAAEAAAEdAAAAAAYAAAECACujAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCTQEAMQQAAACkAgEAAAAAQG8EBQC8AgIWAwAAAJ8CAwKkAwcAAABgQE0EAqEIAAAATQQEdgkAAACfAwIC/wQEAAAAAAAwBARuCgAAAMAFCwASAAQAEgADABIAAgASAAEAMAUE7wwAAADABQ0AMAUE/w4AAADABQ8AMAUE6BAAAADABREAMAUEUBIAAACCBAIAEwMVBAAAAEADFgMXAxgDGQMaBAAAYEADGwMDAxwGAAMCBgEDDQYCAxMGAwMUBAABAgMBAAEYAAAAAAAAAAEAAQAAAAAAAQAAAAAAAAIAAQABAAAAAAAADgAAAwAAAwAABQEAAAAABIRqf3A5lu1t/I3itXo48FL0cmgEtq4VcQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:23
-- Luau version 6, Types version 3
-- Time taken: 0.001643 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.new() -- Line 8
    --[[ Upvalues[4]:
        [1]: module_upvr (readonly)
        [2]: Maid_upvr (readonly)
        [3]: ReplicatedStorage_upvr (readonly)
        [4]: LocalPlayer_upvr (readonly)
    ]]
    local module = {}
    setmetatable(module, module_upvr)
    module.Maid = Maid_upvr.new()
    module.Gui = ReplicatedStorage_upvr.Resource.LoadingBar.LoadingBarGui:Clone()
    module.Gui.Parent = LocalPlayer_upvr.PlayerGui
    module.Gui.Enabled = true
    module.Maid:GiveTask(module.Gui)
    module:SetValue(0)
    return module
end
function module_upvr.SetValue(arg1, arg2) -- Line 22
    arg1.Gui.Background.Value.Size = UDim2.new(arg2, 0, 1, 0)
end
function module_upvr.SetPosition(arg1, arg2) -- Line 25
    arg1.Gui.Background.Position = arg2
end
function module_upvr.Destroy(arg1) -- Line 28
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr