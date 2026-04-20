local module_upvr = {}
function module_upvr.addAbsoluteProbsToRewardDataFromRarityProbs(arg1, arg2) -- Line 5
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
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
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
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
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        local var45 = ({})[v_6.RarityId]
        if not var45 then
            error("No probability for rarity: "..v_6.RarityId)
        elseif var45 == 0 then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            warn("Rarity has 0 probability but a reward with given rarity exists: "..v_6.RarityId)
        end
    end
end
return module_upvr