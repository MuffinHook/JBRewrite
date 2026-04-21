local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage_upvr.Std.Signal)
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local BigButtonService_upvr = require(ReplicatedStorage_upvr.App.BigButtonService)
local module_2_upvr = {
    onDevPanelToggle = Signal.new();
    onGarageToggle = Signal.new();
}
local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding("4:00 PM")
module_2_upvr.time = any_createBinding_result1
module_2_upvr.updateTime = any_createBinding_result2
local UserInputService_upvr = game:GetService("UserInputService")
local TeamShared_upvr = require(ReplicatedStorage_upvr.App.TeamShared)
local Players_upvr = game:GetService("Players")
local Confirmation_upvr = require(ReplicatedStorage_upvr.Module.Confirmation)
local Notification_upvr = require(script.Parent.Notification)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local GamepassSystem_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassSystem)
local GamepassUtils_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassUtils)
local WorldTeleportConsts_upvr = require(ReplicatedStorage_upvr.WorldTeleport.WorldTeleportConsts)
local RunConsts_upvr = require(ReplicatedStorage_upvr.App.RunConsts)
local GuiService_upvr = game:GetService("GuiService")
local Utils_upvr = require(ReplicatedStorage_upvr.EzUi.Utils)
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
local createElement_upvr = Roact_upvr.createElement
local TopbarHolder_upvr = require(ReplicatedStorage_upvr.App.UI.TopbarHolder)
function module_2_upvr.Init(arg1) -- Line 31
    local em = arg1.em
    local any_createRef_result1_upvr = Roact_upvr.createRef()
    local tbl_2 = {
        name = "Garage";
        imageId = 8733342027;
        displayOrder = 10;
        ref = any_createRef_result1_upvr;
    }
    local function onClick() -- Line 43
        module_2_upvr.onGarageToggle:Fire()
    end
    tbl_2.onClick = onClick
    BigButtonService_upvr.add(tbl_2)
    UserInputService_upvr.InputBegan:Connect(function(arg1_2, arg2) -- Line 48
        if arg2 then
        elseif arg1_2.KeyCode == Enum.KeyCode.DPadUp then
            module_2_upvr.onGarageToggle:Fire()
        end
    end)
    local var29_upvw
    local Event_upvr = arg1.Event
    TeamShared_upvr.promiseIsTeamSwitchingEnabled():andThen(function(arg1_3) -- Line 58
        if arg1_3 then
            local tbl_6 = {
                name = "TeamSwitch";
                imageId = 4912231691;
                displayOrder = 20;
            }
            local function onClick() -- Line 64
                local ChoosingTeam = Players_upvr.LocalPlayer:FindFirstChild("ChoosingTeam")
                if ChoosingTeam and ChoosingTeam.Value then
                else
                    if var29_upvw ~= nil then
                        var29_upvw:Destroy()
                        var29_upvw = nil
                        return
                    end
                    var29_upvw = Confirmation_upvr.new("Are you sure you want to switch teams?")
                    var29_upvw.OnYes:Connect(function() -- Line 78
                        var29_upvw = nil
                        Event_upvr:FireServer('j'..""..("dsapj1sw"):sub(3, 4):reverse():reverse():reverse().."".."az0oc")
                    end)
                    var29_upvw.OnNo:Connect(function() -- Line 82
                        var29_upvw = nil
                    end)
                end
            end
            tbl_6.onClick = onClick
            BigButtonService_upvr.add(tbl_6)
        end
    end)
    local tbl_4 = {
        name = "Cash";
        imageId = 4912231216;
        displayOrder = 30;
    }
    local CashBuyUI_upvr = require(ReplicatedStorage_upvr.Game.CashBuyUI)
    local function onClick() -- Line 95
        if module_2_upvr.ShopAlreadyLoading then
        else
            if CashBuyUI_upvr.IsOpen == false then
                if not CashBuyUI_upvr.Loaded then
                    module_2_upvr.ShopAlreadyLoading = true
                    Notification_upvr.new({
                        Text = "Loading Store... Please wait!";
                    })
                    CashBuyUI_upvr.OnLoaded:Wait()
                    module_2_upvr.ShopAlreadyLoading = false
                end
                CashBuyUI_upvr.Open()
                return
            end
            CashBuyUI_upvr.Close()
        end
    end
    tbl_4.onClick = onClick
    BigButtonService_upvr.add(tbl_4)
    local tbl_5 = {
        name = "Safes";
        imageId = 10313420284;
        imageScale = 0.9;
        displayOrder = 40;
    }
    local function onClick() -- Line 118
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
        store_upvr:dispatch({
            type = "toggleSafesOpen";
        })
    end
    tbl_5.onClick = onClick
    module_2_upvr.safesButton = tbl_5
    BigButtonService_upvr.add(module_2_upvr.safesButton)
    local tbl = {
        name = "Settings";
        imageId = 8733343021;
        displayOrder = 50;
    }
    local function onClick() -- Line 133
        module_2_upvr.onDevPanelToggle:Fire()
    end
    tbl.onClick = onClick
    module_2_upvr.settingsButton = tbl
    BigButtonService_upvr.add(module_2_upvr.settingsButton)
    if RunUtils_upvr.isMainWorld() then
    elseif RunUtils_upvr.isTradeWorld() then
        local tbl_3 = {
            name = "Trade";
            imageId = 9857392770;
            displayOrder = 60;
        }
        local function onClick() -- Line 153
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                    Volume = 0.15;
                })
            end
            store_upvr:dispatch({
                type = "setTradeInventoryOpen";
                value = not store_upvr:getState().tradeInventoryOpen;
            })
        end
        tbl_3.onClick = onClick
        BigButtonService_upvr.add(tbl_3)
    end
    local var46
    if RunUtils_upvr.isTradeWorld() then
        local function _() -- Line 170, Named "doesHaveVIP"
            return GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.TradingVIP)
        end
        local tbl_upvr = {
            name = "GoHome";
            displayOrder = 70;
            onClick = function() -- Line 176, Named "onClick"
                if Players_upvr.LocalPlayer.PlayerGui then
                    Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                        Volume = 0.15;
                    })
                end
                if GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.TradingVIP) then
                    if var29_upvw ~= nil then
                        var29_upvw:Destroy()
                        var29_upvw = nil
                    else
                        var29_upvw = Confirmation_upvr.new("Are you sure you want to return to Jailbreak?")
                        var29_upvw.OnYes:Connect(function() -- Line 186
                            var29_upvw = nil
                            ReplicatedStorage_upvr:FindFirstChild(WorldTeleportConsts_upvr.TELEPORT_TO_WORLD_FROM_TEAM_SWITCH_NAME):FireServer(RunConsts_upvr.MAIN_WORLD_NAME)
                        end)
                        var29_upvw.OnNo:Connect(function() -- Line 193
                            var29_upvw = nil
                        end)
                    end
                end
                GamepassUtils_upvr.PromptGamepass(GamepassUtils_upvr.EnumGamepass.TradingVIP)
            end;
        }
        local function _() -- Line 202, Named "updateProps"
            local var51
            if GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.TradingVIP) then
                var51 = 10087230550
            else
                var51 = 10087230159
            end
            tbl_upvr.imageId = var51
        end
        if GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.TradingVIP) then
            var46 = 10087230550
        else
            var46 = 10087230159
        end
        tbl_upvr.imageId = var46
        var46 = BigButtonService_upvr
        var46 = var46.add
        var46(tbl_upvr)
        var46 = GamepassSystem_upvr
        var46 = var46.GetGamepassOwnedSignal(GamepassUtils_upvr.EnumGamepass.TradingVIP)
        var46:Connect(function() -- Line 207
            local var53
            if GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.TradingVIP) then
                var53 = 10087230550
            else
                var53 = 10087230159
            end
            tbl_upvr.imageId = var53
            BigButtonService_upvr.triggerUpdate:Fire()
        end)
    end
    tbl_upvr = ReplicatedStorage_upvr
    tbl_upvr = tbl_upvr.Game
    tbl_upvr = tbl_upvr.GameUtil
    local tbl_upvr_2_upvr = require(tbl_upvr)
    function tbl_upvr(arg1_4) -- Line 214, Named "x3elq9f1"
        if arg1_4 ~= "Criminal" then
        else
        end
        if not true then
            tbl_upvr_2_upvr.bounty = 0
            tbl_upvr_2_upvr.onBountyChanged:Fire(tbl_upvr_2_upvr.bounty)
        end
    end
    em.x3elq9f1 = tbl_upvr
    function tbl_upvr(arg1_5) -- Line 221, Named "wtj2qmdk"
        tbl_upvr_2_upvr.bounty = arg1_5
        tbl_upvr_2_upvr.onBountyChanged:Fire(tbl_upvr_2_upvr.bounty)
    end
    em.wtj2qmdk = tbl_upvr
    tbl_upvr = module_2_upvr
    tbl_upvr = tbl_upvr.SetSafeCount
    tbl_upvr(0)
    tbl_upvr = store_upvr
    tbl_upvr = tbl_upvr.changed
    tbl_upvr:connect(function(arg1_6, arg2) -- Line 228
        if arg1_6.safesInventoryItems ~= arg2.safesInventoryItems then
            module_2_upvr.SetSafeCount(#arg1_6.safesInventoryItems)
        end
    end)
    tbl_upvr = UserInputService_upvr
    tbl_upvr = tbl_upvr.InputBegan
    tbl_upvr:Connect(function(arg1_7) -- Line 238
        if arg1_7.UserInputType == Enum.UserInputType.Gamepad1 and arg1_7.KeyCode == Enum.KeyCode.ButtonSelect and GuiService_upvr.SelectedObject ~= nil then
            Utils_upvr.selectIfGamepad(any_createRef_result1_upvr:getValue())
        end
    end)
    function tbl_upvr() -- Line 289, Named "getComponent"
        local module = {}
        local var60
        if Utils_upvr.isSmallScreen() then
            var60 = createElement_upvr
            var60 = var60(TopbarHolder_upvr, {
                color = Settings_upvr.TeamColor[tbl_upvr_2_upvr.Team];
                buttons = BigButtonService_upvr.active;
            })
        else
            var60 = nil
        end
        module.Buttons = var60
        return createElement_upvr("ScreenGui", {
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
            ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets;
            ResetOnSpawn = false;
        }, module)
    end
    local var57_upvr = tbl_upvr
    local any_mount_result1_upvr = Roact_upvr.mount(var57_upvr(), Players_upvr.LocalPlayer.PlayerGui, "SidebarGui")
    local var64_upvw
    Utils_upvr.getViewportSizeChangedSignal():Connect(function() -- Line 308
        if var64_upvw then
            task.cancel(var64_upvw)
        end
        var64_upvw = task.delay(0.1, function() -- Line 312
            Roact_upvr.update(any_mount_result1_upvr, var57_upvr())
            var64_upvw = nil
        end)
    end)
    tbl_upvr_2_upvr.OnTeamChanged:Connect(function(arg1_8) -- Line 317
        Roact_upvr.update(any_mount_result1_upvr, var57_upvr())
    end)
end
function module_2_upvr.SetTime(arg1) -- Line 321
    module_2_upvr.updateTime(arg1)
end
function module_2_upvr.SetSafeCount(arg1) -- Line 324
    if module_2_upvr.safesButton then
        module_2_upvr.safesButton.count = arg1
        BigButtonService_upvr.triggerUpdate:Fire()
    end
end
return module_2_upvr
