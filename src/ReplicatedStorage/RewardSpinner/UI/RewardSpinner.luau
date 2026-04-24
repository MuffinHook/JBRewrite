-- Reviewed by Claude
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
local v1 = Roact.PureComponent:extend("RewardSpinner")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0.5, 0, 0.5, 0),
	anchorPoint = Vector2.new(0.5, 0.5),
	aspectRatio = 2.75,
	cornerPixel = 4,
	colsPerRow = 5.5,
	primaryColor = Color3.fromRGB(215, 131, 255)
}
function v1.init(p1)
	p1.maid = Maid.new()
	p1.openMaid = Maid.new()
	local v2, var3 = Roact.createBinding((math.ceil(p1.props.colsPerRow * 0.5 + 0.5)))
	p1.index = v2
	p1.updateIndex = var3
	local var4, var5 = Roact.createBinding(false)
	p1.ticked = var4
	p1.updateTicked = var5
	function p1.onFinished()
		local v1 = ReplicatedStorage:FindFirstChild(RewardSpinnerConsts.COLLECT_REWARD_REMOTE_NAME)
		if v1 then
			v1:FireServer(p1.props.config.topic)
		end
		p1.openMaid:GiveTask(task.delay(1, function()
			p1.props.close()
		end))
	end
	function p1.playTick()
		if Players.LocalPlayer then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 156286438)
		end
	end
end
function v1.render(p1)
	if p1.props.config then
		local v1 = p1.props.config.primaryColor or p1.props.primaryColor
		local aspectRatio = p1.props.aspectRatio
		local v2 = 1 - 0.03125 / aspectRatio
		local var3 = v2 / 0.1515625 * aspectRatio
		local var4 = 1 - 1 / var3 - 0.10309278350515465 / var3
		local var5 = var4 / 1 * var3
		local var6 = 1 - 0.03125 / aspectRatio
		local var7 = var6 / 0.8015625 * aspectRatio
		local count = 1 - 0.038986354775828465 / var7
		local var9 = 1.138568129330254 * (count / 0.9610136452241715 * var7)
		local colsPerRow = p1.props.colsPerRow
		local var10 = 64 * var9 * 0.8015625 * 0.9610136452241715 * 0.8782961460446247
		local t = {
			aspectRatio = var9,
			items = p1.props.config.items,
			component = rewardCardComponent,
			verticalPaddingRatio = var10 / var9,
			rowsPerPage = 1,
			colsPerRow = colsPerRow,
			infHorizontal = true
		}
		local t2 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 0.8,
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			Size = p1.props.size,
			Position = p1.props.position,
			AnchorPoint = p1.props.anchorPoint
		}
		local t3 = {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = p1.props.aspectRatio
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, p1.props.cornerPixel)
			})
		}
		local t4 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.015625 / aspectRatio, 0, 0.015625, 0),
			Size = UDim2.new(v2, 0, 0.1515625, 0)
		}
		local tbl = {}
		local t6 = {
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			BorderSizePixel = 0,
			Size = UDim2.new(1 / var3, 0, 1, 0)
		}
		local t7 = {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, p1.props.cornerPixel)
			})
		}
		local t8 = {
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = v1
		}
		local t9 = {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			})
		}
		local t10 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}
		t10.Image = p1.props.config.iconImageId and "rbxassetid://" .. tostring(p1.props.config.iconImageId) or nil
		t9.Image = createElement("ImageLabel", t10)
		t7.Circle = createElement("Frame", t8, t9)
		tbl.Icon = createElement("Frame", t6, t7)
		tbl.Title = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			Size = UDim2.new(var4, 0, 1, 0),
			Position = UDim2.new(1 / var3 + 0.10309278350515465 / var3, 0, 0, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, p1.props.cornerPixel)
			}),
			Container = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
				Size = UDim2.new(0.5 - 0.10309278350515465 / var5, 0, 1, 0),
				Position = UDim2.new(0.10309278350515465 / var5, 0, 0, 0)
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = p1.props.config.title,
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = v1
				})
			})
		})
		t3.Top = createElement("Frame", t4, tbl)
		t3.Body = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			BackgroundTransparency = 0,
			Position = UDim2.new(0.015625 / aspectRatio, 0, 0.1828125, 0),
			Size = UDim2.new(var6, 0, 0.8015625, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, p1.props.cornerPixel)
			}),
			InnerBody = createElement("Frame", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0.019493177387914232 / var7, 0, 0.019493177387914232, 0),
				Size = UDim2.new(count, 0, 0.9610136452241715, 0),
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
						CornerRadius = UDim.new(0, p1.props.cornerPixel)
					}),
					Slider = createElement("Frame", {
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
						Size = UDim2.new(1, 0, 0.8782961460446247, 0),
						AnchorPoint = Vector2.new(0, 0.5),
						Position = p1.index:map(function(p1)
							return UDim2.new(-(p1 - colsPerRow * 0.5 - 0.5) * GridUtils.getScaleX(t) - (p1 - colsPerRow * 0.5 - 0.5) / var10, 0, 0.5, 0)
						end)
					}, {
						Grid = createElement(Grid, t)
					})
				})
			}),
			ArrowTop = createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.125 / var7, 0, 0.0625, 0),
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
				Size = UDim2.new(0.125 / var7, 0, 0.0625, 0),
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
		local t11 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.005, 0, 1, 0),
			Size = UDim2.new(v2, 0, 0.1515625, 0)
		}
		local tbl2 = {}
		tbl2.Title = p1.props.config.extraText and createElement("Frame", {
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
					Text = p1.props.config.extraText .. " ",
					TextXAlignment = Enum.TextXAlignment.Right,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = v1
				})
			})
		}) or nil
		t3.Bottom = createElement("Frame", t11, tbl2)
		return createElement("Frame", t2, t3)
	end
end
function v1._spin(p1)
	local v1 = 0
	local duration = p1.props.config.duration
	local v2 = os.clock()
	local var3 = false
	local var5 = math.ceil(p1.props.colsPerRow * 0.5 + 0.5)
	local count = #p1.props.config.items - math.floor(p1.props.colsPerRow * 0.5 + 0.5)
	local winIndex = p1.props.config.winIndex
	if count < winIndex then
		warn("winIndex is > maxVisibleIndex, player will see empty space")
	end
	local var10 = winIndex + math.clamp(math.random() - 0.5, -0.48, 0.48)
	p1.maid.spinHeartbeat = RunService.Heartbeat:Connect(function()
		local var12 = (os.clock() - v2) / duration
		if var12 >= 1 then
			var12 = 1
			if not var3 then
				var3 = true
				p1.onFinished()
				if p1.props.onFinished then
					p1.props.onFinished()
				end
				p1.maid.spinHeartbeat = nil
			end
		else
			var3 = false
		end
		local var22 = var5 + (var10 - var5) * (1 - math.pow(1 - var12, 2))
		local var32 = var22 % 1
		local var4 = v1 % 1
		local var52 = var22 - v1 > 0
		if var52 and (var32 > 0.5 and var4 < 0.5) or not var52 and (var32 < 0.5 and var4 > 0.5) then
			p1.playTick()
		end
		v1 = var22
		p1.updateIndex(var22)
	end)
end
function v1.didMount(p1)
	if p1.props.config then
		p1:_spin()
	end
end
function v1.didUpdate(p1, p2, p3)
	if p1.props.config ~= p2.config then
		p1.openMaid:DoCleaning()
		if p1.props.config then
			p1:_spin()
		end
	end
end
function v1.willUnmount(p1)
	p1.maid:DoCleaning()
end
return RoactRodux.connect(function(p1, p2)
	return {
		config = p1.rewardSpinnerConfig
	}
end, function(p1)
	return {
		close = function()
			p1({
				type = "setRewardSpinnerConfig",
				items = nil
			})
		end
	}
end)(v1)
