local RunService_upvr = game:GetService("RunService")
local RunConsts_upvr = require(game:GetService("ReplicatedStorage").App.RunConsts)
local module_upvr = {}
local MAIN_WORLD_NAME_upvr = RunConsts_upvr.MAIN_WORLD_NAME
function module_upvr.isStudio() -- Line 14
    return RunService_upvr:IsStudio() and true
end
local function _() -- Line 17, Named "getPlaceId"
    if RunService_upvr:IsStudio() and game.PlaceId == 0 then
        return RunConsts_upvr.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts_upvr.STUDIO_NAME][MAIN_WORLD_NAME_upvr].Default
    end
    return game.PlaceId
end
if not module_upvr.isStudio() then
end
function module_upvr.getBuildCommit() -- Line 31
    local var6 = "816c333"
    if var6 == string.reverse("TIMMOC_DLIUB__") then
        var6 = "UNKNOWN"
    end
    return var6
end
function module_upvr.isTradeWorld() -- Line 39
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_IsStudio_result1_2 = RunService_upvr:IsStudio()
    if any_IsStudio_result1_2 then
        if MAIN_WORLD_NAME_upvr ~= RunConsts_upvr.TRADE_WORLD_NAME then
            any_IsStudio_result1_2 = false
        else
            any_IsStudio_result1_2 = true
        end
        return any_IsStudio_result1_2
    end
    local var8
    if RunService_upvr:IsStudio() and game.PlaceId == 0 then
        var8 = RunConsts_upvr.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts_upvr.STUDIO_NAME][MAIN_WORLD_NAME_upvr].Default
    else
        var8 = game
        var8 = var8.PlaceId
    end
    any_IsStudio_result1_2 = RunConsts_upvr.PLACE_ID_TO_WORLD_MAP[var8]
    var8 = RunConsts_upvr
    var8 = var8.TRADE_WORLD_NAME
    if any_IsStudio_result1_2 ~= var8 then
    else
    end
    return true
end
function module_upvr.isTradingEnabled() -- Line 46
    return module_upvr.isTradeWorld()
end
function module_upvr.isMainWorld() -- Line 49
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_IsStudio_result1 = RunService_upvr:IsStudio()
    if any_IsStudio_result1 then
        if MAIN_WORLD_NAME_upvr ~= RunConsts_upvr.MAIN_WORLD_NAME then
            any_IsStudio_result1 = false
        else
            any_IsStudio_result1 = true
        end
        return any_IsStudio_result1
    end
    local var10
    if RunService_upvr:IsStudio() and game.PlaceId == 0 then
        var10 = RunConsts_upvr.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts_upvr.STUDIO_NAME][MAIN_WORLD_NAME_upvr].Default
    else
        var10 = game
        var10 = var10.PlaceId
    end
    any_IsStudio_result1 = RunConsts_upvr.PLACE_ID_TO_WORLD_MAP[var10]
    var10 = RunConsts_upvr
    var10 = var10.MAIN_WORLD_NAME
    if any_IsStudio_result1 ~= var10 then
    else
    end
    return true
end
function module_upvr.getEnv() -- Line 56
    local var11
    if RunService_upvr:IsStudio() and game.PlaceId == 0 then
        var11 = RunConsts_upvr.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts_upvr.STUDIO_NAME][MAIN_WORLD_NAME_upvr].Default
    else
        var11 = game
        var11 = var11.PlaceId
    end
    return RunConsts_upvr.PLACE_ID_TO_ENV_MAP[var11]
end
function module_upvr.getWorld() -- Line 59
    if RunService_upvr:IsStudio() then
        return MAIN_WORLD_NAME_upvr
    end
    local var12
    if RunService_upvr:IsStudio() and game.PlaceId == 0 then
        var12 = RunConsts_upvr.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts_upvr.STUDIO_NAME][MAIN_WORLD_NAME_upvr].Default
    else
        var12 = game
        var12 = var12.PlaceId
    end
    return RunConsts_upvr.PLACE_ID_TO_WORLD_MAP[var12]
end
function module_upvr.getPlaceType() -- Line 65
    if RunService_upvr:IsStudio() then
        return "Default"
    end
    local var13
    if RunService_upvr:IsStudio() and game.PlaceId == 0 then
        var13 = RunConsts_upvr.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts_upvr.STUDIO_NAME][MAIN_WORLD_NAME_upvr].Default
    else
        var13 = game
        var13 = var13.PlaceId
    end
    return RunConsts_upvr.PLACE_ID_TO_PLACE_TYPE_MAP[var13]
end
function module_upvr.getPlaceIdFromEnvWorld(arg1, arg2, arg3) -- Line 71
    local var22 = RunConsts_upvr.ENV_TO_WORLD_TO_PLACE_IDS_MAP[arg1]
    assert(var22, "Invalid env given")
    local var23 = arg3 or "Default"
    local var24 = true
    if var23 ~= "Default" then
        var24 = true
        if var23 ~= "VoiceChat" then
            var24 = true
            if var23 ~= "Hang" then
                if var23 ~= "Pro" then
                    var24 = false
                else
                    var24 = true
                end
            end
        end
    end
    assert(var24, "Invalid place type: "..tostring(var23))
    local var25 = var22[arg2][var23]
    assert(var25, "Invalid world or no place id")
    return var25
end
if RunService_upvr:IsServer() then
    function module_upvr.isVIPServer() -- Line 84
        if game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0 then
            return true
        end
        return false
    end
end
return module_upvr