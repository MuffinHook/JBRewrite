-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local RewardSpinnerConsts = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local BriefcaseDisplayComponent = Roact.PureComponent:extend("BriefcaseDisplay")
function BriefcaseDisplayComponent.init(self)
	self.maid = Maid.new()
	self:setState({
		probs = {}
	})
end
function BriefcaseDisplayComponent.render(self)
	local displayProbs = self.props.probs or self.state.probs
	local numRarities = #RewardSpinnerConsts.RARITIES
	local rarityRows = {}
	for i = 1, numRarities do
		local rarityInfo = RewardSpinnerConsts.RARITIES[i]
		local rarityProbability = (displayProbs[rarityInfo.id] or 0) / 100
		rarityRows[i] = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1 / numRarities, 0),
			Position = UDim2.new(0, 0, (i - 1) / numRarities, 0)
		}, {
			Progress = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = rarityInfo.color,
				Size = UDim2.new(rarityProbability, 0, 1, 0)
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
					Text = ("%s: %d%%"):format(rarityInfo.name, rarityProbability * 100 or 0),
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = ColorUtils.brightenBy(rarityInfo.color, -0.9)
				})
			})
		})
	end
	return createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1
	}, rarityRows)
end
function BriefcaseDisplayComponent.didMount(self)
	if self.props.probsFolder then
		local function updateProbabilities()
			local newProbs = {}
			for i = 1, #RewardSpinnerConsts.RARITIES do
				local rarityValue = self.props.probsFolder:FindFirstChild((tostring(i)))
				if rarityValue then
					newProbs[i] = rarityValue.Value
				end
			end
			self:setState({
				probs = newProbs
			})
		end
		self.maid:GiveTask(RxInstanceUtils.observeChildren(self.props.probsFolder, function(probsChild, childMaid)
			updateProbabilities()
			childMaid:GiveTask(probsChild.Changed:Connect(updateProbabilities))
		end))
	end
end
function BriefcaseDisplayComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return BriefcaseDisplayComponent
