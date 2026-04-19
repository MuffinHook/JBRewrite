-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMfDkdldEJvdW5kaW5nQm94AV8FVXBEb3QORmluZEZpcnN0Q2hpbGQFVmFsdWUGQ0ZyYW1lBkFuZ2xlcwJvcwVjbG9jawNuZXcEbWF0aANzaW4JTWFnbml0dWRlD2dldFVwZGF0ZUNhbWVyYQhSZXNvdXJjZQhIb21lSXRlbQVlcnJvchxObyBIb21lSXRlbSBleGlzdHMgYnkgbmFtZTogBUNsb25lDkdldERlc2NlbmRhbnRzEkx1YVNvdXJjZUNvbnRhaW5lcgNJc0EHRGVzdHJveQtQcmltYXJ5UGFydA1Ub09iamVjdFNwYWNlB0ludmVyc2UUU2V0UHJpbWFyeVBhcnRDRnJhbWUIZ2V0TW9kZWwEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlAAQLAgMAAABUKwEBAIIAAQD7AgAA8QEkAAIAAAC8AgGVAAAAAJ8CAgMYAgB+AQAAAN4DAQDeAQAA+wIAAG8EAgC8AgIDAwAAAJ8CAwIOAhYATQMC7AQAAAANAxMABQAAAE0EAuwEAAAADQQIAAYAAICkAwkAACBwgG8ECgCMBQAAbwYKAJ8DBAJlAAYApAMJAAAgcICMBAAAjAUAAG8GCwCfAwQC3gMCAKQCDgAANMCAnwIBAqQHEAAAPHCAjAgAAIwJAACMCgAAnwcEAvsIAgAJBgcIpAcJAAAgcICMCAAAIQkCEYwKAACfBwQCCQUGB6QGCQAAIHCAWwoCFLsYCgKkCRcAAFhQgZ8JAgJbCAkTeAcIEowIAACMCQAAnwYEAgkEBQakBRAAADxwgIwGAACMBwAA+wkBAE0JCaoZAAAAWwgJGJ8FBAIJAwQFMAMAhQcAAACCAAEAGgMBAwIDAwMEAwUCAAAAAAAA8D8CAAAAAAAAAAADBgMHBAAgcIACGC1EVPsh+T8CGC1EVPshCUADCAMJBAA0wIADCgQAPHCAAhgtRFT7IRlAApqZmZmZmdk/AjMzMzMzM9M/AgAAAAAAAOA/AwsDDAQAWFCBApqZmZmZmek/Aw0ACAABGAABAgAAAQAAAAAAAQEAAAAAAQAAAAABAAAAAQAAAAAAAAEAAAAAAP4FAAABAAAAAAABAAEAAAAAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAIAAQkAAAAABgAAAAAADsYAAADGAQAApAICAAAEAICMAwAAjAQAAIwFAACfAgQC2QMAABIBAP8SAQH/EgEC/8EAAACCAwIAAwMGAwcEAAQAgAEABA4BGAABAQAAAAAAAQAAAAAABQAAAAAKAQEAAAA0+wEAAE0BAWIAAAAATQEB6QEAAABSAwAAvAEBAwIAAACfAQMCKwEGAKQCBAAAADBAbwQFAFIFAABzAwQFnwICAbwCAToGAAAAnwICAlIBAgC8AgFHBwAAAJ8CAgRkAggAbwkIALwHBv4JAAAAnwcDAg4HAwC8BwZQCgAAAJ8HAgFuAvf/AgAAALwCAZULAAAAnwICAk0DAZsMAAAATQMDhQ0AAABSBQIAvAMDRg4AAACfAwMCvAYD2g8AAACfBgIAvAQBZhAAAACfBAABggECABEDDwMQAwQDEQQAADBAAxIDEwMUAxUDFgMXAwEDGAMGAxkDGgMbACAcARgAAAAAAAAAAAABAQAAAAAAAgAAAAEAAAABAAAAAAEAAP4ABgAAAQAAAAAAAAABAAAAAAACIQAAAAADAAABAgARowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAv8BAgAAAAAAwAIEADACAWwFAAAAwAIGABIAAAAwAgEiBwAAAIIBAgAIAx0EAAAAQAMeAx8GAQMOBgIDHAIBAgEAARgAAAAAAAAAAgABAAAcAAAAEgEAAAAAA/1Vx2qgigIGFq4fcCE53EqNTdAez5Gtaw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:58
-- Luau version 6, Types version 3
-- Time taken: 0.004673 seconds

local module = {
    getUpdateCamera = function() -- Line 4, Named "getUpdateCamera"
        local var3_upvw
        local var4_upvw
        local cframe_upvw = CFrame.Angles(0, 0, 0)
        return function(arg1, arg2) -- Line 8
            --[[ Upvalues[3]:
                [1]: var3_upvw (read and write)
                [2]: var4_upvw (read and write)
                [3]: cframe_upvw (read and write)
            ]]
            if not arg2 then
            else
                if arg2 ~= var3_upvw then
                    local any_GetBoundingBox_result1, any_GetBoundingBox_result2 = arg2:GetBoundingBox()
                    _ = any_GetBoundingBox_result1 -- Setting global
                    var4_upvw = any_GetBoundingBox_result2
                    var3_upvw = arg2
                    local UpDot = var3_upvw:FindFirstChild("UpDot")
                    if UpDot then
                        any_GetBoundingBox_result2 = UpDot.Value
                        local var13 = any_GetBoundingBox_result2
                        if var13 ~= 1 then
                            if UpDot.Value == 0 then
                                var13 = CFrame.Angles((math.pi/2), 0, (math.pi/2))
                            else
                                var13 = CFrame.Angles(0, 0, math.pi)
                            end
                            cframe_upvw = var13
                        end
                    end
                end
                local os_clock_result1 = os.clock()
                arg1.CFrame = CFrame.new(0, 0, 0) * cframe_upvw * CFrame.Angles(0, os_clock_result1 % (-math.pi*2), 0) * CFrame.Angles(math.sin(os_clock_result1 * 0.5) * 0.3 - 0.4, 0, 0) * CFrame.new(0, 0, var4_upvw.Magnitude * 0.8)
            end
        end
    end;
}
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function module.getModel(arg1) -- Line 32
    --[[ Upvalues[1]:
        [1]: ReplicatedStorage_upvr (readonly)
    ]]
    local SOME = ReplicatedStorage_upvr.Resource.HomeItem:FindFirstChild(arg1)
    if not SOME then
        error("No HomeItem exists by name: "..arg1)
    end
    local clone = SOME:Clone()
    for _, v in clone:GetDescendants() do
        if v:IsA("LuaSourceContainer") then
            v:Destroy()
        end
    end
    clone:SetPrimaryPartCFrame(clone.PrimaryPart.CFrame:ToObjectSpace(clone:GetBoundingBox()):Inverse())
    return clone
end
return module