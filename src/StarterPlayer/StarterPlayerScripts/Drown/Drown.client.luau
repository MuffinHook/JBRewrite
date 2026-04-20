local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local DrownUtils_upvr = require(ReplicatedStorage_upvr.Drown.DrownUtils)
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local createElement_upvr = Roact_upvr.createElement
local ProgressBar_upvr = require(ReplicatedStorage_upvr.Drown.UI.ProgressBar)
local function getComponent_upvr() -- Line 12, Named "getComponent"
    local var11 = DrownUtils_upvr.getDrownPercent(Players_upvr.LocalPlayer) or 0
    local Character = Players_upvr.LocalPlayer.Character
    if not Character then
        return createElement_upvr("Frame", {
            Active = false;
            Visible = false;
        })
    end
    local var14
    if 0 < var11 then
        var14 = createElement_upvr(ProgressBar_upvr, {
            aspectRatio = 0.5;
            size = UDim2.fromScale(1, 1);
            position = UDim2.fromScale(0, 0);
            progress = 1 - var11;
            text = "";
            filledColor = Color3.fromHex("5fcbfa");
            unfilledColor = Color3.new(0, 0, 0);
            barStrokeThickness = 2;
        })
    end
    return createElement_upvr("BillboardGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        Adornee = Character:WaitForChild("Head");
        Active = true;
        ResetOnSpawn = true;
        Size = UDim2.fromScale(5.25, 0.4);
        ExtentsOffset = Vector3.new(0, 3, 0);
        AlwaysOnTop = true;
    }, {
        ProgressBar = var14;
    })
end
local any_mount_result1_upvr = Roact_upvr.mount(getComponent_upvr(), Players_upvr.LocalPlayer.PlayerGui, "DrownGui")
local function updateUI() -- Line 47
    Roact_upvr.update(any_mount_result1_upvr, getComponent_upvr())
end
DrownUtils_upvr.getDrownPercentChangedSignal(Players_upvr.LocalPlayer):Connect(updateUI)
Players_upvr.LocalPlayer.CharacterAdded:Connect(updateUI)
Roact_upvr.update(any_mount_result1_upvr, getComponent_upvr())
local PlayerUtils_upvr = require(ReplicatedStorage_upvr.Std.PlayerUtils)
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local function playerAdded(arg1) -- Line 54
    local any_getPlayerMaid_result1_upvr = PlayerUtils_upvr.getPlayerMaid(arg1)
    local function _() -- Line 56, Named "cleanUp"
        any_getPlayerMaid_result1_upvr.drowningParticlesMaid = nil
    end
    local function updateBubbles() -- Line 59
        if not DrownUtils_upvr.getIsPlayerDrowning(arg1) then
            any_getPlayerMaid_result1_upvr.drowningParticlesMaid = nil
        else
            local Character_2 = arg1.Character
            if not Character_2 then
                any_getPlayerMaid_result1_upvr.drowningParticlesMaid = nil
                return
            end
            local Head = Character_2:FindFirstChild("Head")
            if not Head then
                any_getPlayerMaid_result1_upvr.drowningParticlesMaid = nil
                return
            end
            if any_getPlayerMaid_result1_upvr.drowningParticlesMaid then return end
            any_getPlayerMaid_result1_upvr.drowningParticlesMaid = Maid_upvr.new()
            local clone = ReplicatedStorage_upvr.Drown.Res.AirBubbles:Clone()
            clone.Rate = 100
            any_getPlayerMaid_result1_upvr.drowningParticlesMaid:GiveTask(clone)
            clone.Parent = Head
        end
    end
    any_getPlayerMaid_result1_upvr:GiveTask(DrownUtils_upvr.getDrownPercentChangedSignal(arg1):Connect(updateBubbles))
    any_getPlayerMaid_result1_upvr:GiveTask(Interval_upvr.every(1):Connect(updateBubbles))
end
for _, v in Players_upvr:GetPlayers() do
    playerAdded(v)
end
Players_upvr.PlayerAdded:Connect(playerAdded)