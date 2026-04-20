local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Signal = require(ReplicatedStorage_upvr.Std.Signal)
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local homeStore_upvr = require(ReplicatedStorage_upvr.Home.homeStore)
local HomeItemBinder_upvr = require(script.Parent.HomeItemBinder)
local HomeSystem_upvr = require(script.Parent.Parent.HomeSystem)
local HomeItemConsts_upvr = require(script.Parent.HomeItemConsts)
local module_upvr = {
    _inventory = {};
    _maid = Maid_upvr.new();
    onCustomizeStarted = Signal.new();
    onCustomizeEnded = Signal.new();
    onAttemptPlaceItem = Signal.new();
    onAttemptDeleteItem = Signal.new();
}
local createElement_upvr = Roact_upvr.createElement
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
local Utils_upvr = require(ReplicatedStorage_upvr.EzUi.Utils)
local HomeApp_upvr = require(ReplicatedStorage_upvr.Home.UI.HomeApp)
local CashBuyUI_upvr = require(ReplicatedStorage_upvr.Game.CashBuyUI)
local Players_upvr = game:GetService("Players")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local BigButtonService_upvr = require(ReplicatedStorage_upvr.App.BigButtonService)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local HomeConsts_upvr = require(ReplicatedStorage_upvr.Home.HomeConsts)
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
function module_upvr.init() -- Line 33
    HomeItemBinder_upvr:Start()
    local tbl = {}
    local tbl_8 = {}
    local tbl_2 = {}
    local var27 = 1
    tbl_2.BackgroundTransparency = var27
    if Utils_upvr.isSmallScreen() then
        var27 = UDim2.fromScale(0.7, 0.5)
    else
        var27 = UDim2.fromScale(0.6, 0.5)
    end
    tbl_2.Size = var27
    tbl_2.Position = UDim2.fromScale(0.5, 0.08)
    tbl_2.AnchorPoint = Vector2.new(0.5, 0)
    tbl_8.HomeContainer = createElement_upvr("Frame", tbl_2, {
        UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 3;
        });
        HomeApp = createElement_upvr(HomeApp_upvr, {
            aspectRatio = 3;
            verticalPaddingRatio = 128;
            attemptPlaceItem = function(arg1) -- Line 58, Named "attemptPlaceItem"
                if arg1.module == "HomeItem" then
                    module_upvr.onAttemptPlaceItem:Fire(arg1)
                else
                    module_upvr.attemptEquip(arg1.module, arg1.name)
                end
            end;
            attemptPreviewItem = function(arg1) -- Line 65, Named "attemptPreviewItem"
                module_upvr.attemptPreview(arg1.module, arg1.name)
            end;
            attemptPurchaseItem = function(arg1) -- Line 68, Named "attemptPurchaseItem"
                module_upvr.attemptPurchase(arg1.module, arg1.name)
            end;
            attemptDeleteItem = function() -- Line 71, Named "attemptDeleteItem"
                module_upvr.onAttemptDeleteItem:Fire()
            end;
            promptCashPurchase = function() -- Line 74, Named "promptCashPurchase"
                homeStore_upvr:dispatch({
                    type = "setVisible";
                    value = false;
                })
                CashBuyUI_upvr.Open()
            end;
            onSettingChanged = function(arg1, arg2) -- Line 83, Named "onSettingChanged"
                HomeSystem_upvr.queryCurrentStandingHome():SetSavedSetting(arg1, arg2)
            end;
            exit = function() -- Line 87, Named "exit"
                homeStore_upvr:dispatch({
                    type = "setVisible";
                    value = false;
                })
                local any_queryCurrentStandingHome_result1_2 = HomeSystem_upvr.queryCurrentStandingHome()
                if any_queryCurrentStandingHome_result1_2 then
                    any_queryCurrentStandingHome_result1_2:ReplicateCustomizing(false)
                    module_upvr.onCustomizeEnded:Fire(any_queryCurrentStandingHome_result1_2)
                end
            end;
        });
    })
    tbl[1] = Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
        store = homeStore_upvr;
    }, tbl_8)
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ResetOnSpawn = false;
        IgnoreGuiInset = true;
        DisplayOrder = 8;
    }, tbl), Players_upvr.LocalPlayer.PlayerGui, "HomeItemGui")
    module_upvr._maid:GiveTask(function() -- Line 105
        Roact_upvr.unmount(any_mount_result1_upvr)
    end)
    local tbl_5_upvr = {
        name = "Home";
        imageId = 13218368809;
        displayOrder = 100;
        enabled = false;
        onClick = function() -- Line 114, Named "onClick"
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
            local var38 = not homeStore_upvr:getState().visible
            homeStore_upvr:dispatch({
                type = "setVisible";
                value = var38;
            })
            local any_queryCurrentStandingHome_result1 = HomeSystem_upvr.queryCurrentStandingHome()
            if any_queryCurrentStandingHome_result1 then
                any_queryCurrentStandingHome_result1:ReplicateCustomizing(var38)
                if var38 then
                    module_upvr.onCustomizeStarted:Fire()
                    return
                end
                module_upvr.onCustomizeEnded:Fire(any_queryCurrentStandingHome_result1)
            end
        end;
    }
    BigButtonService_upvr.add(tbl_5_upvr)
    local function updateButtonVisibility_upvr(arg1) -- Line 137, Named "updateButtonVisibility"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var47 = HomeSystem_upvr.queryCurrentStandingHome()
        if var47 then
            var47 = HomeSystem_upvr.queryCurrentStandingHome():HasPermissionToEdit(Players_upvr.LocalPlayer)
        end
        if var47 ~= true then
            local _ = false
            -- KONSTANTWARNING: Skipped task `defvar` above
        else
        end
        local enabled = tbl_5_upvr.enabled
        if true == enabled then
        else
        end
        if not true then
        else
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            tbl_5_upvr.enabled = true
            BigButtonService_upvr.triggerUpdate:Fire()
            if enabled then
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                if not true then
                    arg1:ReplicateCustomizing(false)
                    module_upvr.onCustomizeEnded:Fire(arg1)
                    homeStore_upvr:dispatch({
                        type = "setVisible";
                        value = false;
                    })
                end
            end
        end
    end
    local any_new_result1_upvr = Maid_upvr.new()
    HomeSystem_upvr.onEntered:Connect(function(arg1) -- Line 162
        any_new_result1_upvr:DoCleaning()
        updateButtonVisibility_upvr(arg1)
        any_new_result1_upvr:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 165
            updateButtonVisibility_upvr(arg1)
        end))
    end)
    HomeSystem_upvr.onExited:Connect(function(arg1) -- Line 169
        any_new_result1_upvr:DoCleaning()
        updateButtonVisibility_upvr(arg1)
    end)
    HomeSystem_upvr.onEntered:Connect(function(arg1) -- Line 174
        local tbl_7 = {
            type = "setHome";
        }
        tbl_7.value = arg1
        homeStore_upvr:dispatch(tbl_7)
    end)
    HomeSystem_upvr.onExited:Connect(function() -- Line 180
        homeStore_upvr:dispatch({
            type = "setHome";
            value = nil;
        })
    end)
    module_upvr.onCustomizeEnded:Connect(function(arg1) -- Line 187
        module_upvr.resetHomeCustomizationToEquipped(arg1)
    end)
    HomeSystem_upvr.onEntered:Connect(function(arg1) -- Line 192
        RxInstanceUtils_upvr.observeChildren(arg1._obj:FindFirstChild(HomeConsts_upvr.SETTINGS_FOLDER_NAME), function(arg1_2, arg2) -- Line 195
            homeStore_upvr:dispatch({
                type = "setSavedSetting";
                key = arg1_2.Name;
                value = arg1_2.Value;
            })
            arg2:GiveTask(arg1_2:GetPropertyChangedSignal("Value"):Connect(function() -- Line 196, Named "update"
                homeStore_upvr:dispatch({
                    type = "setSavedSetting";
                    key = arg1_2.Name;
                    value = arg1_2.Value;
                })
            end))
        end)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, HomeItemConsts_upvr.UPDATE_INVENTORY_REMOTE_NAME):andThen(function(arg1) -- Line 209
        arg1.OnClientEvent:Connect(function(arg1_3) -- Line 210
            local tbl_4 = {
                type = "setInventory";
            }
            tbl_4.value = arg1_3
            homeStore_upvr:dispatch(tbl_4)
        end)
    end):catch(warn)
    waitForChild_upvr(ReplicatedStorage_upvr, HomeItemConsts_upvr.UPDATE_EQUIPPED_REMOTE_NAME):andThen(function(arg1) -- Line 220
        arg1.OnClientEvent:Connect(function(arg1_4) -- Line 221
            local tbl_6 = {
                type = "setEquipped";
            }
            tbl_6.value = arg1_4
            homeStore_upvr:dispatch(tbl_6)
        end)
    end):catch(warn)
    local function updateQuantityPlaced_upvr() -- Line 230, Named "updateQuantityPlaced"
        homeStore_upvr:dispatch({
            type = "setQuantityPlaced";
            value = module_upvr.getQuantityPlaced(Players_upvr.LocalPlayer);
        })
    end
    homeStore_upvr:dispatch({
        type = "setQuantityPlaced";
        value = module_upvr.getQuantityPlaced(Players_upvr.LocalPlayer);
    })
    HomeItemBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 239
        homeStore_upvr:dispatch({
            type = "setQuantityPlaced";
            value = module_upvr.getQuantityPlaced(Players_upvr.LocalPlayer);
        })
        arg1._maid:GiveTask(updateQuantityPlaced_upvr)
    end)
end
function module_upvr.getQuantityPlaced(arg1) -- Line 245
    if arg1 == nil then
    else
    end
    assert(true)
    local module = {}
    for _, v in ipairs(HomeItemBinder_upvr:GetAll()) do
        if v:GetOwner() == arg1 then
            local Name = v._obj.Name
            module[Name] = (module[Name] or 0) + 1
        end
    end
    return module
end
function module_upvr.attemptPurchase(arg1, arg2) -- Line 256
    ReplicatedStorage_upvr:FindFirstChild(HomeItemConsts_upvr.PURCHASE_HOME_ITEM_REMOTE_NAME):FireServer(arg1, arg2)
end
local function _(arg1, arg2) -- Line 260, Named "getItem"
    for _, v_2 in arg1 do
        if v_2.Name == arg2 then
            return v_2
        end
    end
    return nil
end
function module_upvr.attemptEquip(arg1, arg2) -- Line 268
    ReplicatedStorage_upvr:FindFirstChild(HomeItemConsts_upvr.EQUIP_HOME_ITEM_REMOTE_NAME):FireServer(arg1, arg2)
end
function module_upvr.attemptPreview(arg1, arg2) -- Line 272
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(arg2, "itemName is nil")
    assert(arg1, "moduleName is nil for itemName: "..tostring(arg2))
    local SOME = ReplicatedStorage_upvr.Home.HomeData:FindFirstChild(arg1)
    local var86
    if not SOME then return end
    var86 = "Module path does not exist"
    assert(SOME, var86)
    local SOME_2 = require(SOME)
    if SOME_2.getItems == nil then
        var86 = false
    else
        var86 = true
    end
    assert(var86, "Module does not have a getItems function")
    if SOME_2.apply == nil then
    else
    end
    assert(true, "Module does not have an apply function")
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [79.11]
    if nil == arg2 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.resetHomeCustomizationToEquipped(arg1) -- Line 292
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local children, NONE_2, NONE = ReplicatedStorage_upvr.Home.HomeData:GetChildren()
    local var91
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [69.7]
    nil.apply(var91, arg1:GetObj())
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if nil.apply(var91, arg1:GetObj()) == nil then
    else
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if nil.apply(var91, arg1:GetObj()) == nil then
    else
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.isCustomizing() -- Line 311
    return homeStore_upvr:getState().visible
end
return module_upvr