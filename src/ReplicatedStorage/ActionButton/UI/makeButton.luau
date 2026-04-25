-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CircularProgressBar = require(script.Parent.CircularProgressBar)
local ControllerImage = require(ReplicatedStorage.ControllerImage)
local InputUtils = require(script.Parent.InputUtils)
local Roact = require(ReplicatedStorage.Roact)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
return function(p1, p2, p3, p4, p5, p6)
	local pressedEventKey = ("%s_%d_%s"):format(p2, p3, "pressed")
	local onReleasedEventKey = ("%s_%d_%s"):format(p2, p3, "onReleased")
	local onPressedEventKey = ("%s_%d_%s"):format(p2, p3, "onPressed")
	local imageEventKey = ("%s_%d_%s"):format(p2, p3, "image")
	local keyCodeEventKey = ("%s_%d_%s"):format(p2, p3, "keyCode")
	local buttonConfig = p1[("%s_%d_%s"):format(p2, p3, "button")]
	local inputKeyCode = p1[keyCodeEventKey]
	local baseColor = p1.color or Color3.new(255/255, 255/255, 255/255)
	if buttonConfig and buttonConfig.saturateTo then
		baseColor = ColorUtils.saturateTo(baseColor, buttonConfig.saturateTo)
	end
	local darkenedColor = ColorUtils.brightenBy(baseColor, -0.3)
	local imageLabelProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.8, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Active = false,
		Image = p1[imageEventKey]
	}
	imageLabelProps.ImageColor3 = if p1[pressedEventKey] and darkenedColor then darkenedColor else baseColor
	local childElements = {}
	if buttonConfig and buttonConfig.title then
		imageLabelProps.Position = UDim2.new(0.5, 0, 0.4, 0)
		imageLabelProps.Size = UDim2.new(1, 0, 0.8, 0)
		local t3 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.8, 0, 0.2, 0),
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0.6, 0)
		}
		t3.TextColor3 = if p1[pressedEventKey] and darkenedColor then darkenedColor else baseColor
		t3.TextScaled = true
		t3.Text = buttonConfig.title
		t3.Font = Enum.Font.LuckiestGuy
		childElements.Label = createElement("TextLabel", t3)
	end
	childElements.ImageLabel = createElement("ImageLabel", imageLabelProps, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		})
	})
	local inputIconScale = if p1[pressedEventKey] then 0.5 else 1
	if inputKeyCode and InputUtils.isGamepadKeyCode(inputKeyCode) then
		childElements.Input = ControllerImage:GetRoactImageLabel(inputKeyCode, "Dark", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(0.7 * inputIconScale, 0, 0.7 * inputIconScale, 0),
			Position = UDim2.new(0.8, 0, 0.8, 0),
			ZIndex = 4
		})
	elseif inputKeyCode then
		local keyCodeString = UserInputService:GetStringForKeyCode(inputKeyCode)
		if inputKeyCode == Enum.KeyCode.LeftShift or inputKeyCode == Enum.KeyCode.RightShift then
			keyCodeString = "Shift"
		elseif inputKeyCode == Enum.KeyCode.LeftControl or inputKeyCode == Enum.KeyCode.RightControl then
			keyCodeString = "Ctrl"
		end
		if #keyCodeString == 0 then
			keyCodeString = inputKeyCode.Name
		end
		childElements.Input = createElement("TextLabel", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(0.5 * inputIconScale, 0, 0.5 * inputIconScale, 0),
			Position = UDim2.new(0.9, 0, 0.9, 0),
			TextColor3 = baseColor,
			TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255),
			TextStrokeTransparency = 0.7,
			Font = Enum.Font.LuckiestGuy,
			TextScaled = true,
			Text = keyCodeString:upper(),
			ZIndex = 4
		})
	end
	if buttonConfig and buttonConfig.progressBinding then
		local t3 = {
			progressBinding = buttonConfig.progressBinding,
			size = UDim2.fromScale(0.94, 0.94),
			zIndex = 3
		}
		t3.color = if p1[pressedEventKey] and darkenedColor then darkenedColor else baseColor
		childElements.Progress = createElement(CircularProgressBar, t3)
	end
	local t3 = {
		ZIndex = p4,
		BackgroundTransparency = 1,
		Size = p5,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = p6,
		Image = "rbxassetid://7852334955"
	}
	t3.Active = buttonConfig and not buttonConfig.noSink
	t3.ImageColor3 = if p1[pressedEventKey] and darkenedColor then darkenedColor else baseColor
	t3[Roact.Event.InputBegan] = function(p12, p2)
		if p2.UserInputType == Enum.UserInputType.Touch or p2.UserInputType == Enum.UserInputType.MouseButton1 then
			local allowTouchSlide = buttonConfig.allowTouchSlide
			if allowTouchSlide then
				allowTouchSlide = p2.UserInputState == Enum.UserInputState.Change
			end
			if p2.UserInputState == Enum.UserInputState.Begin or allowTouchSlide then
				buttonConfig._inputTypePressed = p2.UserInputType
				if p1[onPressedEventKey] then
					p1[onPressedEventKey](p2.UserInputType)
				end
				local pressedCallback = p1[onReleasedEventKey]
				buttonConfig._enteredViaSlide = allowTouchSlide
				buttonConfig._maid.waitForEnd = p2:GetPropertyChangedSignal("UserInputState"):Connect(function()
					if p2.UserInputState == Enum.UserInputState.End then
						buttonConfig._maid.waitForEnd = nil
						if pressedCallback then
							pressedCallback(p2.UserInputType)
						end
					end
				end)
			end
		end
	end
	t3[Roact.Event.MouseLeave] = function()
		if buttonConfig and buttonConfig._enteredViaSlide then
			buttonConfig._maid.waitForEnd = nil
			local releasedCallback = p1[onReleasedEventKey]
			if releasedCallback then
				releasedCallback()
			end
		end
	end
	return createElement("ImageButton", t3, childElements)
end
