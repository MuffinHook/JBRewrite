local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var2_upvw = 600
if require(ReplicatedStorage_upvr.App.RunUtils).isStudio() then
    var2_upvw = 20
end
local module = {}
local Binder_upvr = require(ReplicatedStorage_upvr.Std.Binder)
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local CircleAction_upvr = require(ReplicatedStorage_upvr.Module.UI).CircleAction
local BriefcaseUtils_upvr = require(ReplicatedStorage_upvr.AirDrop.BriefcaseUtils)
local RunService_upvr = game:GetService("RunService")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local Players_upvr = game:GetService("Players")
local Color3_fromRGB_result1_upvr = Color3.fromRGB(255, 255, 255)
local Color3_fromRGB_result1_upvr_2 = Color3.fromRGB(192, 122, 255)
local CharacterUtils_upvr = require(ReplicatedStorage_upvr.Std.CharacterUtils)
local MinimapService_upvr = require(ReplicatedStorage_upvr.App.MinimapService)
local LevelUISystem_upvr = require(ReplicatedStorage_upvr.Game.Level2.LevelUISystem)
local CollectionService_upvr = game:GetService("CollectionService")
local SpectateConsts_upvr = require(ReplicatedStorage_upvr.Spectate.SpectateConsts)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
function module.launch(arg1, arg2) -- Line 30
    local any_new_result1 = Binder_upvr.new("RoyaleBriefcase", function(arg1_2) -- Line 31
        local any_new_result1_upvr = Maid_upvr.new()
        local tbl = {
            Name = "Open Briefcase";
            Timed = true;
            Duration = 0.5;
            Dist = 16;
            Callback = function(arg1_3, arg2_2) -- Line 33, Named "action"
                if arg2_2 then
                    arg1_2:FindFirstChild("ClaimRemote"):FireServer()
                end
                return true
            end;
            Part = arg1_2.PrimaryPart;
        }
        tbl.ValidRoot = arg1_2
        any_new_result1_upvr:GiveTask(CircleAction_upvr.Add(tbl, arg1_2))
        local function updatePosition() -- Line 52
            local BriefcaseDuration = arg1_2:GetAttribute("BriefcaseDuration")
            local var24 = workspace:GetServerTimeNow() - arg1_2:GetAttribute("BriefcaseBornAt")
            if BriefcaseDuration <= var24 then
                var24 = BriefcaseDuration
                any_new_result1_upvr.updatePosition = nil
            end
            arg1_2:PivotTo(BriefcaseUtils_upvr.getCFrameAt(var24, arg1_2:GetAttribute("BriefcaseOrigin"), arg1_2:GetAttribute("BriefcaseTarget"), arg1_2:GetAttribute("BriefcaseLandNormal"), BriefcaseDuration))
        end
        updatePosition()
        any_new_result1_upvr.updatePosition = RunService_upvr.Heartbeat:Connect(updatePosition)
        return any_new_result1_upvr
    end)
    arg1:GiveTask(any_new_result1)
    any_new_result1:Start()
    local ColorCorrectionEffect_upvr = Instance.new("ColorCorrectionEffect")
    ColorCorrectionEffect_upvr.Name = "RoyaleColorCorrection"
    ColorCorrectionEffect_upvr.Enabled = true
    ColorCorrectionEffect_upvr.TintColor = Color3.new(1, 1, 1)
    ColorCorrectionEffect_upvr.Parent = game:GetService("Lighting")
    arg1:GiveTask(ColorCorrectionEffect_upvr)
    local any_createBinding_result1_2_upvr, any_createBinding_result2_upvr_2 = Roact_upvr.createBinding(Vector3.new(0, 0, 0))
    local any_createBinding_result1_upvr, any_createBinding_result2_upvr_3 = Roact_upvr.createBinding(0)
    local any_createBinding_result1_3, any_createBinding_result2_upvr_4 = Roact_upvr.createBinding(Vector3.new(0, 0, 0))
    local any_createBinding_result1, any_createBinding_result2_upvr = Roact_upvr.createBinding(0)
    local os_clock_result1_upvr = os.clock()
    local var36_upvw = false
    local function processCharacterInStorm_upvr(arg1_4) -- Line 86, Named "processCharacterInStorm"
        if os.clock() - os_clock_result1_upvr < 5 then
        else
            if var36_upvw == arg1_4 then return end
            var36_upvw = arg1_4
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer, 3217484827)
            local os_clock_result1_upvr_2 = os.clock()
            arg1.animateStormColor = RunService_upvr.Heartbeat:Connect(function() -- Line 100
                local var39
                if 1 <= var39 then
                    arg1.animateStormColor = nil
                end
                if not arg1_4 then
                    var39 = 1 - var39
                end
                ColorCorrectionEffect_upvr.TintColor = Color3_fromRGB_result1_upvr:Lerp(Color3_fromRGB_result1_upvr_2, var39)
            end)
        end
    end
    local clone_upvr_2 = ReplicatedStorage_upvr.GameMode.Res:FindFirstChild("StormRing"):Clone()
    clone_upvr_2.Transparency = 0
    clone_upvr_2:FindFirstChild("Mesh").VertexColor = Vector3.new(Color3_fromRGB_result1_upvr_2.R, Color3_fromRGB_result1_upvr_2.G, Color3_fromRGB_result1_upvr_2.B)
    clone_upvr_2.Parent = workspace
    arg1:GiveTask(clone_upvr_2)
    arg1:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 121
        local any_getValue_result1 = any_createBinding_result1_2_upvr:getValue()
        local StormWorldPosition = arg2:GetAttribute("StormWorldPosition")
        if StormWorldPosition then
            any_getValue_result1 = any_getValue_result1:Lerp(StormWorldPosition, 0.1)
            any_createBinding_result2_upvr_2(any_getValue_result1)
        end
        local any_getValue_result1_2 = any_createBinding_result1_upvr:getValue()
        local StormWorldRadius = arg2:GetAttribute("StormWorldRadius")
        if StormWorldRadius then
            any_getValue_result1_2 += (StormWorldRadius - any_getValue_result1_2) * 0.1
            any_createBinding_result2_upvr_3(any_getValue_result1_2)
        end
        clone_upvr_2:FindFirstChild("Mesh").Scale = Vector3.new(2 * any_getValue_result1_2 * 0.023809523809523808, 30, 2 * any_getValue_result1_2 * 0.023809523809523808)
        clone_upvr_2.CFrame = CFrame.new(any_getValue_result1.X, 500, any_getValue_result1.Z)
        local any_getRootPart_result1 = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
        local var47
        if any_getRootPart_result1 then
            var47 = any_getRootPart_result1.Position - any_getValue_result1
            if any_getRootPart_result1.Parent:GetAttribute("BattleRoyaleAlive") ~= true then
                var47 = false
            else
                var47 = true
            end
            local var48 = false
            if any_getValue_result1_2 < (var47 * Vector3.new(1, 0, 1)).Magnitude then
                var48 = var47
            end
            processCharacterInStorm_upvr(var48)
        end
    end))
    arg2:GetAttributeChangedSignal("StormWorldPositionTarget"):Connect(function() -- Line 146, Named "updatePositionTarget"
        any_createBinding_result2_upvr_4(arg2:GetAttribute("StormWorldPositionTarget") or Vector3.new(0, 0, 0))
    end)
    any_createBinding_result2_upvr_4(arg2:GetAttribute("StormWorldPositionTarget") or Vector3.new(0, 0, 0))
    arg2:GetAttributeChangedSignal("StormWorldRadiusTarget"):Connect(function() -- Line 151, Named "updateRadiusTarget"
        any_createBinding_result2_upvr(arg2:GetAttribute("StormWorldRadiusTarget") or 0)
    end)
    any_createBinding_result2_upvr(arg2:GetAttribute("StormWorldRadiusTarget") or 0)
    arg1:GiveTask(MinimapService_upvr.addCircle({
        name = "battleRoyale";
        worldPositionBinding = any_createBinding_result1_2_upvr;
        worldRadiusBinding = any_createBinding_result1_upvr;
        color = Color3_fromRGB_result1_upvr_2;
        transparency = 0.8;
    }))
    arg1:GiveTask(MinimapService_upvr.addCircle({
        name = "battleRoyaleTarget";
        worldPositionBinding = any_createBinding_result1_3;
        worldRadiusBinding = any_createBinding_result1;
        color = Color3_fromRGB_result1_upvr_2;
        transparency = 0.5;
    }))
    LevelUISystem_upvr.hideTopbar()
    arg1:GiveTask(LevelUISystem_upvr.showTopbar)
    local clone_upvr = ReplicatedStorage_upvr.GameMode.Res:FindFirstChild("BRGui"):Clone()
    arg1:GiveTask(clone_upvr)
    clone_upvr.Parent = Players_upvr.LocalPlayer.PlayerGui
    clone_upvr.Enabled = true
    clone_upvr.Stats.Visible = true
    local function updatePlayersAlive() -- Line 182
        clone_upvr.Stats.Players.TextLabel.Text = tostring(#CollectionService_upvr:GetTagged(SpectateConsts_upvr.SPECTATE_TAG_NAME))
    end
    clone_upvr.Stats.Players.TextLabel.Text = tostring(#CollectionService_upvr:GetTagged(SpectateConsts_upvr.SPECTATE_TAG_NAME))
    arg1:GiveTask(CollectionService_upvr:GetInstanceAddedSignal(SpectateConsts_upvr.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))
    arg1:GiveTask(CollectionService_upvr:GetInstanceRemovedSignal(SpectateConsts_upvr.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))
    local GameModeBornAt_upvr = arg2:GetAttribute("GameModeBornAt")
    arg1:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 191
        local var54 = (var2_upvw) - (workspace:GetServerTimeNow() - GameModeBornAt_upvr)
        if var54 < 0 then
            var54 = 0
        end
        clone_upvr.Stats.Time.TextLabel.Text = "%02d:%02d":format(math.floor(var54 / 60), math.floor(var54 % 60))
    end))
end
return module