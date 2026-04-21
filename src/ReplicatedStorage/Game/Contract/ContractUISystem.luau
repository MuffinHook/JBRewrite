local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local EzUtils_upvr = require(ReplicatedStorage_upvr.EzUi.EzUtils)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local Promise_upvr = require(ReplicatedStorage_upvr.Std.Promise)
local GameUtil_upvr = require(ReplicatedStorage_upvr.Game.GameUtil)
local ContractBinder_upvr = require(script.Parent.ContractBinder)
local ContractUI_upvr = require(script.Parent.ContractUI)
local SeasonConsts_upvr = require(ReplicatedStorage_upvr.Game.Season.SeasonConsts)
local var10_upvw
local var11_upvw
local function _(arg1) -- Line 28, Named "SelectIfGamepad"
    EzUtils_upvr.selectIfGamepad(arg1)
end
local module_upvr = {}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local ContractConsts_upvr = require(script.Parent.ContractConsts)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local Window_upvr = require(ReplicatedStorage_upvr.Module.Window.Window)
function module_upvr.init() -- Line 33
    var10_upvw = require(ReplicatedStorage_upvr.Game.Season.SeasonUISystem)
    var11_upvw = require(script.Parent.ContractSystem)
    local ContractsGui = ReplicatedStorage_upvr.StarterGui:FindFirstChild("ContractsGui")
    ContractsGui.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.gui = ContractsGui
    local ContractPopupGui_upvr = ReplicatedStorage_upvr.StarterGui:FindFirstChild("ContractPopupGui")
    ContractPopupGui_upvr.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.popupGui = ContractPopupGui_upvr
    module_upvr._contractPreset = ContractsGui.Background.Body.Main.Preset
    module_upvr._contractPreset.Visible = false
    waitForChild_upvr(LocalPlayer_upvr, ContractConsts_upvr.DEADLINE_VALUE_NAME):andThen(function(arg1) -- Line 48
        module_upvr._deadlineValue = arg1
        Interval_upvr.every(1):Connect(module_upvr._updateDeadline)
        module_upvr._updateDeadline()
        module_upvr._deadlineValue:GetPropertyChangedSignal("Value"):Connect(module_upvr._updateDeadline)
    end)
    local any_new_result1 = Window_upvr.new()
    any_new_result1:GetOnOpenedSignal():Connect(module_upvr._open)
    any_new_result1:GetOnClosedSignal():Connect(module_upvr._close)
    module_upvr._window = any_new_result1
    GameUtil_upvr.getCenterWindowGroup():Add(any_new_result1)
    local function _(arg1) -- Line 62, Named "hookContract"
        arg1._maid:GiveTask(arg1:GetOnStateChangedSignal():Connect(function(arg1_2, arg2) -- Line 63
            if arg1_2 == ContractConsts_upvr.enumState.COMPLETED or arg1_2 == ContractConsts_upvr.enumState.FAILED or arg1_2 == ContractConsts_upvr.enumState.ABORTED then
                local var24
                if arg1_2 == ContractConsts_upvr.enumState.COMPLETED then
                    Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105462848)
                    var24 = "COMPLETED"
                elseif arg1_2 == ContractConsts_upvr.enumState.FAILED then
                    var24 = "FAILED"
                    Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105462626)
                elseif arg1_2 == ContractConsts_upvr.enumState.ABORTED then
                    var24 = "ABORTED"
                    Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105462626)
                end
                local clone_3_upvw = module_upvr._contractPreset:Clone()
                clone_3_upvw.Size = UDim2.new(1, 0, 1, 0)
                clone_3_upvw.Visible = true
                clone_3_upvw.Parent = ContractPopupGui_upvr.Container
                local any_new_result1_2_upvw = ContractUI_upvr.new()
                any_new_result1_2_upvw:SetFrame(clone_3_upvw)
                any_new_result1_2_upvw:SetContract(arg1)
                any_new_result1_2_upvw:SetTitle(var24)
                Promise_upvr.delay(10):andThen(function() -- Line 94
                    any_new_result1_2_upvw:Destroy()
                    any_new_result1_2_upvw = nil
                end):andThen(function() -- Line 98
                    clone_3_upvw:Destroy()
                    clone_3_upvw = nil
                end)
            end
        end))
    end
    for _, v_upvr in ipairs(ContractBinder_upvr:GetAll()) do
        if v_upvr:GetPlayer() == LocalPlayer_upvr then
            v_upvr._maid:GiveTask(v_upvr:GetOnStateChangedSignal():Connect(function(arg1, arg2) -- Line 63
                if arg1 == ContractConsts_upvr.enumState.COMPLETED or arg1 == ContractConsts_upvr.enumState.FAILED or arg1 == ContractConsts_upvr.enumState.ABORTED then
                    local var33
                    if arg1 == ContractConsts_upvr.enumState.COMPLETED then
                        Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105462848)
                        var33 = "COMPLETED"
                    elseif arg1 == ContractConsts_upvr.enumState.FAILED then
                        var33 = "FAILED"
                        Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105462626)
                    elseif arg1 == ContractConsts_upvr.enumState.ABORTED then
                        var33 = "ABORTED"
                        Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105462626)
                    end
                    local clone_upvw = module_upvr._contractPreset:Clone()
                    clone_upvw.Size = UDim2.new(1, 0, 1, 0)
                    clone_upvw.Visible = true
                    clone_upvw.Parent = ContractPopupGui_upvr.Container
                    local any_new_result1_upvw = ContractUI_upvr.new()
                    any_new_result1_upvw:SetFrame(clone_upvw)
                    any_new_result1_upvw:SetContract(v_upvr)
                    any_new_result1_upvw:SetTitle(var33)
                    Promise_upvr.delay(10):andThen(function() -- Line 94
                        any_new_result1_upvw:Destroy()
                        any_new_result1_upvw = nil
                    end):andThen(function() -- Line 98
                        clone_upvw:Destroy()
                        clone_upvw = nil
                    end)
                end
            end))
        end
    end
    ContractBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 110
        if arg1:GetPlayer() == LocalPlayer_upvr then
            arg1._maid:GiveTask(arg1:GetOnStateChangedSignal():Connect(function(arg1_3, arg2) -- Line 63
                if arg1_3 == ContractConsts_upvr.enumState.COMPLETED or arg1_3 == ContractConsts_upvr.enumState.FAILED or arg1_3 == ContractConsts_upvr.enumState.ABORTED then
                    local var40
                    if arg1_3 == ContractConsts_upvr.enumState.COMPLETED then
                        Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105462848)
                        var40 = "COMPLETED"
                    elseif arg1_3 == ContractConsts_upvr.enumState.FAILED then
                        var40 = "FAILED"
                        Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105462626)
                    elseif arg1_3 == ContractConsts_upvr.enumState.ABORTED then
                        var40 = "ABORTED"
                        Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105462626)
                    end
                    local clone_2_upvw = module_upvr._contractPreset:Clone()
                    clone_2_upvw.Size = UDim2.new(1, 0, 1, 0)
                    clone_2_upvw.Visible = true
                    clone_2_upvw.Parent = ContractPopupGui_upvr.Container
                    local any_new_result1_3_upvw = ContractUI_upvr.new()
                    any_new_result1_3_upvw:SetFrame(clone_2_upvw)
                    any_new_result1_3_upvw:SetContract(arg1)
                    any_new_result1_3_upvw:SetTitle(var40)
                    Promise_upvr.delay(10):andThen(function() -- Line 94
                        any_new_result1_3_upvw:Destroy()
                        any_new_result1_3_upvw = nil
                    end):andThen(function() -- Line 98
                        clone_2_upvw:Destroy()
                        clone_2_upvw = nil
                    end)
                end
            end))
        end
    end)
end
local SeasonUtils_upvr = require(ReplicatedStorage_upvr.Game.Season.SeasonUtils)
function module_upvr._updateDeadline() -- Line 116
    module_upvr.gui.Background.Timer.Time.Text = SeasonUtils_upvr.formatRemaining(math.max(0, module_upvr._deadlineValue.Value - DateTime.now().UnixTimestamp))
end
function module_upvr.clearContracts() -- Line 127
    local _contractPreset_2 = module_upvr._contractPreset
    for _, v_2 in ipairs(module_upvr.gui:GetChildren()) do
        if v_2.ClassName == _contractPreset_2.ClassName and v_2 ~= _contractPreset_2 then
            v_2:Destroy()
        end
    end
    if module_upvr._listContractUI then
        for _, v_3 in ipairs(module_upvr._listContractUI) do
            v_3:Destroy()
        end
        module_upvr._listContractUI = nil
    end
end
function module_upvr.loadContracts(arg1) -- Line 142
    module_upvr._lastTeamIdLoaded = arg1
    local gui = module_upvr.gui
    local _contractPreset = module_upvr._contractPreset
    assert(not module_upvr._listContractUI)
    local tbl = {}
    module_upvr._listContractUI = tbl
    local any_getContracts_result1 = var11_upvw.getContracts()
    if #any_getContracts_result1 ~= 0 then
        tbl = false
    else
        tbl = true
    end
    gui.Background.Body.Main.ThankYou.Visible = tbl
    if tbl then
        gui.Background.Body.Main.ThankYou.Text = string.format("Season %d is over! Thanks for playing!", SeasonConsts_upvr.SEASON_NUM)
    else
        for i_4, v_4 in ipairs(any_getContracts_result1) do
            if v_4:GetTeamId() == arg1 then
                local clone = _contractPreset:Clone()
                clone.Visible = true
                clone.Parent = _contractPreset.Parent
                local any_new_result1_4 = ContractUI_upvr.new()
                any_new_result1_4:SetFrame(clone)
                any_new_result1_4:SetContract(v_4)
                any_new_result1_4:SetLayoutOrder(i_4)
                any_new_result1_4:SetTitle(string.format("CONTRACT %d", 0 + 1))
                table.insert(module_upvr._listContractUI, any_new_result1_4)
            end
        end
    end
end
function module_upvr.reloadContracts() -- Line 182
    module_upvr.clearContracts()
    module_upvr.loadContracts(module_upvr._lastTeamIdLoaded)
end
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
local SeasonSystem_upvr = require(ReplicatedStorage_upvr.Game.Season.SeasonSystem)
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local SeasonUIUtils_upvr = require(ReplicatedStorage_upvr.Game.Season.SeasonUIUtils)
function module_upvr._open() -- Line 187
    assert(not module_upvr._maid)
    local any_new_result1_5 = Maid_upvr.new()
    module_upvr._maid = any_new_result1_5
    local gui_upvr = module_upvr.gui
    gui_upvr.Enabled = true
    any_new_result1_5:GiveTask(function() -- Line 194
        gui_upvr.Enabled = false
    end)
    local var78
    if GameUtil_upvr.Team == Settings_upvr.EnumTeam.Police then
        var78 = Settings_upvr.EnumTeam.Police
    else
        var78 = Settings_upvr.EnumTeam.Criminal
    end
    module_upvr.clearContracts()
    module_upvr.loadContracts(var78)
    any_new_result1_5:GiveTask(ContractBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 207
        if arg1:GetPlayer() == LocalPlayer_upvr then
            module_upvr.reloadContracts()
        end
    end))
    any_new_result1_5:GiveTask(ContractBinder_upvr:GetClassRemovingSignal():Connect(function(arg1) -- Line 212
        if arg1:GetPlayer() == LocalPlayer_upvr then
            Promise_upvr.delay(0.1):andThenCall(module_upvr.reloadContracts)
        end
    end))
    any_new_result1_5:GiveTask(gui_upvr.Background.Body.Side.Criminal.Button.MouseButton1Down:Connect(function() -- Line 219
        module_upvr.clearContracts()
        module_upvr.loadContracts(Settings_upvr.EnumTeam.Criminal)
        Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105461542)
    end))
    any_new_result1_5:GiveTask(gui_upvr.Background.Body.Side.Police.Button.MouseButton1Down:Connect(function() -- Line 224
        module_upvr.clearContracts()
        module_upvr.loadContracts(Settings_upvr.EnumTeam.Police)
        Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105461542)
    end))
    any_new_result1_5:GiveTask(gui_upvr.Background.Bottom.Container.RewardButton.MouseButton1Down:Connect(function() -- Line 230
        module_upvr.close()
        var10_upvw.open()
        Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105461542)
    end))
    gui_upvr.Background.Bottom.Container.SeasonPass.Title.Text = string.format("SEASON %d: %s", SeasonConsts_upvr.SEASON_NUM, SeasonConsts_upvr.SEASON_TITLE)
    any_new_result1_5:GiveTask(gui_upvr.Background.Bottom.Container.SeasonPass.MouseButton1Down:Connect(function() -- Line 240
        local any_getFirstProductByType_result1_3 = Settings_upvr.getFirstProductByType("SeasonPass")
        local var86
        if any_getFirstProductByType_result1_3 == nil then
            var86 = false
        else
            var86 = true
        end
        assert(var86)
        var86 = LocalPlayer_upvr
        var86 = var86.PlayerGui
        Audio_upvr.ObjectLocal(var86, 6105461542)
        var86 = LocalPlayer_upvr
        if not SeasonSystem_upvr.doesPlayerOwnSeasonPass(var86) then
            MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, any_getFirstProductByType_result1_3.Id)
        end
    end))
    EzUtils_upvr.selectIfGamepad(gui_upvr.Background.Bottom.Container.SeasonPass)
    SeasonUIUtils_upvr.hookGiftContainer(gui_upvr.Background.GiftContainer, any_new_result1_5)
    local function _() -- Line 252, Named "setOwnsSeasonPass"
        gui_upvr.Background.Bottom.Container.SeasonPass.Buy.Visible = false
        gui_upvr.Background.Bottom.Container.SeasonPass.Price.Visible = false
        gui_upvr.Background.Bottom.Container.SeasonPass.Owned.Visible = true
    end
    if SeasonSystem_upvr.doesPlayerOwnSeasonPass(LocalPlayer_upvr) then
        gui_upvr.Background.Bottom.Container.SeasonPass.Buy.Visible = false
        gui_upvr.Background.Bottom.Container.SeasonPass.Price.Visible = false
        gui_upvr.Background.Bottom.Container.SeasonPass.Owned.Visible = true
    else
        any_new_result1_5:GiveTask(SeasonSystem_upvr.getSeasonPassOwnedSignal():Connect(function(arg1) -- Line 260
            if arg1 ~= LocalPlayer_upvr then
            else
                gui_upvr.Background.Bottom.Container.SeasonPass.Buy.Visible = false
                gui_upvr.Background.Bottom.Container.SeasonPass.Price.Visible = false
                gui_upvr.Background.Bottom.Container.SeasonPass.Owned.Visible = true
            end
        end))
    end
    any_new_result1_5:GiveTask(gui_upvr.Background.Close.MouseButton1Down:Connect(module_upvr.close))
    local any_getFirstProductByType_result1 = Settings_upvr.getFirstProductByType("SeasonPass")
    if any_getFirstProductByType_result1 and any_getFirstProductByType_result1.Robux then
        gui_upvr.Background.Bottom.Container.SeasonPass.Price.Text = tostring(any_getFirstProductByType_result1.Robux)
    end
    Settings_upvr.OnProductsFetched:Connect(function() -- Line 271, Named "updatePrice"
        local any_getFirstProductByType_result1_2 = Settings_upvr.getFirstProductByType("SeasonPass")
        if any_getFirstProductByType_result1_2 and any_getFirstProductByType_result1_2.Robux then
            gui_upvr.Background.Bottom.Container.SeasonPass.Price.Text = tostring(any_getFirstProductByType_result1_2.Robux)
        end
    end)
end
function module_upvr._close() -- Line 282
    local _maid = module_upvr._maid
    assert(_maid)
    module_upvr._maid = nil
    _maid:Destroy()
end
function module_upvr.open() -- Line 288
    module_upvr._window:Open()
end
function module_upvr.close() -- Line 291
    module_upvr._window:Close()
end
return module_upvr