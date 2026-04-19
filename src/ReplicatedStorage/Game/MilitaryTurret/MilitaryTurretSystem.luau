-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUAXkHcnA0bHB6YQNzdWIHcmV2ZXJzZQAEa2hvMwRTaG90CkZpcmVTZXJ2ZXIFX21haWQLb25CdWxsZXRIaXQHQ29ubmVjdAhHaXZlVGFzawVFdmVudBNHZXRDbGFzc0FkZGVkU2lnbmFsBVN0YXJ0BGluaXQHcmVxdWlyZRRNaWxpdGFyeVR1cnJldEJpbmRlcgZzY3JpcHQGUGFyZW50AAQMAQEAAAcAAAEDCAUCG/sBAABvBAAAbwgBAIwKBACMCwYAvAgI8AIAAACfCAQCvAgImwMAAACfCAICvAgImwMAAACfCAICvAgImwMAAACfCAICUgUIAG8GBABvBwUAcwMEB1IEAABvBQYAvAEBawcAAACfAQUBggABAAgDAQMCAwMDBAMFAwYDBwMIAAgAARgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEJAAAAAAYBAQAAAA1NAQDBAAAAAE0DAGUBAAAA2QUAABICAAC8AwPHAgAAAJ8DAwC8AQH9AwAAAJ8BAAGCAAEABAMJAwoDCwMMAQAHAAEYAAAAAAAAAAAAAAAAAwgAAAAABQEBAAAAEE0BADYAAAAA+wIAALwCAgcBAAAAnwICAtkEAAASAAEAvAICxwIAAACfAgMB+wIAALwCAhwDAAAAnwICAYIAAQAEAw0DDgMLAw8BAQQQARgAAAIAAAAAAAAAAAUAAAABBQAAAAADAAABAgARowAAAKQAAQAAAABApAIEAAAAMEBNAgIkBQAAAE0BApICAAAAnwACAv8BAQAAAAAAwAIGABIAAAAwAgETBwAAAIIBAgAIAxEEAAAAQAMSAxMEAAAwQAMUBgIDEAECAQABGAAAAAAAAAAAAAACAAEAAAAKAQAAAAADAj4b3IM46NHJtDFvmbwjKnImDKgw+nHd

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:38:17
-- Luau version 6, Types version 3
-- Time taken: 0.001172 seconds

local module = {}
local MilitaryTurretBinder_upvr = require(script.Parent.MilitaryTurretBinder)
function module.init(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: MilitaryTurretBinder_upvr (readonly)
    ]]
    local Event_upvr = arg1.Event
    MilitaryTurretBinder_upvr:GetClassAddedSignal():Connect(function(arg1_2) -- Line 7
        --[[ Upvalues[1]:
            [1]: Event_upvr (readonly)
        ]]
        arg1_2._maid:GiveTask(arg1_2.onBulletHit:Connect(function(arg1_3) -- Line 8
            --[[ Upvalues[1]:
                [1]: Event_upvr (copied, readonly)
            ]]
            Event_upvr:FireServer('y'.."rp4lpza":sub(4, 6):reverse():reverse():reverse().."".."kho3", arg1_3, "Shot")
        end))
    end)
    MilitaryTurretBinder_upvr:Start()
end
return module