local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local SeasonConsts_upvr = require(ReplicatedStorage_upvr.Game.Season.SeasonConsts)
local SeasonUtils_upvr = require(ReplicatedStorage_upvr.Game.Season.SeasonUtils)
local SeasonSystem_upvr = require(ReplicatedStorage_upvr.Game.Season.SeasonSystem)
local LevelUtils_upvr = require(script.Parent.LevelUtils)
local module_upvr = {
    gui = nil;
    hidden = false;
}
local LevelSystem_upvr = require(script.Parent.LevelSystem)
function module_upvr.init() -- Line 18
    local LevelGui2 = ReplicatedStorage_upvr.StarterGui:FindFirstChild("LevelGui2")
    LevelGui2.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.gui = LevelGui2
    LevelGui2.Enabled = not module_upvr.hidden
    module_upvr.updateProgress(LocalPlayer_upvr)
    LevelSystem_upvr.getOnLevelChangedSignal():Connect(module_upvr.updateProgress)
    LevelSystem_upvr.getOnExpChangedSignal():Connect(module_upvr.updateProgress)
    LevelGui2.Background.Body.SeasonNum.Text = "SEASON %d":format(SeasonConsts_upvr.SEASON_NUM)
    LevelGui2.Background.Body.InfoButton.MouseButton1Down:Connect(module_upvr.toggleInfo)
    LevelGui2.Background.Body.MouseButton1Down:Connect(module_upvr.toggleInfo)
    SeasonSystem_upvr.getSeasonPassOwnedSignal():Connect(function(arg1) -- Line 37
        if arg1 ~= LocalPlayer_upvr then
        else
            module_upvr.updateProgress(LocalPlayer_upvr)
        end
    end)
end
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local SeasonUISystem_upvr = require(ReplicatedStorage_upvr.Game.Season.SeasonUISystem)
local ContractUISystem_upvr = require(ReplicatedStorage_upvr.Game.Contract.ContractUISystem)
function module_upvr.toggleInfo() -- Line 44
    Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105461542)
    if SeasonUISystem_upvr._window:IsOpen() then
        SeasonUISystem_upvr.close()
    else
        if ContractUISystem_upvr._window:IsOpen() then
            ContractUISystem_upvr.close()
            return
        end
        local var15 = ContractUISystem_upvr
        if not LocalPlayer_upvr:FindFirstChild(SeasonConsts_upvr.HAS_SEEN_REWARDS_VALUE_NAME).Value or SeasonUtils_upvr.getRemainingTime() <= 0 then
            var15 = SeasonUISystem_upvr
        end
        var15.open()
    end
end
function module_upvr.updateProgress(arg1) -- Line 61
    if arg1 == LocalPlayer_upvr then
        local any_getLevel_result1 = LevelUtils_upvr.getLevel(arg1)
        local any_getExp_result1 = LevelUtils_upvr.getExp(arg1)
        if any_getLevel_result1 and any_getExp_result1 then
            module_upvr.setProgress(any_getLevel_result1, any_getExp_result1)
        end
    end
end
local function _(arg1, arg2, arg3) -- Line 70, Named "tweenFrameFromLastFracToFrac"
    if arg3 then
        arg1.Size = UDim2.fromScale(0, 1)
        arg1.Position = UDim2.fromScale(0, 0)
    end
    local Scale = arg1.Size.X.Scale
    if Scale >= arg2 or not (arg2 - Scale) then
    end
    local var20 = arg2 / 1
    arg1:TweenSize(UDim2.new(arg2, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, var20, true)
    return var20
end
local LevelConsts_upvr = require(script.Parent.LevelConsts)
function module_upvr.setProgress(arg1, arg2) -- Line 82
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_calculateExpNextLevel_result1 = LevelUtils_upvr.calculateExpNextLevel(arg1)
    local var23 = arg2 / any_calculateExpNextLevel_result1
    local gui = module_upvr.gui
    local Scale_2 = gui.Background.Body.Progress.Size.X.Scale
    local var26
    if var23 < Scale_2 then
        var26 = gui.Background
        var26 = var26.Body
        var26 = var26.Progress
        var26.Size = UDim2.fromScale(0, 1)
        var26 = gui.Background
        var26 = var26.Body
        var26 = var26.ProgressDaily
        var26.Size = UDim2.fromScale(0, 1)
        var26 = gui.Background
        var26 = var26.Body
        var26 = var26.ProgressDaily
        var26.Position = UDim2.fromScale(0, 0)
    end
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var26 = var23 - Scale_2
        return var26
    end
    if Scale_2 >= var23 or not decompInlinedCondition() then
        var26 = var23
    end
    local var27 = var26 / 1
    gui.Background.Body.Progress:TweenSize(UDim2.new(var23, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, var27, true)
    gui.Background.Body.Level.Text = "LEVEL %d":format(arg1)
    gui.Background.Body.ExpProgress.Text = "%d/%d":format(arg2, any_calculateExpNextLevel_result1)
    if SeasonSystem_upvr.doesPlayerOwnSeasonPass(LocalPlayer_upvr) then
    end
    if SeasonUtils_upvr.getRemainingTime() < 0 then
    end
    local SOME = Players_upvr.LocalPlayer:FindFirstChild(LevelConsts_upvr.DAILY_EXP_VALUE_NAME)
    if SOME then
    end
    if 0 - SOME.Value < 0 then
        local const_number = 0
    end
    if 0.001 >= const_number then
    else
    end
    gui.Background.Body.Help1.Visible = true
    gui.Background.Body.ProgressDaily:TweenSize(UDim2.new(math.min(1, (arg2 + const_number) / any_calculateExpNextLevel_result1) - var23, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, var27, true)
    gui.Background.Body.ProgressDaily:TweenPosition(UDim2.fromScale(var23, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, var27, true)
end
function module_upvr.hideTopbar() -- Line 139
    module_upvr.hidden = true
    if module_upvr.gui then
        module_upvr.gui.Enabled = not module_upvr.hidden
    end
end
function module_upvr.showTopbar() -- Line 145
    module_upvr.hidden = false
    if module_upvr.gui then
        module_upvr.gui.Enabled = not module_upvr.hidden
    end
end
return module_upvr