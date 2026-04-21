local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast_upvr = require(ReplicatedStorage.Module.RayCast)
local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0, 0.5, -1);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        Place = {
            Springs = {
                ItemOffset = Vector3.new(0, 2.40000, -1.7000);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new(0.78539, 0, 0);
                WaistRotation = Vector3.new(-1.8849, 0, 0);
            };
        };
        RightWristRotation = CFrame.new();
        LeftWristRotation = CFrame.new();
    };
    MaxLength = 48;
}
local var10_upvw
local module_upvr = {
    __ClassName = "RoadSpike";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
function module_upvr.Init(arg1) -- Line 39
    var10_upvw = arg1.Event
end
function module_upvr.new(arg1, arg2, arg3) -- Line 42
    local any_new_result1 = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.IgnoreList = {any_new_result1.Character, workspace.Items}
    any_new_result1:SetupBeam()
    any_new_result1:SetupGui()
    any_new_result1:DefaultDisableCamLock()
    return any_new_result1
end
local ActionButtonService_upvr = require(ReplicatedStorage.ActionButton.ActionButtonService)
function module_upvr.SetupGui(arg1) -- Line 54
    if arg1.Local then
        arg1.Maid:GiveTask(ActionButtonService_upvr.add({
            priority = 750;
            image = "rbxassetid://4939737424";
            keyCodes = {Enum.KeyCode.R, Enum.KeyCode.ButtonX};
            onPressed = function() -- Line 60, Named "onPressed"
                var10_upvw:FireServer('n'.."".."pl5f0d9uxx":sub(4, 7):reverse():reverse():reverse():reverse():reverse().."".."".."omtsmau":sub(5, 5):reverse().."".."y3")
            end;
        }))
    end
end
function module_upvr.SetupBeam(arg1) -- Line 66
    local Attachment = Instance.new("Attachment")
    Attachment.Orientation = Vector3.new(90, 0, 0)
    Attachment.Position = Vector3.new(0, 0, 0)
    Attachment.Parent = arg1.Center
    local Beam = Instance.new("Beam")
    Beam.Transparency = NumberSequence.new(0)
    Beam.TextureMode = Enum.TextureMode.Static
    Beam.Texture = string.format("rbxassetid://%d", 4556309780)
    Beam.TextureLength = 6
    Beam.Width0 = 6
    Beam.Width1 = 6
    Beam.Attachment1 = Attachment
    Beam.Segments = 1
    Beam.FaceCamera = true
    Beam.Enabled = false
    Beam.Parent = arg1.Center
    arg1.Beam = Beam
    arg1.StartPosition = nil
    arg1.EndPosition = nil
    arg1.TempPart = nil
end
function module_upvr.PlaceBeam(arg1, arg2) -- Line 91
    if arg1.StartPosition == nil then
        if arg1.TempPart ~= nil then
            arg1.TempPart:Destroy()
            arg1.TempPart = nil
        end
        local Part_2 = Instance.new("Part")
        Part_2.Anchored = true
        Part_2.Transparency = 1
        Part_2.CanCollide = false
        Part_2.CFrame = CFrame.new(arg2)
        Part_2.Parent = workspace
        arg1.TempPart = Part_2
        local Attachment_2 = Instance.new("Attachment")
        Attachment_2.Orientation = Vector3.new(90, 0, 0)
        Attachment_2.Position = Vector3.new(0, 0, 0)
        Attachment_2.Parent = Part_2
        arg1.Beam.Attachment0 = Attachment_2
        arg1.Beam.Enabled = true
    elseif arg1.EndPosition == nil then
        arg1.TempPart:Destroy()
        arg1.TempPart = nil
        arg1.Beam.Enabled = false
    end
    if arg1.StartPosition == nil then
        arg1.StartPosition = arg2
    elseif arg1.EndPosition == nil then
        arg1.EndPosition = arg2
        if arg1.Local then
            var10_upvw:FireServer('d'.."plf8qizwte":sub(5, 7):reverse().."".."".."vshqy5":sub(2, 2):reverse():reverse():reverse().."".."zfq", arg1.StartPosition, arg1.EndPosition)
        end
    end
    if arg1.StartPosition ~= nil and arg1.EndPosition ~= nil then
        arg1.StartPosition = nil
        arg1.EndPosition = nil
    end
end
function module_upvr.GetRightArmPosition(arg1) -- Line 132
    return arg1.Center.CFrame * Vector3.new(0.40000, 0, 0)
end
function module_upvr.GetLeftArmPosition(arg1) -- Line 135
    return arg1.Center.CFrame * Vector3.new(-0.4000, 0, 0)
end
function module_upvr.Click(arg1) -- Line 138
    local any_RayIgnoreNonCollideWithIgnoreList_result1, any_RayIgnoreNonCollideWithIgnoreList_result2_2_upvr = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(arg1.Center.Position, Vector3.new(0, -1, 0), 10, arg1.IgnoreList)
    if arg1.Local and any_RayIgnoreNonCollideWithIgnoreList_result1 == nil then
        return false
    end
    arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Place.Springs.ItemOffset)
    arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Place.Springs.NeckRotation)
    arg1.SpringWaistRotation:SetTarget(arg1.Config.Motion.Place.Springs.WaistRotation)
    task.delay(0.3, function() -- Line 151
        if arg1.Destroyed then
        else
            arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Hip.Springs.ItemOffset)
            arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Hip.Springs.NeckRotation)
            arg1.SpringWaistRotation:SetTarget(arg1.Config.Motion.Hip.Springs.WaistRotation)
            arg1:PlaceBeam(any_RayIgnoreNonCollideWithIgnoreList_result2_2_upvr)
        end
    end)
end
function module_upvr.ShootBegin(arg1, arg2) -- Line 163
    arg1:Click()
    if arg1.Local then
        arg1:BroadcastInputBegan(arg2)
    end
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 169
    if arg3 then
        return false
    end
    local var27 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var27 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var27 = false
            else
                var27 = true
            end
        end
    end
    if var27 then
        arg1:ShootBegin(arg2)
    end
    Basic_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1) -- Line 182
end
local ColorSequence_new_result1_upvr_2 = ColorSequence.new(Color3.new(1, 0, 0))
local ColorSequence_new_result1_upvr = ColorSequence.new(Color3.new(1, 1, 1))
function module_upvr.Stepped(arg1) -- Line 186
    Basic_upvr.Stepped(arg1)
    if arg1.StartPosition ~= nil then
        local any_RayIgnoreNonCollideWithIgnoreList_result1_2, any_RayIgnoreNonCollideWithIgnoreList_result2 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(arg1.Center.Position, Vector3.new(0, -1, 0), 10, arg1.IgnoreList)
        if arg1.Config.MaxLength < (arg1.StartPosition - any_RayIgnoreNonCollideWithIgnoreList_result2).Magnitude then
            if arg1.Local then
                arg1.Beam.Color = ColorSequence_new_result1_upvr_2
            else
                arg1.Beam.Enabled = false
            end
        end
        if arg1.Local then
            arg1.Beam.Color = ColorSequence_new_result1_upvr
            return
        end
        arg1.Beam.Enabled = true
    end
end
function module_upvr.Unequip(arg1) -- Line 206
    if arg1.TempPart then
        arg1.TempPart:Destroy()
        arg1.TempPart = nil
    end
    arg1.Beam:Destroy()
    arg1.Beam = nil
    arg1.StartPosition = nil
    arg1.EndPosition = nil
end
function module_upvr.Destroy(arg1) -- Line 216
    arg1:Unequip()
    Basic_upvr.Destroy(arg1)
end
return module_upvr