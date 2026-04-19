-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMjC19fQ2xhc3NOYW1lBmFzc2VydApfbGlzdEdyb3VwBXRhYmxlBmluc2VydAhhZGRHcm91cAVkZWJ1Zwxwcm9maWxlYmVnaW4YV29ybGRNYXJrZXJTeXN0ZW0gVXBkYXRlBmlwYWlycwhfZW5hYmxlZAZVcGRhdGUKcHJvZmlsZWVuZAhJbnN0YW5jZQNuZXcJU2NyZWVuR3VpD1dvcmxkTWFya2Vyc0d1aQROYW1lCVBsYXllckd1aQZQYXJlbnQHRW5hYmxlZA5JZ25vcmVHdWlJbnNldANndWkNUmVuZGVyU3RlcHBlZAdDb25uZWN0BGluaXQEZ2FtZQpSdW5TZXJ2aWNlCkdldFNlcnZpY2UHUGxheWVycwtMb2NhbFBsYXllcgdyZXF1aXJlEFdvcmxkTWFya2VyR3JvdXAGc2NyaXB0A0d1aQAEBQECAAAAF00DAOUAAAAA+wQAAE0EBOUAAAAA8QMCAAQAAACpAgABqQIBALsBAgKkAQIAAAAQQJ8BAgH7AgEATQICdgMAAACeNAIEAAAAAFIDAACkAQYAABRAgJ8BAwGCAAEABwMBAwIEAAAQQAMDAwQDBQQAFECAAAoGARgAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAQsAAAAABwABAAAAF6QAAgAABACAbwEDAJ8AAgGkAAUAAABAQPsBAABNAQF2BgAAAJ8AAgRRAAYATQUEqwcAAAAOBQMAvAUEJggAAACfBQIBbgD5/wIAAICkAAoAACQAgJ8AAQGCAAEACwMHAwgEAAQAgAMJAwoEAABAQAMDAwsDDAMNBAAkAIAAFgABGAAAAAABAAAAAAAAAQAAAQAA/gAFAAABFwAAAAAEAAMAAAAepAACAAAEAIBvAQMAnwACAm8BBAAwAQC6BQAAAPsBAABNAQGZBgAAADABACQHAAAAqQEBADABAPAIAAAAqQEBADABAAUJAAAA+wEBADAAAX8KAAAA+wECAE0BAc8LAAAAwAMMABICAQC8AQHHDQAAAJ8BAwGCAAEADgMOAw8EAAQAgAMQAxEDEgMTAxQDFQMWAxcDGAYBAxkBAQ4aARgAAAAAAQAAAQAAAAABAAABAAABAAACAAAAAAAAAAkPAAAAAAYAAAECAC2jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCTQIBMQUAAACkAwcAAABgQKQFCgAAAJBATQUFJAsAAABNBAXnCAAAAJ8DAgL/BAQAAAAAAMYFAAAwBQQfDAAAAP8FAAAAAAAAMAUEdg0AAADABQ4AEgADABIABAAwBQQ4DwAAAMAFEAASAAIAEgAEABIAAAAwBQQTEQAAAIIEAgASAxsEAAAAQAMcAx0DHgMfAyAEAABgQAMhAyIEAACQQAMUAyMDAwYAAwYGAgMaAgACAQABGAAAAAAAAAABAAAAAAABAAIAAAAAAAAAAAIAAQAAAQAAAAEAAAAABAAAAAAAEgEAAAAAA6fU83R7k2sHOMsOvdF3hlPXzOQAlRCZdQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:15
-- Luau version 6, Types version 3
-- Time taken: 0.001916 seconds

local module_upvr = {
    Gui = nil;
    _listGroup = {};
}
local WorldMarkerGroup_upvr = require(script.Parent.WorldMarkerGroup)
function module_upvr.addGroup(arg1) -- Line 10
    --[[ Upvalues[2]:
        [1]: WorldMarkerGroup_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    local var3
    if arg1.__ClassName ~= WorldMarkerGroup_upvr.__ClassName then
        var3 = false
    else
        var3 = true
    end
    assert(var3)
    var3 = module_upvr
    var3 = var3._listGroup
    table.insert(var3, arg1)
end
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local RunService_upvr = game:GetService("RunService")
function module_upvr.init() -- Line 14
    --[[ Upvalues[3]:
        [1]: LocalPlayer_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: RunService_upvr (readonly)
    ]]
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WorldMarkersGui"
    ScreenGui.Parent = LocalPlayer_upvr.PlayerGui
    ScreenGui.Enabled = true
    ScreenGui.IgnoreGuiInset = true
    module_upvr.gui = ScreenGui
    RunService_upvr.RenderStepped:Connect(function() -- Line 22
        --[[ Upvalues[1]:
            [1]: module_upvr (copied, readonly)
        ]]
        debug.profilebegin("WorldMarkerSystem Update")
        for _, v in ipairs(module_upvr._listGroup) do
            if v._enabled then
                v:Update()
            end
        end
        debug.profileend()
    end)
end
return module_upvr