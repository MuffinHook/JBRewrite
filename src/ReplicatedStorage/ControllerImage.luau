local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(script.Parent.Roact)
local controllerImageModule = {}
local controllerImageIds = {
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
local function getImageIdForKeyCode(keyCode)
	local isPSController = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonCross"
	local keyCodeString = UserInputService:GetStringForKeyCode(keyCode)
	if isPSController and keyCodeString:find("DPad") then
		keyCodeString = "PS" .. keyCodeString
	end
	return controllerImageIds[keyCodeString] or UserInputService:GetImageForKeyCode(keyCode)
end
local function getImageInstance(instanceType, keyCode, unused)
	local instance = Instance.new(instanceType)
	instance.BackgroundTransparency = 1
	instance.BorderSizePixel = 1
	instance.Image = UserInputService:GetImageForKeyCode(keyCode)
	instance.Size = UDim2.fromScale(1, 1)
	return instance
end
function controllerImageModule.GetImageLabel(unused, keyCode, unused2)
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BorderSizePixel = 1
	ImageLabel.Image = UserInputService:GetImageForKeyCode(keyCode)
	ImageLabel.Size = UDim2.fromScale(1, 1)
	return ImageLabel
end
function controllerImageModule.GetImageButton(unused, keyCode, unused2)
	local ImageButton = Instance.new("ImageButton")
	ImageButton.BackgroundTransparency = 1
	ImageButton.BorderSizePixel = 1
	ImageButton.Image = UserInputService:GetImageForKeyCode(keyCode)
	ImageButton.Size = UDim2.fromScale(1, 1)
	return ImageButton
end
local function getRoactImageInstance(componentType, keyCode, unused, props, children)
	local elementProps = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = getImageIdForKeyCode(keyCode),
		Size = UDim2.new(1, 0, 1, 0)
	}
	if not children then
		children = {}
	end
	if not children.AspectRatio then
		children.AspectRatio = Roact.createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		})
	end
	return Roact.createElement(componentType, Dictionary.merge(elementProps, props), children)
end
function controllerImageModule.GetRoactImageLabel(unused, keyCode, unused2, props, children)
	return getRoactImageInstance("ImageLabel", keyCode, unused2, props, children)
end
function controllerImageModule.GetRoactImageButton(unused, keyCode, unused2, props, children)
	return getRoactImageInstance("ImageButton", keyCode, unused2, props, children)
end
controllerImageModule.getImageIdForKeyCode = getImageIdForKeyCode
return controllerImageModule
