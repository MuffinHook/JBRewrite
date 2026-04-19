-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMtDkdldEJvdW5kaW5nQm94AV8Cb3MFY2xvY2sGQ0ZyYW1lA25ldwZBbmdsZXMEbWF0aANzaW4JTWFnbml0dWRlD2dldFVwZGF0ZUNhbWVyYQ5Sb2NrZXRMYXVuY2hlcgZhc3NlcnQIUmVzb3VyY2UKSXRlbVN5c3RlbQZNb2RlbHMORmluZEZpcnN0Q2hpbGQFQ2xvbmUIU2tlbGV0b24LQm91bmRpbmdCb3gLUHJpbWFyeVBhcnQNVG9PYmplY3RTcGFjZQdJbnZlcnNlFFNldFByaW1hcnlQYXJ0Q0ZyYW1lBE5vbmUFZXJyb3IdTm8gc2tpbiBieSBuYW1lIG9mICVzIGV4aXN0cy4GZm9ybWF0JFNraW4gJXMgaGFzIG5vIGltYWdlIGlkIGZvciBpdGVtOiAlcw5HZXREZXNjZW5kYW50cwhNZXNoUGFydANJc0EPQXBwbHlHdW5UZXh0dXJlDEdldEF0dHJpYnV0ZQ9yYnhhc3NldGlkOi8vJWQACVRleHR1cmVJRAhnZXRNb2RlbARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQRHYW1lCEl0ZW1Ta2luC0l0ZW1Ta2luSWRzAAQLAgIAAAA2KwEBAIIAAQD7AgAA8QEIAAIAAAC8AgGVAAAAAJ8CAgMYAgB+AQAAAN4DAQDeAQAApAIEAAAMIICfAgECpAYHAAAYUICMBwAAjAgAAIwJAACfBgQCpAcJAAAgUICMCAAAIQkCCowKAACfBwQCCQUGB6QGCQAAIFCAWwoCDbsYCgKkCRAAADzggJ8JAgJbCAkMeAcIC4wIAACMCQAAnwYEAgkEBQakBQcAABhQgIwGAACMBwAA+wkBAE0JCaoSAAAAWwgJEZ8FBAIJAwQFMAMAhQUAAACCAAEAEwMBAwIDAwMEBAAMIIADBQMGBAAYUIADBwQAIFCAAhgtRFT7IRlAApqZmZmZmdk/AjMzMzMzM9M/AgAAAAAAAOA/AwgDCQQAPOCAApqZmZmZmek/AwoACQABGAABAgAAAQAAAAAAAQIAAAEAAAAAAAEAAAAAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAIAAQoAAAAAAwAAAAAAB8YAAADGAQAA2QIAABIBAP8SAQH/wQAAAIICAgAAAQAGCwEYAAEBAAAAAAcAAAAADwICAAATBAADBQIPgwMJOgIDCUUCAwxbAmWQAQEAuwEBA1IDAQCkAgIAAAAQQJ8CAgH7AgAATQICYgMAAABNAgLwBAAAAE0CAvgFAAAAUgQBALwCAgMGAAAAnwIDArwDAjoHAAAAnwMCAlICAwC8AwKVCAAAAJ8DAgJvBgkAvAQCAwYAAACfBAMCbwYKALwEBAMGAAAAnwQDAjAEApsLAAAATQUCmwsAAABNBQWFDAAAAFIHAwC8BQVGDQAAAJ8FAwK8CAXaDgAAAJ8IAgC8BgJmDwAAAJ8GAAHGBgAA8AAXABAAAAD7CAEAhwcIACsHCACkCBIAAAAQQW8JEwBSCwAAvAkJjRQAAACfCQMAnwgAAYcGBwErBgkApAgSAAAAEEFvCRUAUgsAAFIMAQC8CQmNFAAAAJ8JBACfCAABvAcCRxYAAACfBwIEZAcVAG8OFwC8DAv+GAAAAJ8MAwIODBAAbw4ZALwMCxIaAAAAnwwDAioMCwABAACADgYGAG8MGwBSDgYAvAwMjRQAAACfDAMCZQABAG8MHAAwDAuEHQAAAG4H6v8CAAAAggICAB4DDAMNBAAAEEADDgMPAxADEQMSAwEDEwMUAxUDBQMWAxcDGAMZAxoEAAAQQQMbAxwDHQMeAx8DIAMhAyIDIwMkAyUAGiYBGAABAAAAAAIAAAAAAAAAAAAAAQAAAAIAAAEAAAAAAAAAAQABAAAAAAAAAAEAAAAAAAUBAAEAAQEAAAAAAAAAAgEBAAAAAAAAAAAEAAAAAQAAAAABAAAAAAABAAAAAAAAAAAA/QAIHAAAAAAEAAABAgAbowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAvQYAAABNAgLhBwAAAE0CAswIAAAAnwECAv8CAgAAAAAAwAMJADADAmwKAAAAwAMLABIAAAASAAEAMAMCIgwAAACCAgIADQMnBAAAAEADKAMpAyoEAABAQAMrAywDLQYBAwsGAgMmAgECAQABGAAAAAAAAAABAAAAAAAAAAACAAIAABQAAAAAKAEAAAAAAwyFlnCh+m7TQCcAo2upNiB8nYEEPkH8cQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:38:03
-- Luau version 6, Types version 3
-- Time taken: 0.006055 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {
    getUpdateCamera = function() -- Line 6, Named "getUpdateCamera"
        local var4_upvw
        local var5_upvw
        return function(arg1, arg2) -- Line 9
            --[[ Upvalues[2]:
                [1]: var4_upvw (read and write)
                [2]: var5_upvw (read and write)
            ]]
            if not arg2 then
            else
                if arg2 ~= var4_upvw then
                    local any_GetBoundingBox_result1, any_GetBoundingBox_result2 = arg2:GetBoundingBox()
                    _ = any_GetBoundingBox_result1 -- Setting global
                    var5_upvw = any_GetBoundingBox_result2
                    var4_upvw = arg2
                end
                local os_clock_result1 = os.clock()
                arg1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, os_clock_result1 % (-math.pi*2), 0) * CFrame.Angles(math.sin(os_clock_result1 * 0.5) * 0.3 - 0.4, 0, 0) * CFrame.new(0, 0, var5_upvw.Magnitude * 0.8)
            end
        end
    end;
}
local ItemSkinIds_upvr = require(ReplicatedStorage_upvr.Game.ItemSkin.ItemSkinIds)
function module.getModel(arg1, arg2) -- Line 26
    --[[ Upvalues[2]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: ItemSkinIds_upvr (readonly)
    ]]
    local var26 = arg2 or "RocketLauncher"
    assert(var26)
    local clone = ReplicatedStorage_upvr.Resource.ItemSystem.Models:FindFirstChild(var26):Clone()
    clone.PrimaryPart = clone:FindFirstChild("Skeleton"):FindFirstChild("BoundingBox")
    clone:SetPrimaryPartCFrame(clone.PrimaryPart.CFrame:ToObjectSpace(clone:GetBoundingBox()):Inverse())
    local var28
    if arg1 ~= "None" then
        local var29 = ItemSkinIds_upvr[arg1]
        if not var29 then
            error("No skin by name of %s exists.":format(arg1))
        end
        var28 = var29[var26]
        if not var28 then
            error("Skin %s has no image id for item: %s":format(arg1, var26))
        end
    end
    for _, v in clone:GetDescendants() do
        if v:IsA("MeshPart") then
            local ApplyGunTexture = v:GetAttribute("ApplyGunTexture")
            if ApplyGunTexture == true then
                if var28 then
                    ApplyGunTexture = "rbxassetid://%d":format(var28)
                else
                    ApplyGunTexture = ""
                end
                v.TextureID = ApplyGunTexture
            end
        end
    end
    return clone
end
return module