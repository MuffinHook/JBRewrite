local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GunRackConsts_upvr = require(script.GunRackConsts)
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local InventoryItemSystem_upvr = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local Players_upvr = game:GetService("Players")
local HomeItemSystem_upvr = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local GunShopUtils_upvr = require(ReplicatedStorage.Game.GunShop.GunShopUtils)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function tbl_upvr.new(arg1) -- Line 15
    local module_upvr = {}
    setmetatable(module_upvr, tbl_upvr)
    module_upvr._obj = arg1._obj
    module_upvr._maid = Maid_upvr.new()
    local function action_upvr(arg1_2, arg2) -- Line 22, Named "action"
        if arg2 then
            module_upvr._obj:FindFirstChild(GunRackConsts_upvr.INTERACT_REMOTE_NAME):FireServer()
            return true
        end
    end
    local function preUpdateFun_upvr(arg1_3) -- Line 30, Named "preUpdateFun"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local any_GetItemName_result1 = module_upvr:GetItemName()
        local _1 = InventoryItemSystem_upvr.getEquippedFor(Players_upvr.LocalPlayer)[1]
        if _1 then
        end
        local var14
        if not GunRackConsts_upvr.WHITELIST[_1:GetName()] then
            var14 = nil
        end
        if any_GetItemName_result1 and _1 and any_GetItemName_result1 == var14 then
        end
        if var14 and any_GetItemName_result1 then
            arg1_3.Duration = 0.5
            arg1_3.Timed = true
        else
            arg1_3.Timed = false
        end
        if var14 and any_GetItemName_result1 then
            arg1_3.Name = string.format("Replace %s with %s", GunShopUtils_upvr.getTranslatedTitleFromName(any_GetItemName_result1), GunShopUtils_upvr.getTranslatedTitleFromName(var14))
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        if any_GetItemName_result1 then
            arg1_3.Name = string.format("Grab %s", GunShopUtils_upvr.getTranslatedTitleFromName(any_GetItemName_result1))
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if var14 then
            arg1_3.Name = string.format("Mount %s", GunShopUtils_upvr.getTranslatedTitleFromName(var14))
        else
        end
        arg1_3.Enabled = nil
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    module_upvr._maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(module_upvr._obj, "Prompt", function(arg1_4, arg2) -- Line 65
        local tbl = {}
        tbl.Part = arg1_4
        tbl.ValidRoot = module_upvr._obj
        tbl.Name = "Interact"
        tbl.Timed = false
        tbl.Dist = 10
        tbl.Callback = action_upvr
        tbl.PreUpdateFun = preUpdateFun_upvr
        tbl.PreUpdatePeriod = 0.5
        CircleAction_upvr.Add(tbl, arg1_4)
        arg2:GiveTask(function() -- Line 78
            CircleAction_upvr.Remove(arg1_4)
        end)
    end))
    return module_upvr
end
function tbl_upvr.GetItemName(arg1) -- Line 85
    return arg1._obj:GetAttribute(GunRackConsts_upvr.ITEM_NAME_ATTR_NAME)
end
function tbl_upvr.Destroy(arg1) -- Line 88
    local _maid = arg1._maid
    local var20
    if _maid == nil then
        var20 = false
    else
        var20 = true
    end
    assert(var20)
    arg1._maid = nil
    _maid:Destroy()
end
return {
    setup = function(arg1) -- Line 96, Named "setup"
        local any_new_result1 = tbl_upvr.new(arg1)
        arg1._maid:GiveTask(any_new_result1)
        arg1._gunRack = any_new_result1
    end;
}