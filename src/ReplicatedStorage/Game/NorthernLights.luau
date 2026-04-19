-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMXBHRpY2sMX3RhcmdldENvbG9yBl9jb2xvcgZDb2xvcjMHZnJvbUhTVgRtYXRoBnJhbmRvbQRsZXJwBmlwYWlycwtHZXRDaGlsZHJlbgVEZWNhbAl3b3Jrc3BhY2UJU2t5TGlnaHRzDFdhaXRGb3JDaGlsZAlIZWFydGJlYXQHQ29ubmVjdAR0YXNrBXNwYXduBGluaXQEZ2FtZQpSdW5TZXJ2aWNlCkdldFNlcnZpY2UDbmV3AAQIAAMAAAA1pAABAAAAAECfAAEC+wIAACYBAAKMAgUAYAITAAEAAADeAAAA+wEBAPsCAQBNAgL7AgAAADACAdADAAAA+wEBAKQCBgAAFECApAMJAAAgcICfAwECjAQBAG8FCgCfAgQCMAIB+wIAAAD7AQEATQEB0AMAAAD7AwEATQMD+wIAAAD7BgAAJgUABj4EBQu8AQG/DAAAAJ8BBAKkAg4AAADQQPsDAgC8AwNoDwAAAJ8DAgCfAgAEUQIEAE0HBqAQAAAAMAEHmgQAAABuAvv/AgAAgIIAAQARAwEEAAAAQAMCAwMDBAMFBAAUQIADBgMHBAAgcIACAAAAAAAA+D8CAAAAAAAAFEADCAMJBAAA0EADCgMLAAsAARgAAAACAAAAAAEBAAAAAAABAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAEAAAAAAAAAAQAAAP8AAwwAAAAABQACAAAAFaQAAQAAAABAbwICAIwDFAC8AADTAwAAAJ8ABAIOAAwAjAEAAPsCAABNAgL9BAAAANkEAAASAQH/EgIBABIAAAC8AgLHBQAAAJ8CAwHBAQAAggABAAYDDAQAAABAAw0DDgMPAxABAAcAARgAAAAAAAAAAQEBAAAAAAAAAAAAAA4IAAAAAAIAAgAAAAekAAIAAAQAgMABAwASAgAAEgIBAJ8AAgGCAAEABAMRAxIEAAQAgAYBAQEGEwEYAAAAAAAAEwcAAAAABgAAAQIAGqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQMAAAAAAMYCAAAwAgHQBAAAAKQCBwAAGFCAjAMBAIwEAQCMBQEAnwIEAjACAfsIAAAAwAIJABIAAAASAAEAMAIBEwoAAACCAQIACwMUBAAAAEADFQMWAwMDBAMXBAAYUIADAgYCAxMBAgEAARgAAAAAAAAAAgABAAABAAAAAAAAAAEAAAAAFQEAAAAAA6xNdyj0QRbOBgLu7McxNATcVWBcnokdKQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:26
-- Luau version 6, Types version 3
-- Time taken: 0.002008 seconds

local module_upvr = {
    _color = nil;
    _targetColor = Color3.new(1, 1, 1);
}
local RunService_upvr = game:GetService("RunService")
function module_upvr.init() -- Line 6
    --[[ Upvalues[2]:
        [1]: RunService_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    task.spawn(function() -- Line 7
        --[[ Upvalues[2]:
            [1]: RunService_upvr (copied, readonly)
            [2]: module_upvr (copied, readonly)
        ]]
        local SkyLights_upvr = workspace:WaitForChild("SkyLights", 20)
        if SkyLights_upvr then
            local var6_upvw = 0
            RunService_upvr.Heartbeat:Connect(function() -- Line 11
                --[[ Upvalues[3]:
                    [1]: var6_upvw (read and write)
                    [2]: module_upvr (copied, readonly)
                    [3]: SkyLights_upvr (readonly)
                ]]
                local tick_result1 = tick()
                if 5 < tick_result1 - var6_upvw then
                    var6_upvw = tick_result1
                    module_upvr._color = module_upvr._targetColor
                    module_upvr._targetColor = Color3.fromHSV(math.random(), 1, 1.5)
                end
                for _, v in ipairs(SkyLights_upvr:GetChildren()) do
                    v.Decal.Color3 = module_upvr._color:lerp(module_upvr._targetColor, (tick_result1 - var6_upvw) / 5)
                    local _
                end
            end)
        end
    end)
end
return module_upvr