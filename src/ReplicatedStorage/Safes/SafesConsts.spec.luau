-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUCVNBRkVfREFUQQpSZXdhcmREYXRhBXBjYWxsBHdhcm4GZXhwZWN0AnRvBWVxdWFsAml0CWFsbCBleGlzdAdyZXF1aXJlBnNjcmlwdAZQYXJlbnQLU2FmZXNDb25zdHMNUmV3YXJkU3Bpbm5lchpnZXRJdGVtUHJvcHNGcm9tUmV3YXJkRGF0YQhkZXNjcmliZQpzYWZlIGl0ZW1zBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQAFAgACAAAABPsAAAD7AQEAnwACAYIAAQAAAA4AARgAAAABDwAAAAAQAAIAAAAojAAAAPsBAABNAQEdAAAAAMYCAADGAwAAZAEUAE0GBfYBAAAAUgcGAMYIAADGCQAAZAcMAKQMAwAAACBA2Q0AABICAQASAAsAnwwCAysMBQCkDgUAAABAQFIPDQCfDgIBlQAABm4H8/8CAAAAbgHr/wIAAACkAQgAAABwQFICAACfAQICTQEBkgkAAABNAQF7CgAAAIwCAACfAQIBggABAAsDAQMCAwMEAAAgQAMEBAAAQEACAAAAAAAA8D8DBQQAAHBAAwYDBwEACAABGAABAAAAAAABAAIAAAABAAAAAAADAQAAAAH6AP0ADQAAAAAAAAAAAAEJAAAAAAMAAgAAAAikAAEAAAAAQG8BAgDZAgAAEgIAABICAQCfAAMBggABAAMDCAQAAABAAwkBAQcAARgAAAAAAAAAEQgAAAAABQABAAAAGaQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAXMFAAAAnwACAqQBAQAAAABA+wIAAE0CArcGAAAATQIC5wcAAACfAQICpAIJAAAAgEBvAwoA2QQAABIAAAASAAEAnwIDAYIAAQALAwoEAAAAQAMLBAAAIEADDAMNAw4DDwMQBAAAgEADEQECAwABGAAAAAAAAAAAAAEAAAAAAAAAAgAAAAAAABMEAAAAAAMAAAECAAqjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCwAEEABIAAACCAQIABQMSBAAAAEADEwMUBgMBAwEAARgAAAAAAAAAAgAAAQAAAAAE0JtOWSUZ7ElEyCynpxqdmqCDWS3iXyRY

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:38
-- Luau version 6, Types version 3
-- Time taken: 0.002269 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
return function() -- Line 3
    --[[ Upvalues[1]:
        [1]: ReplicatedStorage_upvr (readonly)
    ]]
    local SafesConsts_upvr = require(script.Parent.SafesConsts)
    local getItemPropsFromRewardData_upvr = require(ReplicatedStorage_upvr.RewardSpinner.getItemPropsFromRewardData)
    describe("safe items", function() -- Line 7
        --[[ Upvalues[2]:
            [1]: SafesConsts_upvr (readonly)
            [2]: getItemPropsFromRewardData_upvr (readonly)
        ]]
        it("all exist", function() -- Line 8
            --[[ Upvalues[2]:
                [1]: SafesConsts_upvr (copied, readonly)
                [2]: getItemPropsFromRewardData_upvr (copied, readonly)
            ]]
            local var15
            for _, v in SafesConsts_upvr.SAFE_DATA do
                for _, v_2_upvr in v.RewardData do
                    local pcall_result1, pcall_result2 = pcall(function() -- Line 14
                        --[[ Upvalues[2]:
                            [1]: getItemPropsFromRewardData_upvr (copied, readonly)
                            [2]: v_2_upvr (readonly)
                        ]]
                        getItemPropsFromRewardData_upvr(v_2_upvr)
                    end)
                    if not pcall_result1 then
                        warn(pcall_result2)
                        var15 += 1
                    end
                end
            end
            expect(var15).to.equal(0)
        end)
    end)
end