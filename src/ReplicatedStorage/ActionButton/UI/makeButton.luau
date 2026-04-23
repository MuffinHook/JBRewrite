local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CircularProgressBar = require(script.Parent.CircularProgressBar)
local ControllerImage = require(ReplicatedStorage.ControllerImage)
local InputUtils = require(script.Parent.InputUtils)
local Roact = require(ReplicatedStorage.Roact)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
return function(p1, p2, p3, p4, p5, p6) --[[ Line: 9 | Upvalues: ColorUtils (copy), createElement (copy), InputUtils (copy), ControllerImage (copy), UserInputService (copy), CircularProgressBar (copy), Roact (copy) ]]
	local v1 = ("%s_%d_%s"):format(p2, p3, "pressed")
	local v2 = ("%s_%d_%s"):format(p2, p3, "onReleased")
	local v3 = ("%s_%d_%s"):format(p2, p3, "onPressed")
	local v4 = ("%s_%d_%s"):format(p2, p3, "image")
	local v5 = ("%s_%d_%s"):format(p2, p3, "keyCode")
	local v6 = p1[("%s_%d_%s"):format(p2, p3, "button")]
	local v7 = p1[v5]
	local v8 = p1.color or Color3.new(255/255, 255/255, 255/255)
	if v6 and v6.saturateTo then
		v8 = ColorUtils.saturateTo(v8, v6.saturateTo)
	end
	local v10 = ColorUtils.brightenBy(v8, -0.3)
	local t = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.8, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Active = false,
		Image = p1[v4]
	}
	t.ImageColor3 = if p1[v1] and v10 then v10 else v8
	local t2 = {}
	if v6 and v6.title then
		t.Position = UDim2.new(0.5, 0, 0.4, 0)
		t.Size = UDim2.new(1, 0, 0.8, 0)
		local t3 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.8, 0, 0.2, 0),
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0.6, 0)
		}
		t3.TextColor3 = if p1[v1] and v10 then v10 else v8
		t3.TextScaled = true
		t3.Text = v6.title
		t3.Font = Enum.Font.LuckiestGuy
		t2.Label = createElement("TextLabel", t3)
	end
	t2.ImageLabel = createElement("ImageLabel", t, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1
		})
	})
	local v15 = if p1[v1] then 0.5 else 1
	if v7 and InputUtils.isGamepadKeyCode(v7) then
		t2.Input = ControllerImage:GetRoactImageLabel(v7, "Dark", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(0.7 * v15, 0, 0.7 * v15, 0),
			Position = UDim2.new(0.8, 0, 0.8, 0),
			ZIndex = 4
		})
	elseif v7 then
		local v16 = UserInputService:GetStringForKeyCode(v7)
		if v7 == Enum.KeyCode.LeftShift or v7 == Enum.KeyCode.RightShift then
			v16 = "Shift"
		elseif v7 == Enum.KeyCode.LeftControl or v7 == Enum.KeyCode.RightControl then
			v16 = "Ctrl"
		end
		if #v16 == 0 then
			v16 = v7.Name
		end
		t2.Input = createElement("TextLabel", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(0.5 * v15, 0, 0.5 * v15, 0),
			Position = UDim2.new(0.9, 0, 0.9, 0),
			TextColor3 = v8,
			TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255),
			TextStrokeTransparency = 0.7,
			Font = Enum.Font.LuckiestGuy,
			TextScaled = true,
			Text = v16:upper(),
			ZIndex = 4
		})
	end
	if v6 and v6.progressBinding then
		local t3 = {
			progressBinding = v6.progressBinding,
			size = UDim2.fromScale(0.94, 0.94),
			zIndex = 3
		}
		t3.color = if p1[v1] and v10 then v10 else v8
		t2.Progress = createElement(CircularProgressBar, t3)
	end
	local t3 = {
		ZIndex = p4,
		BackgroundTransparency = 1,
		Size = p5,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = p6,
		Image = "rbxassetid://7852334955"
	}
	t3.Active = v6 and not v6.noSink
	t3.ImageColor3 = if p1[v1] and v10 then v10 else v8
	t3[Roact.Event.InputBegan] = function(p12, p2) --[[ Line: 108 | Upvalues: v6 (copy), p1 (copy), v3 (copy), v2 (copy) ]]
		if p2.UserInputType == Enum.UserInputType.Touch or p2.UserInputType == Enum.UserInputType.MouseButton1 then
			local allowTouchSlide = v6.allowTouchSlide
			if allowTouchSlide then
				allowTouchSlide = p2.UserInputState == Enum.UserInputState.Change
			end
			if p2.UserInputState == Enum.UserInputState.Begin or allowTouchSlide then
				v6._inputTypePressed = p2.UserInputType
				if p1[v3] then
					p1[v3](p2.UserInputType)
				end
				local v1 = p1[v2]
				v6._enteredViaSlide = allowTouchSlide
				v6._maid.waitForEnd = p2:GetPropertyChangedSignal("UserInputState"):Connect(function() --[[ Line: 125 | Upvalues: p2 (copy), v6 (ref), v1 (copy) ]]
					if p2.UserInputState == Enum.UserInputState.End then
						v6._maid.waitForEnd = nil
						if v1 then
							v1(p2.UserInputType)
						end
					end
				end)
			end
		end
	end
	t3[Roact.Event.MouseLeave] = function() --[[ Line: 139 | Upvalues: v6 (copy), p1 (copy), v2 (copy) ]]
		if v6 and v6._enteredViaSlide then
			v6._maid.waitForEnd = nil
			local v1 = p1[v2]
			if v1 then
				v1()
			end
		end
	end
	return createElement("ImageButton", t3, t2)
end