local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local PlayerUtils = require(ReplicatedStorage.Std.PlayerUtils)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local String = require(ReplicatedStorage.Std.String)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local ClanConsts = require(ReplicatedStorage.Clan.ClanConsts)
local TextButton = require(script.Parent.TextButton)
local horizontalSquareGrid = require(ReplicatedStorage.PersistentCrew.UI.horizontalSquareGrid)
local function colorComponent(p1) --[[ Line: 15 | Upvalues: createElement (copy), Roact (copy), ColorUtils (copy) ]]
	local isName = p1.selectedColorName == p1.name
	local t = {
		BorderSizePixel = 0,
		BackgroundColor3 = p1.color,
		Size = p1.size,
		Position = p1.position,
		Text = "",
		[Roact.Event.Activated] = function() --[[ Line: 23 | Upvalues: p1 (copy) ]]
			p1.setSelectedColorName(p1.name)
		end
	}
	local t2 = {
		Corner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	}
	local t3 = {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	}
	t3.Thickness = if isName then 2 else 1
	t3.Color = ColorUtils.brightenBy(p1.color, -0.3)
	t2.Stroke = createElement("UIStroke", t3)
	t2.Selected = isName and createElement("TextLabel", {
		BackgroundTransparency = 1,
		Text = "\226\156\147",
		Font = Enum.Font.SourceSansBold,
		TextScaled = true,
		TextColor3 = Color3.new(255/255, 255/255, 255/255),
		Size = UDim2.fromScale(1.2, 1.2),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5)
	})
	return createElement("TextButton", t, t2)
end
local v1 = Roact.PureComponent:extend("JoinOrCreate")
function v1.init(p1) --[[ Line: 50 | Upvalues: Roact (copy), PlayerUtils (copy), ClanConsts (copy) ]]
	p1.playerTextBoxRef = Roact.createRef()
	function p1.onClickView() --[[ Line: 53 | Upvalues: p1 (copy), PlayerUtils (ref) ]]
		local v1 = p1.playerTextBoxRef:getValue()
		local Text = v1.Text
		v1.Text = ""
		PlayerUtils.promiseUserIdFromName(Text):andThen(function(p12) --[[ Line: 57 | Upvalues: p1 (ref) ]]
			p1.props.attemptViewUserIdClan(p12)
		end)
	end
	function p1.playerTextBoxFocusLost(p12, p2) --[[ Line: 61 | Upvalues: p1 (copy) ]]
		if p2 then
			p1.onClickView()
		end
	end
	local v1 = nil
	function p1.playerTextBoxTextChanged(p12) --[[ Line: 67 | Upvalues: v1 (ref), PlayerUtils (ref), p1 (copy), Roact (ref) ]]
		if v1 then
			task.cancel(v1)
			v1 = nil
		end
		local v12 = nil
		v12 = task.delay(0.5, function() --[[ Line: 73 | Upvalues: p12 (copy), PlayerUtils (ref), v1 (ref), v12 (ref), p1 (ref), Roact (ref) ]]
			PlayerUtils.promiseUserIdFromName(p12.Text):andThen(function(p12) --[[ Line: 76 | Upvalues: v1 (ref), v12 (ref), p1 (ref) ]]
				if v1 == v12 then
					p1:setState({
						avatarUserId = p12
					})
				end
			end):catch(function() --[[ Line: 84 | Upvalues: v1 (ref), v12 (ref), p1 (ref), Roact (ref) ]]
				if v1 == v12 then
					p1:setState({
						avatarUserId = Roact.None
					})
				end
			end)
		end)
		v1 = v12
	end
	p1.crewNameRef = Roact.createRef()
	function p1.onClickCreate() --[[ Line: 98 | Upvalues: p1 (copy) ]]
		local v1 = p1.crewNameRef:getValue()
		local Text = v1.Text
		v1.Text = ""
		p1.props.attemptCreate(Text, p1.state.selectedColorName)
	end
	function p1.crewNameTextBoxFocusLost(p12, p2) --[[ Line: 104 | Upvalues: p1 (copy) ]]
		if p2 then
			p1.onClickCreate()
		end
	end
	function p1.setSelectedColorName(p12) --[[ Line: 109 | Upvalues: p1 (copy) ]]
		p1:setState({
			selectedColorName = p12
		})
	end
	p1:setState({
		selectedColorName = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].name
	})
end
function v1.render(p1) --[[ Line: 119 | Upvalues: ClanConsts (copy), createElement (copy), PaddedContainer (copy), Roact (copy), TextButton (copy), horizontalSquareGrid (copy), colorComponent (copy), String (copy), Dictionary (copy) ]]
	local t = {}
	for v1, v2 in ClanConsts.CLAN_COLORS do
		table.insert(t, v2)
	end
	local t3 = {
		Title = createElement(PaddedContainer, {
			backgroundColor = Color3.new(51/255, 51/255, 51/255),
			backgroundTransparency = 0,
			size = UDim2.new(1, 0, 0.16666666666666666, 0),
			paddingLeft = 0,
			paddingRight = 0,
			paddingTop = 0,
			paddingBottom = 0.5
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 8)
			}),
			Title = createElement("Frame", {
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0, 0, 0, 0)
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.9, 0, 0.9, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Font = Enum.Font.FredokaOne,
					Text = "Welcome to CREWS!",
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.fromRGB(0, 162, 255)
				})
			})
		})
	}
	local t4 = {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.7222222222222223, 0),
		position = UDim2.new(0, 0, 0.16666666666666666, 0),
		paddingLeft = 0,
		paddingRight = 0,
		paddingTop = 0.5,
		paddingBottom = 0.5
	}
	local t5 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 8)
		})
	}
	local t6 = {
		BorderSizePixel = 0,
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.new(51/255, 51/255, 51/255),
		Size = UDim2.new(0.4625, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0)
	}
	local t7 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 8)
		})
	}
	local t8 = {
		ContainerTitle = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			size = UDim2.new(1, 0, 0.25, 0),
			paddingTop = 0,
			paddingLeft = 0,
			paddingRight = 0,
			paddingBottom = 0.5
		}, {
			Title = createElement("Frame", {
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 0.75, 0),
				Position = UDim2.new(0.5, 0, 1, 0),
				AnchorPoint = Vector2.new(0.5, 1)
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Font = Enum.Font.Bangers,
					Text = "VIEW A CREW",
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			})
		})
	}
	local t9 = {
		backgroundColor = Color3.new(255/255, 0/255, 0/255),
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.75, 0),
		position = UDim2.new(0, 0, 0.25, 0),
		paddingTop = 0.5,
		paddingLeft = 0,
		paddingRight = 0,
		paddingBottom = 0
	}
	local t10 = {
		UserIdContainer = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = UDim2.new(1, 0, 0.15, 0),
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
				AspectRatio = 10
			}),
			Input = createElement("TextBox", {
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 255/255),
				BorderSizePixel = 0,
				Size = UDim2.new(0.8, 0, 1, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				PlaceholderText = "Username of crew member...",
				TextColor3 = Color3.new(0/255, 0/255, 0/255),
				Text = "",
				Font = Enum.Font.Bangers,
				TextScaled = true,
				[Roact.Ref] = p1.playerTextBoxRef,
				[Roact.Event.FocusLost] = p1.playerTextBoxFocusLost,
				[Roact.Change.Text] = p1.playerTextBoxTextChanged
			})
		})
	}
	local t11 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.65, 0),
		Position = UDim2.new(0, 0, 0.15, 0)
	}
	local t12 = {}
	local t13 = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		BackgroundTransparency = 1
	}
	t13.Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=" .. tostring(p1.state.avatarUserId or 1)
	t13.Size = UDim2.fromScale(0.9, 0.9)
	t13.Position = UDim2.new(0.5, 0, 0.5, 0)
	t13.AnchorPoint = Vector2.new(0.5, 0.5)
	t12.Avatar = createElement("ImageLabel", t13, {
		UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1,
			AspectType = Enum.AspectType.FitWithinMaxSize,
			DominantAxis = Enum.DominantAxis.Height
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	})
	t10.Center = createElement("Frame", t11, t12)
	t10.RequestButton = createElement(TextButton, {
		size = UDim2.new(1, 0, 0.2, 0),
		position = UDim2.new(0.5, 0, 1, 0),
		anchorPoint = Vector2.new(0.5, 1),
		text = "VIEW",
		backgroundColor = Color3.fromRGB(88, 172, 246),
		onClick = p1.onClickView,
		disabled = p1.props.networkMutexLocked
	})
	t8.ContainerBody = createElement(PaddedContainer, t9, t10)
	t7.Container = createElement(PaddedContainer, {
		backgroundTransparency = 1
	}, t8)
	t5.Left = createElement("Frame", t6, t7)
	t5.LineTop = createElement("Frame", {
		BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 1, 0.4375, 0),
		Position = UDim2.new(0.5, 0, 0, 0)
	})
	t5.LineBottom = createElement("Frame", {
		BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 1, 0.4375, 0),
		Position = UDim2.new(0.5, 0, 0.5625, 0)
	})
	t5.OrText = createElement("TextLabel", {
		Font = Enum.Font.Bangers,
		TextScaled = true,
		BackgroundTransparency = 1,
		Text = "OR",
		TextColor3 = Color3.new(0.3, 0.3, 0.3),
		Size = UDim2.fromScale(0.1125, 0.1125),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5)
	})
	t5.Right = createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.new(51/255, 51/255, 51/255),
		Size = UDim2.new(0.4625, 0, 1, 0),
		Position = UDim2.new(0.5375, 0, 0, 0)
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 8)
		}),
		Container = createElement(PaddedContainer, {
			backgroundTransparency = 1
		}, {
			ContainerTitle = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				size = UDim2.new(1, 0, 0.25, 0),
				paddingTop = 0,
				paddingLeft = 0,
				paddingRight = 0,
				paddingBottom = 0.5
			}, {
				Title = createElement("Frame", {
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
					Size = UDim2.new(1, 0, 0.75, 0),
					Position = UDim2.new(0.5, 0, 1, 0),
					AnchorPoint = Vector2.new(0.5, 1)
				}, {
					Text = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Font = Enum.Font.Bangers,
						Text = "CREATE YOUR OWN",
						LineHeight = 1,
						TextScaled = true,
						TextColor3 = Color3.new(255/255, 255/255, 255/255)
					})
				})
			}),
			ContainerBody = createElement(PaddedContainer, {
				backgroundColor = Color3.new(255/255, 0/255, 0/255),
				backgroundTransparency = 1,
				size = UDim2.new(1, 0, 0.75, 0),
				position = UDim2.new(0, 0, 0.25, 0),
				paddingTop = 0.5,
				paddingLeft = 0,
				paddingRight = 0,
				paddingBottom = 0
			}, {
				Center = createElement("Frame", {
					BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0.8, 0)
				}, {
					Container = createElement("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0.2, 0)
					}, {
						UserIdContainer = createElement("Frame", {
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
							Size = UDim2.new(1, 0, 1, 0),
							AnchorPoint = Vector2.new(0.5, 1),
							Position = UDim2.new(0.5, 0, 1, 0)
						}, {
							UICorner = createElement("UICorner", {
								CornerRadius = UDim.new(1, 0)
							}),
							UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
								AspectRatio = 10
							}),
							Input = createElement("TextBox", {
								BackgroundTransparency = 1,
								BackgroundColor3 = Color3.new(255/255, 0/255, 255/255),
								BorderSizePixel = 0,
								Size = UDim2.new(0.8, 0, 1, 0),
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.new(0.5, 0, 0.5, 0),
								PlaceholderText = "Name your crew...",
								Text = "",
								Font = Enum.Font.Bangers,
								TextScaled = true,
								TextColor3 = Color3.new(0/255, 0/255, 0/255),
								[Roact.Ref] = p1.crewNameRef,
								[Roact.Event.FocusLost] = p1.crewNameTextBoxFocusLost
							})
						})
					}),
					Colors = createElement("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0.5, 0),
						Position = UDim2.new(0, 0, 0.2, 0)
					}, {
						Title = createElement("Frame", {
							BackgroundTransparency = 1,
							BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
							Size = UDim2.new(1, 0, 0.5, 0),
							Position = UDim2.new(0.5, 0, 0, 0),
							AnchorPoint = Vector2.new(0.5, 0)
						}, {
							Text = createElement("TextLabel", {
								BackgroundTransparency = 1,
								Size = UDim2.new(1, 0, 0.5, 0),
								Position = UDim2.new(0.5, 0, 1, 0),
								AnchorPoint = Vector2.new(0.5, 1),
								Font = Enum.Font.Bangers,
								Text = "CREW COLOR",
								LineHeight = 1,
								TextScaled = true,
								TextColor3 = Color3.new(0.7, 0.7, 0.7)
							})
						}),
						ColorsContainer = createElement(PaddedContainer, {
							backgroundColor = Color3.new(255/255, 255/255, 255/255),
							size = UDim2.fromScale(1, 0.5),
							position = UDim2.fromScale(0, 0.5),
							paddingLeft = 0,
							paddingRight = 0
						}, {
							Corner = createElement("UICorner", {
								CornerRadius = UDim.new(1, 0)
							}),
							Grid = createElement(horizontalSquareGrid, {
								exposePaddedContainerProps = true,
								component = colorComponent,
								items = t,
								itemMetadata = {
									selectedColorName = p1.state.selectedColorName,
									setSelectedColorName = p1.setSelectedColorName
								}
							})
						})
					})
				}),
				CreateButton = createElement(TextButton, {
					size = UDim2.new(1, 0, 0.2, 0),
					position = UDim2.new(0.5, 0, 1, 0),
					anchorPoint = Vector2.new(0.5, 1),
					text = "CREATE for $" .. String.comma(ClanConsts.CLAN_CREATION_COST),
					backgroundColor = Color3.fromRGB(116, 229, 156),
					onClick = p1.onClickCreate,
					disabled = p1.props.networkMutexLocked
				})
			})
		})
	})
	t3.Body = createElement(PaddedContainer, t4, t5)
	t3.Bottom = createElement(PaddedContainer, {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		size = UDim2.new(1, 0, 0.1111111111111111, 0),
		position = UDim2.new(0, 0, 0.8888888888888888, 0),
		paddingLeft = 0,
		paddingRight = 0,
		paddingTop = 0.5,
		paddingBottom = 0
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		UIListLayout = createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			SortOrder = Enum.SortOrder.LayoutOrder
		}),
		CloseContainer = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.15, 0, 1, 0),
			LayoutOrder = 2
		}, {
			Container = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				paddingLeft = 0.5,
				paddingRight = 1
			}, {
				Button = createElement(TextButton, {
					size = UDim2.new(1, 0, 1, 0),
					position = UDim2.new(1, 0, 0, 0),
					anchorPoint = Vector2.new(1, 0),
					text = "CLOSE",
					backgroundColor = Color3.fromRGB(233, 76, 64),
					onClick = p1.props.onClickClose
				})
			})
		})
	})
	return createElement(PaddedContainer, {
		backgroundTransparency = 1,
		backgroundColor = Color3.new(255/255, 255/255, 255/255),
		aspectRatio = p1.props.aspectRatio,
		verticalPaddingRatio = p1.props.verticalPaddingRatio
	}, Dictionary.merge(p1.props[Roact.Children], t3))
end
return v1