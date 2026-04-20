local UserInputService_upvr = game:GetService("UserInputService")
local module = {}
local tbl_upvr = {
    ButtonA = "rbxassetid://129272408813511";
    ButtonCross = "rbxassetid://123705746509283";
    ButtonB = "rbxassetid://127556782775053";
    ButtonCircle = "rbxassetid://122583701211819";
    ButtonX = "rbxassetid://73813905214844";
    ButtonSquare = "rbxassetid://92569297299158";
    ButtonY = "rbxassetid://117062443938201";
    ButtonTriangle = "rbxassetid://74071396596863";
    ButtonLB = "rbxassetid://91284550808190";
    ButtonL1 = "rbxassetid://97504033400172";
    ButtonLT = "rbxassetid://118517862748644";
    ButtonL2 = "rbxassetid://95956779925483";
    ButtonLS = "rbxassetid://106207846576627";
    ButtonL3 = "rbxassetid://127657906460383";
    ButtonRB = "rbxassetid://97852467329974";
    ButtonR1 = "rbxassetid://110544527420590";
    ButtonRT = "rbxassetid://76350478214517";
    ButtonR2 = "rbxassetid://86541840511550";
    ButtonRS = "rbxassetid://102865066343569";
    ButtonR3 = "rbxassetid://113691405405299";
    ButtonStart = "rbxassetid://136165536854877";
    ButtonOptions = "rbxassetid://79615379745180";
    ButtonSelect = "rbxassetid://112050690423009";
    ButtonShare = "rbxassetid://115824374337656";
    ButtonTouchpad = "rbxassetid://72958698211418";
    DPad = "rbxassetid://106521345981437";
    DPadUp = "rbxassetid://126615478248067";
    DPadDown = "rbxassetid://123889254459819";
    DPadRight = "rbxassetid://84358945169077";
    DPadLeft = "rbxassetid://71226209530396";
    PSDPad = "rbxassetid://137647630498871";
    PSDPadUp = "rbxassetid://110490172682233";
    PSDPadDown = "rbxassetid://122086043275068";
    PSDPadRight = "rbxassetid://125339474802706";
    PSDPadLeft = "rbxassetid://116409886750178";
}
local function getImageIdForKeyCode_upvr(arg1) -- Line 50, Named "getImageIdForKeyCode"
    local var4
    if UserInputService_upvr:GetStringForKeyCode(Enum.KeyCode.ButtonA) ~= "ButtonCross" then
        var4 = false
    else
        var4 = true
    end
    local var5
    if var4 and var5:find("DPad") then
        var5 = "PS"..var5
    end
    local var6 = tbl_upvr[var5]
    if not var6 then
        var6 = UserInputService_upvr:GetImageForKeyCode(arg1)
    end
    return var6
end
local function _(arg1, arg2, arg3) -- Line 62, Named "getImageInstance"
    local any = Instance.new(arg1)
    any.BackgroundTransparency = 1
    any.BorderSizePixel = 1
    any.Image = UserInputService_upvr:GetImageForKeyCode(arg2)
    any.Size = UDim2.fromScale(1, 1)
    return any
end
function module.GetImageLabel(arg1, arg2, arg3) -- Line 71
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.BorderSizePixel = 1
    ImageLabel.Image = UserInputService_upvr:GetImageForKeyCode(arg2)
    ImageLabel.Size = UDim2.fromScale(1, 1)
    return ImageLabel
end
function module.GetImageButton(arg1, arg2, arg3) -- Line 75
    local ImageButton = Instance.new("ImageButton")
    ImageButton.BackgroundTransparency = 1
    ImageButton.BorderSizePixel = 1
    ImageButton.Image = UserInputService_upvr:GetImageForKeyCode(arg2)
    ImageButton.Size = UDim2.fromScale(1, 1)
    return ImageButton
end
local Roact_upvr = require(script.Parent.Roact)
local Dictionary_upvr = require(game:GetService("ReplicatedStorage").EzUi.Dictionary)
local function getRoactImageInstance_upvr(arg1, arg2, arg3, arg4, arg5) -- Line 79, Named "getRoactImageInstance"
    local var13
    if not var13 then
        var13 = {}
    end
    if not var13.AspectRatio then
        var13.AspectRatio = Roact_upvr.createElement("UIAspectRatioConstraint", {
            AspectRatio = 1;
        })
    end
    return Roact_upvr.createElement(arg1, Dictionary_upvr.merge({
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Image = getImageIdForKeyCode_upvr(arg2);
        Size = UDim2.new(1, 0, 1, 0);
    }, arg4), var13)
end
function module.GetRoactImageLabel(arg1, arg2, arg3, arg4, arg5) -- Line 97
    return getRoactImageInstance_upvr("ImageLabel", arg2, arg3, arg4, arg5)
end
function module.GetRoactImageButton(arg1, arg2, arg3, arg4, arg5) -- Line 101
    return getRoactImageInstance_upvr("ImageButton", arg2, arg3, arg4, arg5)
end
module.getImageIdForKeyCode = getImageIdForKeyCode_upvr
return module