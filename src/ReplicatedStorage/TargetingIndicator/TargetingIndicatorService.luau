local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local Players_upvr = game:GetService("Players")
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
local InventoryItemSystem_upvr = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local InventoryItemUtils_upvr = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local tbl_upvr_2 = {}
local Taser_upvr = require(ReplicatedStorage.Game.ItemConfig.Taser)
local Handcuffs_upvr = require(ReplicatedStorage.Game.ItemConfig.Handcuffs)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunService_upvr = game:GetService("RunService")
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
local TargetingIndicators_upvr = ReplicatedStorage.Resource:FindFirstChild("TargetingIndicators")
local TagUtils_upvr = require(ReplicatedStorage.Tag.TagUtils)
function module.init() -- Line 19
    local function getClosestPlayer_upvr(arg1) -- Line 22, Named "getClosestPlayer"
        if not arg1 then
            return nil, nil, nil, nil
        end
        if not arg1.Character then
            return nil, nil, nil, nil
        end
        if not arg1.Character.PrimaryPart then
            return nil, nil, nil, nil
        end
        local var19
        for _, v in Players_upvr:GetChildren() do
            local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                local Character = v.Character
                return Character
            end
            local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                local var24
                return v.TeamValue.Value == Settings_upvr.Team.Prisoner
            end
            local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var24 = var24.Magnitude
                var24 = Vector3.new(var25.X, 0, var25.Z)
                local var25 = Character.PrimaryPart.Position - arg1.Character.PrimaryPart.Position
                return var19
            end
            if v ~= arg1 and decompInlinedCondition() and Character.PrimaryPart ~= nil and decompInlinedCondition_2() and not Character:GetAttribute("HasHandcuffs") and (not decompInlinedCondition_3() or var25.Magnitude < var19) then
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return v, var25.Magnitude, var24, var25.Y
    end
    InventoryItemSystem_upvr.onInventoryItemUnequipped:Connect(function(arg1) -- Line 59
        local any_getOwner_result1 = InventoryItemUtils_upvr.getOwner(arg1.obj)
        if any_getOwner_result1 then
            local var28 = tbl_upvr_2[any_getOwner_result1.UserId]
            if var28 then
                var28:Destroy()
            end
            return true
        end
        return false
    end)
    local tbl_upvr = {}
    InventoryItemSystem_upvr.onInventoryItemEquipped:Connect(function(arg1) -- Line 72
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local obj = arg1.obj
        local any_getName_result1_upvr = InventoryItemUtils_upvr.getName(obj)
        local var33_upvw
        local var34_upvw
        if any_getName_result1_upvr == "Taser" then
            var33_upvw = Taser_upvr.Range
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if any_getName_result1_upvr == "Handcuffs" then
            var34_upvw = Handcuffs_upvr.ArrestDistance
        else
            return
        end
        local any_getOwner_result1_upvr = InventoryItemUtils_upvr.getOwner(obj)
        if not any_getOwner_result1_upvr then
        else
            local var36 = tbl_upvr_2[any_getOwner_result1_upvr.UserId]
            if var36 then
                var36:Destroy()
            end
            local any_new_result1_upvw = Maid_upvr.new()
            tbl_upvr_2[any_getOwner_result1_upvr.UserId] = any_new_result1_upvw
            local var39_upvw = Handcuffs_upvr.ArrestDistance * 2
            any_new_result1_upvw:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 97
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                local _, _, _, _ = getClosestPlayer_upvr(any_getOwner_result1_upvr)
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                tbl_upvr[any_getOwner_result1_upvr.UserId] = {}
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            end))
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end
    end)
end
return module