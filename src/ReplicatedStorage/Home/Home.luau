local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BinderUtils_upvr = require(ReplicatedStorage.Std.Binder.BinderUtils)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
local HomeConsts_upvr = require(script.Parent.HomeConsts)
local function _(arg1, arg2, arg3) -- Line 19, Named "isPointInPrism"
    local var15 = arg2:pointToObjectSpace(arg1) + arg3 * 0.5
    local var16 = false
    if 0 <= var15.x then
        var16 = false
        if var15.x <= arg3.x then
            var16 = false
            if 0 <= var15.y then
                var16 = false
                if var15.y <= arg3.y then
                    var16 = false
                    if 0 <= var15.z then
                        if var15.z > arg3.z then
                            var16 = false
                        else
                            var16 = true
                        end
                    end
                end
            end
        end
    end
    return var16
end
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
module_upvr_2.__ClassName = "Home"
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local HomeSaleUISystem_upvr = require(script.Parent.HomeUI.HomeSaleUISystem)
local Confirmation_upvr = require(ReplicatedStorage.Module.Confirmation)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
function module_upvr_2.new(arg1) -- Line 27
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr._maid = Maid_upvr.new()
    module_upvr._obj = arg1
    module_upvr._priceValue = arg1:WaitForChild(HomeConsts_upvr.PRICE_VALUE_NAME)
    module_upvr._homeItemNewRemote = arg1:WaitForChild(HomeConsts_upvr.HOME_ITEM_NEW_REMOTE_NAME)
    module_upvr._homePurchaseRemote = arg1:WaitForChild(HomeConsts_upvr.HOME_PURCHASE_REMOTE_NAME)
    module_upvr._doorInteractRemote = arg1:WaitForChild(HomeConsts_upvr.DOOR_INTERACT_REMOTE_NAME)
    module_upvr._updateCustomizingRemote = arg1:WaitForChild(HomeConsts_upvr.UPDATE_CUSTOMIZING_REMOTE_NAME)
    module_upvr._homeClaimRemote = arg1:WaitForChild(HomeConsts_upvr.HOME_CLAIM_REMOTE_NAME)
    module_upvr._homeUnclaimRemote = arg1:WaitForChild(HomeConsts_upvr.HOME_UNCLAIM_REMOTE_NAME)
    module_upvr._permissionsFolder = arg1:WaitForChild(HomeConsts_upvr.PERMISSIONS_FOLDER_NAME)
    module_upvr._setSavedSettingRemote = arg1:WaitForChild(HomeConsts_upvr.SET_SAVED_SETTING_REMOTE_NAME)
    local function doIOwnThisHomeName() -- Line 44, Named "doIOwnThisHomeName"
        local SOME = LocalPlayer_upvr:FindFirstChild(HomeConsts_upvr.HOMES_OWNED_FOLDER_NAME)
        local var24
        if not SOME then
            var24 = "Player does not have a homes owned folder"
            error(var24)
            return
        end
        if SOME:FindFirstChild(module_upvr._obj.Name) == nil then
            var24 = false
        else
            var24 = true
        end
        return var24
    end
    local Sign_upvr = module_upvr._obj:WaitForChild("SaleSign"):WaitForChild("Sign")
    local salePromptMaid
    local function closeSalePrompt()
        if salePromptMaid then
            salePromptMaid:Destroy()
            salePromptMaid = nil
        end
        if HomeSaleUISystem_upvr.gui and HomeSaleUISystem_upvr.isOpen() then
            HomeSaleUISystem_upvr.close()
        end
    end
    local function action(arg1_2, arg2) -- Line 56
        -- Decomp Error: Reconstructed sale-sign action after Konstant failed control-flow analysis.
        -- Logic Change: Buy/claim/unclaim branch order is inferred from the home remotes and sale UI API.
        if not arg2 then
            return false
        end

        local ownerId = module_upvr:GetOwnerId()
        if ownerId == LocalPlayer_upvr.UserId then
            local confirmation = Confirmation_upvr.new("Unclaim this home?")
            confirmation.Maid:GiveTask(confirmation.OnYes:Connect(function()
                module_upvr._homeUnclaimRemote:FireServer()
            end))
            return true
        end

        if ownerId ~= nil then
            return false
        end

        if doIOwnThisHomeName() then
            module_upvr._homeClaimRemote:FireServer()
            return true
        end

        if salePromptMaid then
            return false
        end

        if HomeSaleUISystem_upvr.gui then
            salePromptMaid = Maid_upvr.new()
            HomeSaleUISystem_upvr.setPrice(module_upvr._priceValue.Value)
            HomeSaleUISystem_upvr.open()
            salePromptMaid:GiveTask(HomeSaleUISystem_upvr.getOnClickYesSignal():Connect(function()
                module_upvr._homePurchaseRemote:FireServer()
                closeSalePrompt()
            end))
            salePromptMaid:GiveTask(HomeSaleUISystem_upvr.getOnClickNoSignal():Connect(closeSalePrompt))
            salePromptMaid:GiveTask(HomeSaleUISystem_upvr.getOnClosedSignal():Connect(function()
                if salePromptMaid then
                    salePromptMaid:Destroy()
                    salePromptMaid = nil
                end
            end))
            return true
        end

        local confirmation = Confirmation_upvr.new("Buy this home?")
        confirmation.Maid:GiveTask(confirmation.OnYes:Connect(function()
            module_upvr._homePurchaseRemote:FireServer()
        end))
        return true
    end
    local function preUpdateFun(arg1_3) -- Line 94
        -- Decomp Error: Reconstructed sale-sign pre-update after Konstant failed to generate this function.
        local ownerId = module_upvr:GetOwnerId()
        arg1_3.Timed = false
        if ownerId == LocalPlayer_upvr.UserId then
            arg1_3.Enabled = true
            arg1_3.Name = "Unclaim"
            return
        end
        if ownerId ~= nil then
            arg1_3.Enabled = false
            arg1_3.Name = "Owned"
            return
        end
        arg1_3.Enabled = true
        if doIOwnThisHomeName() then
            arg1_3.Name = "Claim"
        else
            arg1_3.Name = "Buy"
            if HomeSaleUISystem_upvr.gui then
                HomeSaleUISystem_upvr.setPrice(module_upvr._priceValue.Value)
            end
        end
    end
    CircleAction_upvr.Add({
        Part = Sign_upvr;
        Name = "Buy";
        NoRay = true;
        Timed = false;
        Dist = 16;
        Callback = action;
        PreUpdateFun = preUpdateFun;
        PreUpdatePeriod = 0.1;
    }, Sign_upvr)
    module_upvr._maid:GiveTask(function() -- Line 125
        CircleAction_upvr.Remove(Sign_upvr)
        closeSalePrompt()
    end)
    module_upvr._maid:GiveTask(RxInstanceUtils_upvr.observeChildrenNamed(module_upvr._obj, "Door", function(arg1_4, arg2) -- Line 129
        module_upvr:_receiveDoorModel(arg1_4)
    end))
    return module_upvr
end
local DoorUtils_upvr = require(ReplicatedStorage.Door2.DoorUtils)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
function module_upvr_2._receiveDoorModel(arg1, arg2) -- Line 135
    local Door_upvr = DoorUtils_upvr.getInnerModel(arg2):FindFirstChild("Door")
    assert(Door_upvr)
    CircleAction_upvr.Add({
        Part = Door_upvr;
        Name = "Open";
        NoRay = true;
        Timed = false;
        Dist = 10;
        Callback = function(arg1_5, arg2_2) -- Line 139, Named "action"
            if arg2_2 then
                arg1._doorInteractRemote:FireServer(arg2, true)
                return true
            end
            if arg1_5.Timed then
                arg1._doorInteractRemote:FireServer(arg2, false)
            end
            return false
        end;
        PreUpdateFun = function(arg1_6) -- Line 150, Named "preUpdateFun"
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local var34
            if DoorUtils_upvr.getPctOpen(arg2) == 0 then
                var34 = false
            else
                var34 = true
            end
            local any_getRootPart_result1 = PlayerUtils_upvr.getRootPart(LocalPlayer_upvr)
            if not any_getRootPart_result1 then
            else
                local var36 = false
                local var37
                if arg1:HasPermissionToEnter(LocalPlayer_upvr) or arg1:IsPointInStandingPrism(any_getRootPart_result1.Position) then
                    var36 = true
                    arg1_6.Timed = false
                    if var34 then
                    else
                    end
                    arg1_6.Name = "Open"
                else
                    local any_GetOwnerId_result1 = arg1:GetOwnerId()
                    var37 = any_GetOwnerId_result1
                    if var37 then
                        var37 = Players_upvr:GetPlayerByUserId(any_GetOwnerId_result1)
                        local var39 = var37
                    end
                    if var39 then
                    end
                    if any_GetOwnerId_result1 ~= nil and PlayerUtils_upvr.getTeamId(var39) ~= PlayerUtils_upvr.getTeamId(LocalPlayer_upvr) then
                        var36 = true
                        arg1_6.Timed = true
                        arg1_6.Duration = HomeConsts_upvr.POLICE_BUST_DOOR_DURATION
                        arg1_6.Name = "Break In"
                    else
                        var36 = false
                    end
                end
                arg1_6.Enabled = var36
            end
        end;
        PreUpdatePeriod = 0.5;
    }, Door_upvr)
    arg1._maid:GiveTask(function() -- Line 194
        CircleAction_upvr.Remove(Door_upvr)
    end)
end
function module_upvr_2.GetObj(arg1) -- Line 198
    return arg1._obj
end
local var42_upvw
function module_upvr_2.GetHomeItems(arg1) -- Line 201
    if not var42_upvw then
        var42_upvw = require(script.Parent.HomeItem.HomeItemBinder)
    end
    return BinderUtils_upvr.getChildren(var42_upvw, arg1._obj)
end
function module_upvr_2.AttemptCreateHomeItem(arg1, arg2) -- Line 207
    if arg2 == nil then
    else
    end
    assert(true)
    arg1._homeItemNewRemote:FireServer(arg2)
end
local SurfaceBinder_upvr = require(script.Parent.Surface.SurfaceBinder)
function module_upvr_2.GetSurfaces(arg1) -- Line 211
    return BinderUtils_upvr.getDescendants(SurfaceBinder_upvr, arg1._obj)
end
function module_upvr_2.IsPointInStandingPrism(arg1, arg2) -- Line 214
    for _, v in ipairs(arg1:GetSurfaces()) do
        local any_GetStandingPrism_result1_4, any_GetStandingPrism_result2_4 = v:GetStandingPrism()
        if any_GetStandingPrism_result1_4.UpVector:Dot(Vector3.new(0, 1, 0)) >= -0.5 then
            local var97 = any_GetStandingPrism_result1_4:pointToObjectSpace(arg2) + any_GetStandingPrism_result2_4 * 0.5
            local var98 = false
            if 0 <= var97.x then
                var98 = false
                if var97.x <= any_GetStandingPrism_result2_4.x then
                    var98 = false
                    if 0 <= var97.y then
                        var98 = false
                        if var97.y <= any_GetStandingPrism_result2_4.y then
                            var98 = false
                            if 0 <= var97.z then
                                if var97.z > any_GetStandingPrism_result2_4.z then
                                    var98 = false
                                else
                                    var98 = true
                                end
                            end
                        end
                    end
                end
            end
            if var98 then
                return true
            end
        end
    end
    return false
end
function module_upvr_2.GetArmedVault(arg1) -- Line 228
    for _, v_2 in ipairs(arg1:GetHomeItems()) do
        local _vault = v_2._vault
        if _vault and _vault:GetIsVaultArmed() then
            return _vault
        end
    end
    return nil
end
function module_upvr_2.ReplicateCustomizing(arg1, arg2) -- Line 238
    arg1._updateCustomizingRemote:FireServer(arg2)
end
function module_upvr_2.GetOwnerId(arg1) -- Line 241
    return arg1._obj:GetAttribute(HomeConsts_upvr.OWNER_ID_ATTR_NAME)
end
function module_upvr_2._getPlayerPermObj(arg1, arg2) -- Line 244
    local SOME_2 = arg1._permissionsFolder:FindFirstChild(tostring(arg2.UserId))
    if not SOME_2 then
        return nil
    end
    return SOME_2
end
function module_upvr_2.HasPermissionToEnter(arg1, arg2) -- Line 252
    local any__getPlayerPermObj_result1 = arg1:_getPlayerPermObj(arg2)
    local var107
    if not any__getPlayerPermObj_result1 then
        var107 = false
        return var107
    end
    if any__getPlayerPermObj_result1:GetAttribute(HomeConsts_upvr.PERMISSION_CAN_ENTER_ATTR_NAME) ~= true then
        var107 = false
    else
        var107 = true
    end
    return var107
end
function module_upvr_2.HasPermissionToEdit(arg1, arg2) -- Line 259
    local any__getPlayerPermObj_result1_2 = arg1:_getPlayerPermObj(arg2)
    local var109
    if not any__getPlayerPermObj_result1_2 then
        var109 = false
        return var109
    end
    if any__getPlayerPermObj_result1_2:GetAttribute(HomeConsts_upvr.PERMISSION_CAN_EDIT_ATTR_NAME) ~= true then
        var109 = false
    else
        var109 = true
    end
    return var109
end
function module_upvr_2.SetSavedSetting(arg1, arg2, arg3) -- Line 266
    arg1._setSavedSettingRemote:FireServer(arg2, arg3)
end
function module_upvr_2.Destroy(arg1) -- Line 269
    local _maid = arg1._maid
    local var111
    if _maid == nil then
        var111 = false
    else
        var111 = true
    end
    assert(var111)
    arg1._maid = nil
    _maid:Destroy()
end
return module_upvr_2
