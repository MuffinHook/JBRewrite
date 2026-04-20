local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0, 0.80000, -1.7000);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        RightWristRotation = CFrame.new();
        LeftWristRotation = CFrame.new();
    };
    FunSounds = {{
        Name = "Siren";
        IconId = "rbxassetid://4939739355";
        SoundId = 690529934;
    }, {
        Name = "Drop Weapons";
        SoundId = 8990461116;
    }, {
        Name = "Countdown";
        SoundId = 8990459885;
    }, {
        Name = "ChampionTrumpets";
        SoundId = 12413440203;
    }};
}
local function _(arg1, arg2) -- Line 41, Named "wireup"
    local Wire_5 = Instance.new("Wire")
    Wire_5.SourceInstance = arg1
    Wire_5.TargetInstance = arg2
    Wire_5.Parent = arg2
    return Wire_5
end
local function _(arg1, arg2) -- Line 49, Named "split"
    local TargetInstance_2 = arg1.TargetInstance
    arg1.TargetInstance = arg2
    local Wire_2 = Instance.new("Wire")
    Wire_2.SourceInstance = arg2
    Wire_2.TargetInstance = TargetInstance_2
    Wire_2.Parent = TargetInstance_2
end
local module_upvr = {
    __ClassName = "Megaphone";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 60
    local any_new_result1 = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    local AudioEmitter = Instance.new("AudioEmitter")
    local AudioPlayer = Instance.new("AudioPlayer")
    local Wire_7 = Instance.new("Wire")
    local Wire_3 = Instance.new("Wire")
    AudioPlayer.Volume = 0.5
    AudioPlayer.Parent = AudioEmitter
    Wire_7.Parent = AudioEmitter
    Wire_7.SourceInstance = AudioPlayer
    Wire_7.TargetInstance = AudioEmitter
    Wire_3.Parent = AudioEmitter
    Wire_3.TargetInstance = AudioEmitter
    if arg1:FindFirstChild("AudioDeviceInput") then
        Wire_3.SourceInstance = arg1.AudioDeviceInput
    end
    local AudioDistortion_2 = Instance.new("AudioDistortion", Wire_7)
    AudioDistortion_2.Level = 0.4
    local TargetInstance_3 = Wire_7.TargetInstance
    Wire_7.TargetInstance = AudioDistortion_2
    local Wire = Instance.new("Wire")
    Wire.SourceInstance = AudioDistortion_2
    Wire.TargetInstance = TargetInstance_3
    Wire.Parent = TargetInstance_3
    local AudioDistortion = Instance.new("AudioDistortion", Wire_3)
    AudioDistortion.Level = 0.5
    local TargetInstance_4 = Wire_3.TargetInstance
    Wire_3.TargetInstance = AudioDistortion
    local Wire_6 = Instance.new("Wire")
    Wire_6.SourceInstance = AudioDistortion
    Wire_6.TargetInstance = TargetInstance_4
    Wire_6.Parent = TargetInstance_4
    local AudioFader = Instance.new("AudioFader", Wire_3)
    AudioFader.Volume = 2
    local TargetInstance = Wire_3.TargetInstance
    Wire_3.TargetInstance = AudioFader
    local Wire_4 = Instance.new("Wire")
    Wire_4.SourceInstance = AudioFader
    Wire_4.TargetInstance = TargetInstance
    Wire_4.Parent = TargetInstance
    AudioEmitter.Parent = any_new_result1.Model.Model.Body.EmmitAttachment
    any_new_result1.Model.Model.TeamColor.BrickColor = arg1.TeamColor
    any_new_result1.AudioPlayer = AudioPlayer
    any_new_result1.Maid:GiveTask(AudioEmitter)
    if any_new_result1.Local then
        Wire_3.TargetInstance = nil
    end
    any_new_result1:DefaultDisableCamLock()
    return any_new_result1
end
function module_upvr.GetLeftArmPosition(arg1) -- Line 115
    return nil
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 118
    local var31
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var31 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var31 = false
            else
                var31 = true
            end
        end
    end
    if arg1.AudioPlayer and var31 then
        local var32 = "rbxassetid://"..tbl_upvr.FunSounds[2].SoundId
        if arg1.AudioPlayer.Asset ~= var32 then
            arg1.AudioPlayer.Asset = var32
            arg1.AudioPlayer.TimePosition = 0
        end
        arg1.AudioPlayer:Play()
    end
    if arg1.Local and var31 then
        arg1:BroadcastInputBegan(arg2)
    end
    Basic_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1) -- Line 137
end
return module_upvr