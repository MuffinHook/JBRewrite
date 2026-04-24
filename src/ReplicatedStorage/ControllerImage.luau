-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(script.Parent.Roact)
local t = {}
local t2 = {
	ButtonA = "rbxassetid://129272408813511",
	ButtonCross = "rbxassetid://123705746509283",
	ButtonB = "rbxassetid://127556782775053",
	ButtonCircle = "rbxassetid://122583701211819",
	ButtonX = "rbxassetid://73813905214844",
	ButtonSquare = "rbxassetid://92569297299158",
	ButtonY = "rbxassetid://117062443938201",
	ButtonTriangle = "rbxassetid://74071396596863",
	ButtonLB = "rbxassetid://91284550808190",
	ButtonL1 = "rbxassetid://97504033400172",
	ButtonLT = "rbxassetid://118517862748644",
	ButtonL2 = "rbxassetid://95956779925483",
	ButtonLS = "rbxassetid://106207846576627",
	ButtonL3 = "rbxassetid://127657906460383",
	ButtonRB = "rbxassetid://97852467329974",
	ButtonR1 = "rbxassetid://110544527420590",
	ButtonRT = "rbxassetid://76350478214517",
	ButtonR2 = "rbxassetid://86541840511550",
	ButtonRS = "rbxassetid://102865066343569",
	ButtonR3 = "rbxassetid://113691405405299",
	ButtonStart = "rbxassetid://136165536854877",
	ButtonOptions = "rbxassetid://79615379745180",
	ButtonSelect = "rbxassetid://112050690423009",
	ButtonShare = "rbxassetid://115824374337656",
	ButtonTouchpad = "rbxassetid://72958698211418",
	DPad = "rbxassetid://106521345981437",
	DPadUp = "rbxassetid://126615478248067",
	DPadDown = "rbxassetid://123889254459819",
	DPadRight = "rbxassetid://84358945169077",
	DPadLeft = "rbxassetid://71226209530396",
	PSDPad = "rbxassetid://137647630498871",
	PSDPadUp = "rbxassetid://110490172682233",
	PSDPadDown = "rbxassetid://122086043275068",
	PSDPadRight = "rbxassetid://125339474802706",
	PSDPadLeft = "rbxassetid://116409886750178"
}
local function getImageIdForKeyCode(p1)
	local v1 = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonCross"
	local v2 = UserInputService:GetStringForKeyCode(p1)
	if v1 and v2:find("DPad") then
		v2 = "PS" .. v2
	end
	return t2[v2] or UserInputService:GetImageForKeyCode(p1)
end
local function getImageInstance(p1, p2, p3)
	local v1 = Instance.new(p1)
	v1.BackgroundTransparency = 1
	v1.BorderSizePixel = 1
	v1.Image = UserInputService:GetImageForKeyCode(p2)
	v1.Size = UDim2.fromScale(1, 1)
	return v1
end
function t.GetImageLabel(p1, p2, p3)
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BorderSizePixel = 1
	ImageLabel.Image = UserInputService:GetImageForKeyCode(p2)
	ImageLabel.Size = UDim2.fromScale(1, 1)
	return ImageLabel
end
function t.GetImageButton(p1, p2, p3)
	local ImageButton = Instance.new("ImageButton")
	ImageButton.BackgroundTransparency = 1
	ImageButton.BorderSizePixel = 1
	ImageButton.Image = UserInputService:GetImageForKeyCode(p2)
	ImageButton.Size = UDim2.fromScale(1, 1)
	return ImageButton
end
local function getRoactImageInstance(p1, p2, p3, p4, p5)
	local t = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = getImageIdForKeyCode(p2),
		Size = UDim2.new(1, 0, 1, 0)
	}
	if not p5 then
		p5 = {}
	end
	if not p5.AspectRatio then
		p5.AspectRatio = Roact.createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		})
	end
	return Roact.createElement(p1, Dictionary.merge(t, p4), p5)
end
function t.GetRoactImageLabel(p1, p2, p3, p4, p5)
	return getRoactImageInstance("ImageLabel", p2, p3, p4, p5)
end
function t.GetRoactImageButton(p1, p2, p3, p4, p5)
	return getRoactImageInstance("ImageButton", p2, p3, p4, p5)
end
t.getImageIdForKeyCode = getImageIdForKeyCode
return t
