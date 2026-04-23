-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local RewardSpinnerConsts = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local v1 = Roact.PureComponent:extend("BriefcaseDisplay")
function v1.init(p1)
	p1.maid = Maid.new()
	p1:setState({
		probs = {}
	})
end
function v1.render(p1)
	local v1 = p1.props.probs or p1.state.probs
	local v2 = #RewardSpinnerConsts.RARITIES
	local t = {}
	for i = 1, v2 do
		local v3 = RewardSpinnerConsts.RARITIES[i]
		local v4 = (v1[v3.id] or 0) / 100
		t[i] = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1 / v2, 0),
			Position = UDim2.new(0, 0, (i - 1) / v2, 0)
		}, {
			Progress = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = v3.color,
				Size = UDim2.new(v4, 0, 1, 0)
			}),
			Title = createElement("Frame", {
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0, 0, 0, 0)
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.9, 0, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = ("%s: %d%%"):format(v3.name, v4 * 100 or 0),
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = ColorUtils.brightenBy(v3.color, -0.9)
				})
			})
		})
	end
	return createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1
	}, t)
end
function v1.didMount(p1)
	if p1.props.probsFolder then
		local function f()
			local t = {}
			for i = 1, #RewardSpinnerConsts.RARITIES do
				local v1 = p1.props.probsFolder:FindFirstChild((tostring(i)))
				if v1 then
					t[i] = v1.Value
				end
			end
			p1:setState({
				probs = t
			})
		end
		p1.maid:GiveTask(RxInstanceUtils.observeChildren(p1.props.probsFolder, function(p1, p2)
			f()
			p2:GiveTask(p1.Changed:Connect(f))
		end))
	end
end
function v1.willUnmount(p1)
	p1.maid:DoCleaning()
end
return v1