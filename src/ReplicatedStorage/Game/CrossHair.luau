local UserInputService_upvr = game:GetService("UserInputService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local function Update_upvr(arg1, arg2) -- Line 6, Named "Update"
    local any_Update_result1 = arg1.Spring:Update()
    local CrossHair = arg1.Gui.CrossHair
    local var5 = arg2
    if not var5 then
        var5 = UserInputService_upvr:GetMouseLocation()
    end
    local var6 = var5
    local AbsoluteSize = CrossHair.AbsoluteSize
    CrossHair.Position = UDim2.new(0, var6.X - AbsoluteSize.X * 0.5, 0, var6.Y - AbsoluteSize.Y * 0.5)
    CrossHair.VerticalTop.Position = UDim2.new(0.5, 0, 0, -any_Update_result1)
    CrossHair.VerticalBottom.Position = UDim2.new(0.5, 0, 0.5, any_Update_result1)
    CrossHair.HorizontalLeft.Position = UDim2.new(0, -any_Update_result1, 0.5, -1)
    CrossHair.HorizontalRight.Position = UDim2.new(0.5, any_Update_result1, 0.5, -1)
end
local Color3_new_result1_upvr = Color3.new(1, 0, 0)
local Color3_new_result1_upvr_2 = Color3.new(1, 1, 1)
local function FlareCrossHair_upvr(arg1) -- Line 22, Named "FlareCrossHair"
    local var10_upvr = arg1.Int + 1
    arg1.Int = var10_upvr
    local Gui = arg1.Gui
    if not Gui then
        return false
    end
    local CrossHair_2 = Gui.CrossHair
    local VerticalTop_upvr = CrossHair_2.VerticalTop
    local VerticalBottom_upvr = CrossHair_2.VerticalBottom
    local HorizontalLeft_upvr = CrossHair_2.HorizontalLeft
    local HorizontalRight_upvr = CrossHair_2.HorizontalRight
    VerticalTop_upvr.BackgroundColor3 = Color3_new_result1_upvr
    VerticalBottom_upvr.BackgroundColor3 = Color3_new_result1_upvr
    HorizontalLeft_upvr.BackgroundColor3 = Color3_new_result1_upvr
    HorizontalRight_upvr.BackgroundColor3 = Color3_new_result1_upvr
    delay(0.1, function() -- Line 39
        if arg1.Int ~= var10_upvr then
        else
            VerticalTop_upvr.BackgroundColor3 = Color3_new_result1_upvr_2
            VerticalBottom_upvr.BackgroundColor3 = Color3_new_result1_upvr_2
            HorizontalLeft_upvr.BackgroundColor3 = Color3_new_result1_upvr_2
            HorizontalRight_upvr.BackgroundColor3 = Color3_new_result1_upvr_2
        end
    end)
end
local function ADS_upvr(arg1, arg2) -- Line 49, Named "ADS"
    local var18
    if arg2 then
        var18 = 2
    else
        var18 = 5
    end
    arg1.Spring:SetTarget(var18)
end
local function EnableCrossHair_upvr(arg1) -- Line 52, Named "EnableCrossHair"
    UserInputService_upvr.MouseIconEnabled = false
    arg1.Gui.Enabled = true
end
local function DisableCrossHair_upvr(arg1) -- Line 56, Named "DisableCrossHair"
    UserInputService_upvr.MouseIconEnabled = true
    arg1.Gui.Enabled = false
end
local function DestroyCrossHair_upvr(arg1) -- Line 60, Named "DestroyCrossHair"
    UserInputService_upvr.MouseIconEnabled = true
    arg1.Gui.Enabled = false
    arg1.Gui:Destroy()
    arg1.Gui = nil
end
local Logic_upvr = require(ReplicatedStorage_upvr.Module.Logic)
return {
    Make = function() -- Line 66, Named "MakeCrossHair"
        local any_MakeSpring_result1 = Logic_upvr.MakeSpring()
        any_MakeSpring_result1.p = 0
        any_MakeSpring_result1.v = 0
        any_MakeSpring_result1.Target = 5
        any_MakeSpring_result1.Freq = 20
        any_MakeSpring_result1.Damp = 0.7
        local clone = ReplicatedStorage_upvr.Resource.CrossHairGui:Clone()
        clone.Enabled = false
        local module = {
            Gui = clone;
            Spring = any_MakeSpring_result1;
            Update = Update_upvr;
            Destroy = DestroyCrossHair_upvr;
            ADS = ADS_upvr;
            Flare = FlareCrossHair_upvr;
            Int = 1;
            Enable = EnableCrossHair_upvr;
            Disable = DisableCrossHair_upvr;
        }
        UserInputService_upvr.MouseIconEnabled = false
        module.Gui.Enabled = true
        return module
    end;
}