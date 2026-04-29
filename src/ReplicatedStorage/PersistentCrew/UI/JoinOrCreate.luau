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
local function colorComponent(self)
	local isName = self.selectedColorName == self.name
	local colorButtonProps = {
		BorderSizePixel = 0,
		BackgroundColor3 = self.color,
		Size = self.size,
		Position = self.position,
		Text = "",
		[Roact.Event.Activated] = function()
			self.setSelectedColorName(self.name)
		end
	}
	local cornerAndStrokeChildren = {
		Corner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	}
	local strokeProps = {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	}
	strokeProps.Thickness = if isName then 2 else 1
	strokeProps.Color = ColorUtils.brightenBy(self.color, -0.3)
	cornerAndStrokeChildren.Stroke = createElement("UIStroke", strokeProps)
	cornerAndStrokeChildren.Selected = isName and createElement("TextLabel", {
		BackgroundTransparency = 1,
		Text = "\226\156\147",
		Font = Enum.Font.SourceSansBold,
		TextScaled = true,
		TextColor3 = Color3.new(255/255, 255/255, 255/255),
		Size = UDim2.fromScale(1.2, 1.2),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5)
	})
	return createElement("TextButton", colorButtonProps, cornerAndStrokeChildren)
end
local JoinOrCreateComponent = Roact.PureComponent:extend("JoinOrCreate")
function JoinOrCreateComponent.init(self)
	self.playerTextBoxRef = Roact.createRef()
	function self.onClickView()
		local textBoxInstance = self.playerTextBoxRef:getValue()
		local Text = textBoxInstance.Text
		textBoxInstance.Text = ""
		PlayerUtils.promiseUserIdFromName(Text):andThen(function(self)
			self.props.attemptViewUserIdClan(self)
		end)
	end
	function self.playerTextBoxFocusLost(self, isEnter)
		if isEnter then
			self.onClickView()
		end
	end
	local pendingRequestId = nil
	function self.playerTextBoxTextChanged(self)
		if pendingRequestId then
			task.cancel(pendingRequestId)
			pendingRequestId = nil
		end
		local currentRequestId = nil
		currentRequestId = task.delay(0.5, function()
			PlayerUtils.promiseUserIdFromName(self.Text):andThen(function(self)
				if pendingRequestId == currentRequestId then
					self:setState({
						avatarUserId = self
					})
				end
			end):catch(function()
				if pendingRequestId == currentRequestId then
					self:setState({
						avatarUserId = Roact.None
					})
				end
			end)
		end)
		pendingRequestId = currentRequestId
	end
	self.crewNameRef = Roact.createRef()
	function self.onClickCreate()
		local textBoxInstance = self.crewNameRef:getValue()
		local Text = textBoxInstance.Text
		textBoxInstance.Text = ""
		self.props.attemptCreate(Text, self.state.selectedColorName)
	end
	function self.crewNameTextBoxFocusLost(self, isEnter)
		if isEnter then
			self.onClickCreate()
		end
	end
	function self.setSelectedColorName(self)
		self:setState({
			selectedColorName = self
		})
	end
	self:setState({
		selectedColorName = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].name
	})
end
function JoinOrCreateComponent.render(self)
	local clanColorsList = {}
	for colorIndex, colorData in ClanConsts.CLAN_COLORS do
		table.insert(clanColorsList, colorData)
	end
	local mainLayoutChildren = {
		Title = createElement(PaddedContainer, {
			backgroundColor = Color3.new(51/255, 51/255, 51/255),
			backgroundTransparency = 0,
			size = UDim2.new(1, 0, 1/6, 0),
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
	local bodyContainerProps = {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 13/18, 0),
		position = UDim2.new(0, 0, 1/6, 0),
		paddingLeft = 0,
		paddingRight = 0,
		paddingTop = 0.5,
		paddingBottom = 0.5
	}
	local bodyChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 8)
		})
	}
	local leftPanelProps = {
		BorderSizePixel = 0,
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.new(51/255, 51/255, 51/255),
		Size = UDim2.new(0.4625, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0)
	}
	local leftPanelChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 8)
		})
	}
	local viewCrewContainerChildren = {
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
	local viewCrewBodyProps = {
		backgroundColor = Color3.new(255/255, 0/255, 0/255),
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.75, 0),
		position = UDim2.new(0, 0, 0.25, 0),
		paddingTop = 0.5,
		paddingLeft = 0,
		paddingRight = 0,
		paddingBottom = 0
	}
	local viewCrewBodyChildren = {
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
				[Roact.Ref] = self.playerTextBoxRef,
				[Roact.Event.FocusLost] = self.playerTextBoxFocusLost,
				[Roact.Change.Text] = self.playerTextBoxTextChanged
			})
		})
	}
	local avatarContainerProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.65, 0),
		Position = UDim2.new(0, 0, 0.15, 0)
	}
	local avatarDisplayChildren = {}
	local avatarImageProps = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		BackgroundTransparency = 1
	}
	avatarImageProps.Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=" .. tostring(self.state.avatarUserId or 1)
	avatarImageProps.Size = UDim2.fromScale(0.9, 0.9)
	avatarImageProps.Position = UDim2.new(0.5, 0, 0.5, 0)
	avatarImageProps.AnchorPoint = Vector2.new(0.5, 0.5)
	avatarDisplayChildren.Avatar = createElement("ImageLabel", avatarImageProps, {
		UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1,
			AspectType = Enum.AspectType.FitWithinMaxSize,
			DominantAxis = Enum.DominantAxis.Height
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	})
	viewCrewBodyChildren.Center = createElement("Frame", avatarContainerProps, avatarDisplayChildren)
	viewCrewBodyChildren.RequestButton = createElement(TextButton, {
		size = UDim2.new(1, 0, 0.2, 0),
		position = UDim2.new(0.5, 0, 1, 0),
		anchorPoint = Vector2.new(0.5, 1),
		text = "VIEW",
		backgroundColor = Color3.fromRGB(88, 172, 246),
		onClick = self.onClickView,
		disabled = self.props.networkMutexLocked
	})
	viewCrewContainerChildren.ContainerBody = createElement(PaddedContainer, viewCrewBodyProps, viewCrewBodyChildren)
	leftPanelChildren.Container = createElement(PaddedContainer, {
		backgroundTransparency = 1
	}, viewCrewContainerChildren)
	bodyChildren.Left = createElement("Frame", leftPanelProps, leftPanelChildren)
	bodyChildren.LineTop = createElement("Frame", {
		BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 1, 0.4375, 0),
		Position = UDim2.new(0.5, 0, 0, 0)
	})
	bodyChildren.LineBottom = createElement("Frame", {
		BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 1, 0.4375, 0),
		Position = UDim2.new(0.5, 0, 0.5625, 0)
	})
	bodyChildren.OrText = createElement("TextLabel", {
		Font = Enum.Font.Bangers,
		TextScaled = true,
		BackgroundTransparency = 1,
		Text = "OR",
		TextColor3 = Color3.new(0.3, 0.3, 0.3),
		Size = UDim2.fromScale(0.1125, 0.1125),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5)
	})
	bodyChildren.Right = createElement("Frame", {
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
								[Roact.Ref] = self.crewNameRef,
								[Roact.Event.FocusLost] = self.crewNameTextBoxFocusLost
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
								items = clanColorsList,
								itemMetadata = {
									selectedColorName = self.state.selectedColorName,
									setSelectedColorName = self.setSelectedColorName
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
					onClick = self.onClickCreate,
					disabled = self.props.networkMutexLocked
				})
			})
		})
	})
	mainLayoutChildren.Body = createElement(PaddedContainer, bodyContainerProps, bodyChildren)
	mainLayoutChildren.Bottom = createElement(PaddedContainer, {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		size = UDim2.new(1, 0, 1/9, 0),
		position = UDim2.new(0, 0, 8/9, 0),
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
					onClick = self.props.onClickClose
				})
			})
		})
	})
	return createElement(PaddedContainer, {
		backgroundTransparency = 1,
		backgroundColor = Color3.new(255/255, 255/255, 255/255),
		aspectRatio = self.props.aspectRatio,
		verticalPaddingRatio = self.props.verticalPaddingRatio
	}, Dictionary.merge(self.props[Roact.Children], mainLayoutChildren))
end
return JoinOrCreateComponent
