local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local Grid = require(ReplicatedStorage.EzUi.Grid)
local GridUtils = require(ReplicatedStorage.EzUi.GridUtils)
local rewardCardComponent = require(script.Parent.rewardCardComponent)
local RewardSpinnerConsts = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local RewardSpinner = Roact.PureComponent:extend("RewardSpinner")
RewardSpinner.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0.5, 0, 0.5, 0),
	anchorPoint = Vector2.new(0.5, 0.5),
	aspectRatio = 2.75,
	cornerPixel = 4,
	colsPerRow = 5.5,
	primaryColor = Color3.fromRGB(215, 131, 255)
}
function RewardSpinner.init(self)
	self.maid = Maid.new()
	self.openMaid = Maid.new()
	local indexBinding, updateIndex = Roact.createBinding((math.ceil(self.props.colsPerRow * 0.5 + 0.5)))
	self.index = indexBinding
	self.updateIndex = updateIndex
	local tickedBinding, updateTicked = Roact.createBinding(false)
	self.ticked = tickedBinding
	self.updateTicked = updateTicked
	function self.onFinished()
		local collectRewardRemote = ReplicatedStorage:FindFirstChild(RewardSpinnerConsts.COLLECT_REWARD_REMOTE_NAME)
		if collectRewardRemote then
			collectRewardRemote:FireServer(self.props.config.topic)
		end
		self.openMaid:GiveTask(task.delay(1, function()
			self.props.close()
		end))
	end
	function self.playTick()
		if Players.LocalPlayer then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 156286438)
		end
	end
end
function RewardSpinner.render(self)
	if self.props.config then
		local rewardColor = self.props.config.primaryColor or self.props.primaryColor
		local aspectRatio = self.props.aspectRatio
		local topSectionWidthRatio = 1 - 0.03125 / aspectRatio
		local topIconWidthRatio = topSectionWidthRatio / 0.1515625 * aspectRatio
		local topTitleWidthRatio = 1 - 1 / topIconWidthRatio - 0.10309278350515465 / topIconWidthRatio
		local topTitleHeightOffset = topTitleWidthRatio / 1 * topIconWidthRatio
		local bodySectionWidthRatio = 1 - 0.03125 / aspectRatio
		local bodyGridWidthRatio = bodySectionWidthRatio / 0.8015625 * aspectRatio
		local bodyContentWidthRatio = 1 - 0.038986354775828465 / bodyGridWidthRatio
		local bodyGridHeightRatio = 1.138568129330254 * (bodyContentWidthRatio / 0.9610136452241715 * bodyGridWidthRatio)
		local colsPerRow = self.props.colsPerRow
		local verticalPaddingPixels = 64 * bodyGridHeightRatio * 0.8015625 * 0.9610136452241715 * 0.8782961460446247
		local gridProps = {
			aspectRatio = bodyGridHeightRatio,
			items = self.props.config.items,
			component = rewardCardComponent,
			verticalPaddingRatio = verticalPaddingPixels / bodyGridHeightRatio,
			rowsPerPage = 1,
			colsPerRow = colsPerRow,
			infHorizontal = true
		}
		local containerProps = {
			BorderSizePixel = 0,
			BackgroundTransparency = 0.8,
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			Size = self.props.size,
			Position = self.props.position,
			AnchorPoint = self.props.anchorPoint
		}
		local mainChildren = {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = self.props.aspectRatio
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, self.props.cornerPixel)
			})
		}
		local topFrameProps = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.015625 / aspectRatio, 0, 0.015625, 0),
			Size = UDim2.new(topSectionWidthRatio, 0, 0.1515625, 0)
		}
		local topChildren = {}
		local iconFrameProps = {
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			BorderSizePixel = 0,
			Size = UDim2.new(1 / topIconWidthRatio, 0, 1, 0)
		}
		local iconChildren = {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, self.props.cornerPixel)
			})
		}
		local circleProps = {
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = rewardColor
		}
		local circleChildren = {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			})
		}
		local imageProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}
		imageProps.Image = self.props.config.iconImageId and "rbxassetid://" .. tostring(self.props.config.iconImageId) or nil
		circleChildren.Image = createElement("ImageLabel", imageProps)
		iconChildren.Circle = createElement("Frame", circleProps, circleChildren)
		topChildren.Icon = createElement("Frame", iconFrameProps, iconChildren)
		topChildren.Title = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			Size = UDim2.new(topTitleWidthRatio, 0, 1, 0),
			Position = UDim2.new(1 / topIconWidthRatio + 0.10309278350515465 / topIconWidthRatio, 0, 0, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, self.props.cornerPixel)
			}),
			Container = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
				Size = UDim2.new(0.5 - 0.10309278350515465 / topTitleHeightOffset, 0, 1, 0),
				Position = UDim2.new(0.10309278350515465 / topTitleHeightOffset, 0, 0, 0)
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = self.props.config.title,
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = rewardColor
				})
			})
		})
		mainChildren.Top = createElement("Frame", topFrameProps, topChildren)
		mainChildren.Body = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			BackgroundTransparency = 0,
			Position = UDim2.new(0.015625 / aspectRatio, 0, 0.1828125, 0),
			Size = UDim2.new(bodySectionWidthRatio, 0, 0.8015625, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, self.props.cornerPixel)
			}),
			InnerBody = createElement("Frame", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0.019493177387914232 / bodyGridWidthRatio, 0, 0.019493177387914232, 0),
				Size = UDim2.new(bodyContentWidthRatio, 0, 0.9610136452241715, 0),
				ZIndex = 0
			}, {
				Container = createElement("Frame", {
					BackgroundColor3 = Color3.new(102/255, 102/255, 102/255),
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(1, 0, 1, 0)
				}, {
					UICorner = createElement("UICorner", {
						CornerRadius = UDim.new(0, self.props.cornerPixel)
					}),
					Slider = createElement("Frame", {
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
						Size = UDim2.new(1, 0, 0.8782961460446247, 0),
						AnchorPoint = Vector2.new(0, 0.5),
						Position = self.index:map(function(currentIndex)
							return UDim2.new(-(currentIndex - colsPerRow * 0.5 - 0.5) * GridUtils.getScaleX(gridProps) - (currentIndex - colsPerRow * 0.5 - 0.5) / verticalPaddingPixels, 0, 0.5, 0)
						end)
					}, {
						Grid = createElement(Grid, gridProps)
					})
				})
			}),
			ArrowTop = createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.125 / bodyGridWidthRatio, 0, 0.0625, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.019493177387914232, 0),
				ZIndex = 3
			}, {
				Icon = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://10065704207",
					ImageColor3 = Color3.new(0/255, 0/255, 0/255),
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0, 0, 0.5, 0),
					Rotation = 180
				})
			}),
			ArrowBottom = createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.125 / bodyGridWidthRatio, 0, 0.0625, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.9805068226120858, 0),
				ZIndex = 3
			}, {
				Icon = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://10065704207",
					ImageColor3 = Color3.new(0/255, 0/255, 0/255),
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0, 0, -0.5, 0),
					Rotation = 0
				})
			})
		})
		local bottomFrameProps = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.005, 0, 1, 0),
			Size = UDim2.new(topSectionWidthRatio, 0, 0.1515625, 0)
		}
		local bottomChildren = {}
		bottomChildren.Title = self.props.config.extraText and createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 10)
			}),
			Container = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0, 0, 0, 0)
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = self.props.config.extraText .. " ",
					TextXAlignment = Enum.TextXAlignment.Right,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = rewardColor
				})
			})
		}) or nil
		mainChildren.Bottom = createElement("Frame", bottomFrameProps, bottomChildren)
		return createElement("Frame", containerProps, mainChildren)
	end
end
function RewardSpinner._spin(self)
	local previousIndex = 0
	local duration = self.props.config.duration
	local startTime = os.clock()
	local isFinished = false
	local startIndex = math.ceil(self.props.colsPerRow * 0.5 + 0.5)
	local maxVisibleIndex = #self.props.config.items - math.floor(self.props.colsPerRow * 0.5 + 0.5)
	local winIndex = self.props.config.winIndex
	if maxVisibleIndex < winIndex then
		warn("winIndex is > maxVisibleIndex, player will see empty space")
	end
	local targetIndex = winIndex + math.clamp(math.random() - 0.5, -0.48, 0.48)
	self.maid.spinHeartbeat = RunService.Heartbeat:Connect(function()
		local progress = (os.clock() - startTime) / duration
		if progress >= 1 then
			progress = 1
			if not isFinished then
				isFinished = true
				self.onFinished()
				if self.props.onFinished then
					self.props.onFinished()
				end
				self.maid.spinHeartbeat = nil
			end
		else
			isFinished = false
		end
		local currentIndexValue = startIndex + (targetIndex - startIndex) * (1 - math.pow(1 - progress, 2))
		local currentFraction = currentIndexValue % 1
		local previousFraction = previousIndex % 1
		local isMovingForward = currentIndexValue - previousIndex > 0
		if isMovingForward and (currentFraction > 0.5 and previousFraction < 0.5) or not isMovingForward and (currentFraction < 0.5 and previousFraction > 0.5) then
			self.playTick()
		end
		previousIndex = currentIndexValue
		self.updateIndex(currentIndexValue)
	end)
end
function RewardSpinner.didMount(self)
	if self.props.config then
		self:_spin()
	end
end
function RewardSpinner.didUpdate(self, previousProps, previousState)
	if self.props.config ~= previousProps.config then
		self.openMaid:DoCleaning()
		if self.props.config then
			self:_spin()
		end
	end
end
function RewardSpinner.willUnmount(self)
	self.maid:DoCleaning()
end
return RoactRodux.connect(function(state, dispatch)
	return {
		config = state.rewardSpinnerConfig
	}
end, function(dispatch)
	return {
		close = function()
			dispatch({
				type = "setRewardSpinnerConfig",
				items = nil
			})
		end
	}
end)(RewardSpinner)
