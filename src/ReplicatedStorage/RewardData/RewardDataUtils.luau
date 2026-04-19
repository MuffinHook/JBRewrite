-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQEnZhbGlkYXRlUmV3YXJkRGF0YQhSYXJpdHlJZBNBYnNvbHV0ZVByb2JhYmlsaXR5K2FkZEFic29sdXRlUHJvYnNUb1Jld2FyZERhdGFGcm9tUmFyaXR5UHJvYnMaSW52YWxpZCByYXJpdHkgcHJvYmFiaWxpdHkGYXNzZXJ0BWVycm9yGk5vIGl0ZW1zIG9mIHJhcml0eSBleGlzdDogBHdhcm4QSXRlbXMgb2YgcmFyaXR5ICggZXhpc3QgYnV0IHRoYXQgcmFyaXR5IGhhcyAwIHByb2JhYmlsaXR5BG1hdGgDYWJzJEludmFsaWQgdG90YWwgcmFyaXR5IHByb2JhYmlsaXRpZXM6IBtObyBwcm9iYWJpbGl0eSBmb3IgcmFyaXR5OiBAUmFyaXR5IGhhcyAwIHByb2JhYmlsaXR5IGJ1dCBhIHJld2FyZCB3aXRoIGdpdmVuIHJhcml0eSBleGlzdHM6IAADCwIBAAAANPsCAABNAgLIAAAAAFIDAABSBAEAnwIDAf8CAAAAAAAAUgMAAMYEAADGBQAAZAMNAE0JB/MBAAAAhwgCCSsIBABNCAfzAQAAAIwJAABqCQIITQgH8wEAAACHCQIIlQkJAmoJAghuA/L/AgAAAP8DAAAAAAAAUgQBAMYFAADGBgAAZAQFAIcJAgcOCQMAhwoCB+wJCApqCQMHbgT6/wIAAABSBAAAxgUAAMYGAABkBAUATQoI8wEAAACHCQMKMAkISAMAAABuBPr/AgAAAIIAAQAEAwEDAgIAAAAAAADwPwMDAAUEARgAAAAAAAACAAEAAAABAAAAAQAAAAIAAAAA/AAGAAIAAAABAAEAAP4ABgAAAAEAAAEA/gAEBgAAAAAQAgAAAABy/wIAAAAAAABSAwAAxgQAAMYFAABkAw0ATQkH8wAAAACHCAIJKwgEAE0IB/MAAAAAjAkAAGoJAghNCAfzAAAAAIcJAgiVCQkBagkCCG4D8v8CAAAA/wMAAAAAAACMBAAAUgUBAMYGAADGBwAAZAUqAKkLAACMDAAAfQwGAAkAAACMDGQA1AkCAAwAAACpCwABqQsBAIEBCwQCAAAAbwwCAKQKBAAAADBAnwoDAQ0JCQAFAAAAhwoCCCsKBgCkCgcAAABgQG8MCABSDQgAcwsMDZ8KAgGHCgIIDgoJAA0JCAAFAACApAoKAAAAkEBvDAsAUg0IAG8ODABzCwwOnwoCAYcKAggOCgQAhwsCCOwKCQtqCgMIQwQECW4F1f8CAAAAeAYEDbsCBgKkBRAAADzggJ8FAgJvBhEAYAYHAAUAAACkBQcAAABgQG8HEgBSCAQAcwYHCJ8FAgFSBQAAxgYAAMYHAABkBRUATQsJ8wAAAACHCgMLTQsJ8wAAAAArCgcApAwHAAAAYEBvDhMAUg8LAHMNDg+fDAIBZQAIAA0KBwAFAACApAwKAAAAkEBvDhQAUg8LAHMNDg+fDAIBbgXq/wIAAACCAAEAFQMCAgAAAAAAAPA/AwUDBgQAADBAAgAAAAAAAAAAAwcEAABgQAMIAwkEAACQQAMKAwsCAAAAAAAAWUADDAMNBAA84IACLUMc6+I2Gj8DDgMPAxAAHAEBGAAAAQAAAAEAAAABAAAAAgAAAAD8AAYAAgIAAAABAAAAAAAAAAAAAAAAAAABAAAAAQAAAAAAAwAAAAEAAAAAAAADAAEAAAH0ABAAAAAAAAAAAQAAAAAAAwAAAAEAAAEAAQEAAAAAAAABAAEAAAAAAPoACR0AAAAAAgAAAQIAC6MAAAD/AAIAAAAAAMABAAASAAAAMAEAKAEAAADAAQIAMAEAyAMAAACCAAIABAYAAwQGAQMBAgABAQABGAAAAAQAAAAXAAAqAQAAAAACbHGfPdD9AISYBAGeEYdlBRxpiEletfU8

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:24
-- Luau version 6, Types version 3
-- Time taken: 0.004816 seconds

local module_upvr = {}
function module_upvr.addAbsoluteProbsToRewardDataFromRarityProbs(arg1, arg2) -- Line 5
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
    module_upvr.validateRewardData(arg1, arg2)
    local tbl = {}
    for _, v in arg1 do
        if not tbl[v.RarityId] then
            tbl[v.RarityId] = 0
        end
        local RarityId = v.RarityId
        tbl[RarityId] += 1
    end
    for i_2, v_2 in arg2 do
        if tbl[i_2] then
            ({})[i_2] = v_2 / tbl[i_2]
        end
    end
    for _, v_3 in arg1 do
        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
        v_3.AbsoluteProbability = ({})[v_3.RarityId]
        local _
    end
end
function module_upvr.validateRewardData(arg1, arg2) -- Line 28
    local tbl_2 = {}
    local var42
    for _, v_4 in arg1, var42 do
        if not tbl_2[v_4.RarityId] then
            tbl_2[v_4.RarityId] = 0
        end
        local RarityId_2 = v_4.RarityId
        tbl_2[RarityId_2] += 1
    end
    var42 = 0
    for i_5, v_5 in arg2 do
        local var44 = false
        if 0 <= v_5 then
            if v_5 > 100 then
                var44 = false
            else
                var44 = true
            end
        end
        assert(var44, "Invalid rarity probability")
        if v_5 ~= 0 and not tbl_2[i_5] then
            var44 = "No items of rarity exist: "..i_5
            error(var44)
        end
        if tbl_2[i_5] and v_5 == 0 then
            var44 = "Items of rarity "..i_5.." exist but that rarity has 0 probability"
            warn(var44)
        end
        if tbl_2[i_5] then
            var44 = tbl_2[i_5]
            ;({})[i_5] = v_5 / var44
            var42 += v_5
        end
    end
    if 0.0001 < math.abs(var42 - 100) then
        i_5 = var42
        error("Invalid total rarity probabilities: "..i_5)
    end
    for _, v_6 in arg1 do
        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
        local var45 = ({})[v_6.RarityId]
        if not var45 then
            error("No probability for rarity: "..v_6.RarityId)
        elseif var45 == 0 then
            -- KONSTANTERROR: Expression was reused, decompilation is incorrect
            warn("Rarity has 0 probability but a reward with given rarity exists: "..v_6.RarityId)
        end
    end
end
return module_upvr