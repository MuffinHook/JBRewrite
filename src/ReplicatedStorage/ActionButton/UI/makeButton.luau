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
return function(config, buttonId, actionName, zIndex, buttonSize, buttonPosition)
	local pressedEventKey = ("%s_%d_%s"):format(buttonId, actionName, "pressed")
	local onReleasedEventKey = ("%s_%d_%s"):format(buttonId, actionName, "onReleased")
	local onPressedEventKey = ("%s_%d_%s"):format(buttonId, actionName, "onPressed")
	local imageEventKey = ("%s_%d_%s"):format(buttonId, actionName, "image")
	local keyCodeEventKey = ("%s_%d_%s"):format(buttonId, actionName, "keyCode")
	local buttonConfig = config[("%s_%d_%s"):format(buttonId, actionName, "button")]
	local inputKeyCode = config[keyCodeEventKey]
	local baseColor = config.color or Color3.new(255/255, 255/255, 255/255)
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
		Image = config[imageEventKey]
	}
	imageLabelProps.ImageColor3 = if config[pressedEventKey] and darkenedColor then darkenedColor else baseColor
	local childElements = {}
	if buttonConfig and buttonConfig.title then
		imageLabelProps.Position = UDim2.new(0.5, 0, 0.4, 0)
		imageLabelProps.Size = UDim2.new(1, 0, 0.8, 0)
		local textLabelProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.8, 0, 0.2, 0),
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0.6, 0)
		}
		textLabelProps.TextColor3 = if config[pressedEventKey] and darkenedColor then darkenedColor else baseColor
		textLabelProps.TextScaled = true
		textLabelProps.Text = buttonConfig.title
		textLabelProps.Font = Enum.Font.LuckiestGuy
		childElements.Label = createElement("TextLabel", textLabelProps)
	end
	childElements.ImageLabel = createElement("ImageLabel", imageLabelProps, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		})
	})
	local inputIconScale = if config[pressedEventKey] then 0.5 else 1
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
		local progressBarConfig = {
			progressBinding = buttonConfig.progressBinding,
			size = UDim2.fromScale(0.94, 0.94),
			zIndex = 3
		}
		progressBarConfig.color = if config[pressedEventKey] and darkenedColor then darkenedColor else baseColor
		childElements.Progress = createElement(CircularProgressBar, progressBarConfig)
	end
	local buttonProps = {
		ZIndex = zIndex,
		BackgroundTransparency = 1,
		Size = buttonSize,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = buttonPosition,
		Image = "rbxassetid://7852334955"
	}
	buttonProps.Active = buttonConfig and not buttonConfig.noSink
	buttonProps.ImageColor3 = if config[pressedEventKey] and darkenedColor then darkenedColor else baseColor
	buttonProps[Roact.Event.InputBegan] = function(button, inputEvent)
		if inputEvent.UserInputType == Enum.UserInputType.Touch or inputEvent.UserInputType == Enum.UserInputType.MouseButton1 then
			local allowTouchSlide = buttonConfig.allowTouchSlide
			if allowTouchSlide then
				allowTouchSlide = inputEvent.UserInputState == Enum.UserInputState.Change
			end
			if inputEvent.UserInputState == Enum.UserInputState.Begin or allowTouchSlide then
				buttonConfig._inputTypePressed = inputEvent.UserInputType
				if config[onPressedEventKey] then
					config[onPressedEventKey](inputEvent.UserInputType)
				end
				local pressedCallback = config[onReleasedEventKey]
				buttonConfig._enteredViaSlide = allowTouchSlide
				buttonConfig._maid.waitForEnd = inputEvent:GetPropertyChangedSignal("UserInputState"):Connect(function()
					if inputEvent.UserInputState == Enum.UserInputState.End then
						buttonConfig._maid.waitForEnd = nil
						if pressedCallback then
							pressedCallback(inputEvent.UserInputType)
						end
					end
				end)
			end
		end
	end
	buttonProps[Roact.Event.MouseLeave] = function()
		if buttonConfig and buttonConfig._enteredViaSlide then
			buttonConfig._maid.waitForEnd = nil
			local releasedCallback = config[onReleasedEventKey]
			if releasedCallback then
				releasedCallback()
			end
		end
	end
	return createElement("ImageButton", buttonProps, childElements)
end
