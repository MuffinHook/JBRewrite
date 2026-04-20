local var2_upvw
if game:GetService("RunService"):IsServer() then
    var2_upvw = require(game:GetService("ServerStorage").Game.ServerPlayerUtils)
end
local Signal_upvr = require(game:GetService("ReplicatedStorage").Std.Signal)
local pointToObjectSpace_upvr = CFrame.new().pointToObjectSpace
local function CastPoint_upvr(arg1, arg2) -- Line 47, Named "CastPoint"
    local s_5 = arg1.s
    local var21 = pointToObjectSpace_upvr(arg1.c, arg2) + s_5 * 0.5
    local var22 = false
    if 0 <= var21.x then
        var22 = false
        if var21.x < s_5.x then
            var22 = false
            if 0 <= var21.y then
                var22 = false
                if var21.y < s_5.y then
                    var22 = false
                    if 0 <= var21.z then
                        if var21.z >= s_5.z then
                            var22 = false
                        else
                            var22 = true
                        end
                    end
                end
            end
        end
    end
    return var22
end
local Players_upvr = game:GetService("Players")
return {
    MakePrism = function() -- Line 21, Named "MakePrism"
        return {
            c = nil;
            s = nil;
        }
    end;
    MakePrismA = function(arg1, arg2) -- Line 27, Named "MakePrismA"
        local module = {
            c = nil;
            s = nil;
        }
        module.c = arg1
        module.s = arg2
        return module
    end;
    MakeRegion = function() -- Line 34, Named "MakeRegion"
        return {
            Prisms = {};
            Names = {};
            NamesFastIndex = {};
            NameAdded = nil;
            NameRemoving = nil;
            NameAddedSignal = Signal_upvr.new();
            NameRemovedSignal = Signal_upvr.new();
            IsInRegion = nil;
        }
    end;
    Update = function(arg1, arg2) -- Line 84, Named "Update"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local const_number = 1
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [105.9]
        ;({})[nil] = true
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [106.10]
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
    RegionCastPoint = function(arg1, arg2) -- Line 52, Named "RegionCastPoint"
        local Prisms_2 = arg1.Prisms
        for i = 1, #Prisms_2 do
            if CastPoint_upvr(Prisms_2[i], arg2) then
                return true
            end
        end
        return false
    end;
    CastPoint = CastPoint_upvr;
    IsInRegionPlayerName = function(arg1, arg2) -- Line 63, Named "IsInRegionPlayerName"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local SOME = Players_upvr:FindFirstChild(arg2)
        local var31
        if not SOME then return end
        local Character = SOME.Character
        if not Character then
            return false
        end
        local PrimaryPart = Character.PrimaryPart
        if not PrimaryPart then
            return false
        end
        local Humanoid = Character:FindFirstChild("Humanoid")
        if not Humanoid then
            var31 = false
            return var31
        end
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var31 = var31.getLastPosition(SOME)
            var31 = var2_upvw
            return var31
        end
        if not var2_upvw or not decompInlinedCondition() then
            var31 = PrimaryPart.Position
        end
        if 0 < Humanoid.Health then
            local Prisms = arg1.Prisms
            for i_2 = 1, #Prisms do
                if CastPoint_upvr(Prisms[i_2], var31) then
                    return true
                end
            end
        end
        return false
    end;
}