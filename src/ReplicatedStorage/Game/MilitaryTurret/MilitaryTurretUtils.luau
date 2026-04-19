-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTDnNob3J0QW5nbGVEaXN0BmlwYWlycwpHZXRQbGF5ZXJzB2dldFRlYW0EVGVhbQZQb2xpY2ULZ2V0Um9vdFBhcnQIUG9zaXRpb24JTWFnbml0dWRlE2dldE5lYXJlc3ROb25Qb2xpY2UEZ2FtZQdQbGF5ZXJzCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UHcmVxdWlyZQtQbGF5ZXJVdGlscwRHYW1lCFNldHRpbmdzCFJlc291cmNlAAMHAgAAAAAHJgMBACECAwCMBgIACQUGAiEEBQAmAwQCggMCAAECGC1EVPshGUAABwEBGAAAAQAAAAAJAAAAAA0CAwAAACmQAgEAxgMAAKQEAgAAABBA+wUAALwFBasDAAAAnwUCAJ8EAARRBBwA+wkBAE0JCZQEAAAAUgoIAJ8JAgIOCRYA+woCAE0KCmwFAAAATQoKsgYAAADxCRAACgAAAPsKAQBNCgobBwAAAFILCACfCgICDgoJAE0MCjsIAAAAJgsMAE0LC6oJAAAAYAsDAAIAAABSAgsAUgMIAG4E4/8CAACAggMCAAoCAAAAAAAA8H8DAgQAABBAAwMDBAMFAwYDBwMIAwkADAoBGAABAQAAAAAAAAABAAAAAAEAAAAAAAAAAQAAAAABAQAAAAABAAEB+AANDQAAAAAGAAABAgAnowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBAQAAAABAbwMEALwBARYDAAAAnwEDAqQCBgAAAFBATQQBvQgAAABNAwSmBwAAAJ8CAgKkAwYAAABQQE0FAWIKAAAATQQFygkAAACfAwIC/wQCAAAAAADABQsAMAUEqQwAAADABQ0AEgAAABIAAgASAAMAMAUEjw4AAACCBAIADwMLBAAAAEADDAMNAw4DDwQAAFBAAxADEQMSAxMGAAMBBgEDCgIAAQEAARgAAAAAAAAAAQAAAAAAAQAAAAAAAAEAAAAAAAACAAEAAAUAAAAAABIBAAAAAAI/lJy8cNC8KniLuOPxL53NT4yLyA1Q9r0=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:38:18
-- Luau version 6, Types version 3
-- Time taken: 0.002571 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
    shortAngleDist = function(arg1, arg2) -- Line 7, Named "shortAngleDist"
        local var3 = (arg2 - arg1) % (-math.pi*2)
        return 2 * var3 % (-math.pi*2) - var3
    end;
}
local Players_upvr = game:GetService("Players")
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
function module.getNearestNonPolice(arg1, arg2) -- Line 12
    --[[ Upvalues[3]:
        [1]: Players_upvr (readonly)
        [2]: PlayerUtils_upvr (readonly)
        [3]: Settings_upvr (readonly)
    ]]
    local var25
    for _, v in ipairs(Players_upvr:GetPlayers()) do
        local any_getTeam_result1_2 = PlayerUtils_upvr.getTeam(v)
        if any_getTeam_result1_2 then
            if any_getTeam_result1_2 ~= Settings_upvr.Team.Police then
                local any_getRootPart_result1 = PlayerUtils_upvr.getRootPart(v)
                if any_getRootPart_result1 then
                    if (any_getRootPart_result1.Position - arg1).Magnitude < (arg2 or math.huge) then
                    end
                end
            end
        end
    end
    return nil
end
return module