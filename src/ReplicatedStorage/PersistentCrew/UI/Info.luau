local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local paddedScrollingGrid = require(ReplicatedStorage.Safes.UI.paddedScrollingGrid)
local Notification = require(ReplicatedStorage.Game.Notification)
require(ReplicatedStorage.Game.PlayerUtils)
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local PersistentCrewBattleUtils = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleUtils)
local TextButton = require(script.Parent.TextButton)
local Member = require(script.Parent.Member)
local Flag = require(script.Parent.Flag)
local InfoComponent = Roact.PureComponent:extend("Info")
function InfoComponent.init(self)
	self:setState({
		searchText = "",
		isRenamingClan = false
	})
	function self.onClickLeave()
		self.props.attemptLeave()
	end
	function self.playerSearchTextBoxTextChanged(textBox)
		self:setState({
			searchText = textBox.Text
		})
	end
	function self.crewSearchTextBoxFocusLost(textBox, enterPressed)
		if enterPressed then
			self.onClickViewClan()
		end
	end
	self.crewSearchTextBoxRef = Roact.createRef()
	function self.onClickViewClan()
		local textBox = self.crewSearchTextBoxRef:getValue()
		local text = textBox.Text
		if text == "" then
			return
		end
		textBox.Text = ""
		local userId = Players:GetUserIdFromNameAsync(text)
		if userId then
			self.props.attemptViewUserIdClan(userId)
		end
	end
	self.crewRenameTextBoxRef = Roact.createRef()
	function self.renameCrewTextFocusLost()
		local textBox = self.crewRenameTextBoxRef:getValue()
		if textBox then
			local text = textBox.Text
			if text ~= "" then
				textBox.Text = ""
				self:setState({
					isEditingClanName = false
				})
				self.props.onClickRenameCrew(text)
			end
		end
	end
	function self.onClickBattle(count)
		assert(typeof(count) == "number", "count must be a number")
		return function()
			if self.props.isReadiedUp then
				Notification.new({
					Text = "Cannot start unranked battle while in ranked matchamking!"
				})
			end
			self.props.attemptBattleClanId(self.props.clanId, count)
		end
	end
	self:_buildMembers()
	function self.uncurryPropsIndex(getter, memberIndex)
		return function(item)
			return getter(self.lastMembers[memberIndex])
		end
	end
end
InfoComponent.defaultProps = {
	flagColor = Color3.new(255/255, 0/255, 0/255)
}
function InfoComponent._buildMembers(self)
	local filteredMembers = {}
	local searchText = self.state.searchText
	local memberList = if self.props.showRequests then self.props.joinRequests else self.props.members
	if memberList then
		for _, memberData in memberList do
			local matchesSearch
			matchesSearch = not (#searchText > 0) or string.find(string.lower(memberData.displayName), string.lower(searchText))
			if matchesSearch then
				if self.props.membersOnlineMap then
					memberData.isOnline = self.props.membersOnlineMap[tostring(memberData.userId)]
				end
				table.insert(filteredMembers, memberData)
			end
		end
	end
	if not self.props.showRequests then
		table.sort(filteredMembers, function(memberA, memberB)
			if memberA.isOnline == memberB.isOnline then
				if memberA.isAdmin == memberB.isAdmin then
					local ratioA = memberA.battlesWon / (memberA.battlesPlayed - memberA.battlesWon)
					local ratioB = memberB.battlesPlayed / (memberB.battlesPlayed - memberB.battlesWon)
					if ratioA == ratioB then
						return memberA.displayName < memberB.displayName
					else
						return ratioB < ratioA
					end
				else
					return memberA.isAdmin
				end
			else
				return memberA.isOnline
			end
		end)
	end
	self.lastMembers = filteredMembers
end
function InfoComponent.render(self)
	local rootChildren = {}
	self:_buildMembers()
	local canEditCurrentClan = self.props.isAdminOfCurrentClan
	if canEditCurrentClan then
		canEditCurrentClan = self.props.isPlayersClan
		if canEditCurrentClan then
			canEditCurrentClan = if self.props.playersClanId == nil then false else not self.props.playerHasAcceptedInvite
		end
	end
	local canStartRankedBattle = self.props.isAdminOfCurrentClan
	if canStartRankedBattle then
		canStartRankedBattle = not self.props.isPlayersClan
		if canStartRankedBattle then
			canStartRankedBattle = if self.props.playersClanId == nil then false else not self.props.playerHasAcceptedInvite
		end
	end
	local battleSizes = { 1, 2, 3, 4, 5 }
	local battleButtons = {}
	for slotIndex, teamSize in battleSizes do
		local paddingLeft, paddingRight
		local containerProps = {
			backgroundTransparency = 1,
			size = UDim2.fromScale(1 / #battleSizes, 1),
			position = UDim2.fromScale((slotIndex - 1) / #battleSizes, 0)
		}
		paddingLeft = if slotIndex > 1 then 0.5 else 0
		containerProps.paddingLeft = paddingLeft
		paddingRight = if slotIndex < #battleSizes then 0.5 else 0
		containerProps.paddingRight = paddingRight
		containerProps.paddingTop = 0
		containerProps.paddingBottom = 0
		battleButtons[slotIndex] = createElement(PaddedContainer, containerProps, {
			Button = createElement(TextButton, {
				size = UDim2.new(1, 0, 1, 0),
				text = ("%dv%d"):format(teamSize, teamSize),
				backgroundColor = Color3.fromRGB(88, 172, 246),
				onClick = self.onClickBattle(teamSize),
				disabled = self.props.networkMutexLocked
			})
		})
	end
	local flagHeightScale = 0.3055555555555556 * self.props.aspectRatio / 1.5
	local isOwnerNotEditing = Players.LocalPlayer
	if isOwnerNotEditing then
		isOwnerNotEditing = if Players.LocalPlayer.UserId == self.props.clanOwnerUserId then not self.state.isEditingClanName else false
	end
	local isOwnerEditing = Players.LocalPlayer
	if isOwnerEditing then
		isOwnerEditing = if Players.LocalPlayer.UserId == self.props.clanOwnerUserId then self.state.isEditingClanName else false
	end
	local isOwner = isOwnerNotEditing or isOwnerEditing
	local headerBarProps = {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		size = UDim2.new(1, 0, 0.09090909090909091, 0),
		paddingLeft = 0,
		paddingRight = 0,
		paddingTop = 0,
		paddingBottom = 0.5
	}
	local headerBarChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local titleContainerProps = {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 1, 0)
	}
	local titleContainerChildren = {}
	local renameBtnContainerProps = {
		backgroundTransparency = 1,
		size = UDim2.new(0.1, 0, 1, 0),
		paddingRight = 0.5,
		paddingTop = 0,
		paddingBottom = 0,
		paddingLeft = 0
	}
	local renameBtnContainerChildren = {}
	renameBtnContainerChildren.RenameButton = isOwnerNotEditing and createElement(TextButton, {
		size = UDim2.new(1, 0, 1, 0),
		text = "RENAME",
		backgroundColor = Color3.fromRGB(88, 172, 246),
		onClick = function()
			self:setState({
				isEditingClanName = true
			})
		end,
		disabled = self.props.networkMutexLocked
	})
	renameBtnContainerChildren.CancelButton = isOwnerEditing and createElement(TextButton, {
		size = UDim2.new(1, 0, 1, 0),
		text = "CANCEL",
		backgroundColor = Color3.fromRGB(88, 172, 246),
		onClick = function()
			self:setState({
				isEditingClanName = false
			})
		end,
		disabled = self.props.networkMutexLocked
	})
	titleContainerChildren.ButtonContainer = createElement(PaddedContainer, renameBtnContainerProps, renameBtnContainerChildren)
	titleContainerChildren.RenameNameContainer = isOwnerEditing and createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.new(0.9, 0, 1, 0),
		position = UDim2.new(0.1, 0, 0, 0),
		paddingRight = 0,
		paddingTop = 0,
		paddingBottom = 0,
		paddingLeft = 0.5
	}, {
		RenameTextInput = createElement("TextBox", {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 255/255),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			PlaceholderText = "RENAME CREW...",
			TextColor3 = Color3.new(255/255, 255/255, 255/255),
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = "",
			Font = Enum.Font.Bangers,
			TextScaled = true,
			[Roact.Ref] = self.crewRenameTextBoxRef,
			[Roact.Event.FocusLost] = self.renameCrewTextFocusLost
		})
	})
	local clanNameDisplay = not isOwnerEditing
	if clanNameDisplay then
		local clanNameContainerProps = {
			backgroundTransparency = 1
		}
		clanNameContainerProps.size = if isOwner then UDim2.fromScale(0.9, 1) else UDim2.fromScale(1, 1)
		clanNameContainerProps.position = if isOwner then UDim2.fromScale(0.1, 0) else UDim2.fromScale(0, 0)
		clanNameContainerProps.paddingRight = 0
		clanNameContainerProps.paddingTop = 0
		clanNameContainerProps.paddingBottom = 0
		clanNameContainerProps.paddingLeft = if isOwner then 0.5 else 0
		clanNameDisplay = createElement(PaddedContainer, clanNameContainerProps, {
			ClanName = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Font = Enum.Font.Bangers,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = self.props.clanName,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		})
	end
	titleContainerChildren.NameContainer = clanNameDisplay
	headerBarChildren.TitleContainer = createElement(PaddedContainer, titleContainerProps, titleContainerChildren)
	headerBarChildren.PlayerRatingContainer = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.fromScale(0.3, 0.8),
		position = UDim2.fromScale(0.7, 0.1),
		paddingRight = 0,
		paddingTop = 0,
		paddingBottom = 0,
		paddingLeft = 0
	}, {
		PaddedClanName = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			size = UDim2.fromScale(1, 1),
			paddingRight = 1,
			paddingTop = 0,
			paddingBottom = 0,
			paddingLeft = 1
		}, {
			ClanName = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Font = Enum.Font.Bangers,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = "Personal Rating: " .. (self.props.playerDisplayRating or "N/A"),
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		}),
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(255/255, 255/255, 255/255),
			Thickness = 1
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	})
	rootChildren.Header = createElement(PaddedContainer, headerBarProps, headerBarChildren)
	rootChildren.Flag = createElement(PaddedContainer, {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		position = UDim2.new(0, 0, 0.09090909090909091, 0),
		size = UDim2.new(0.25, 0, 0.8181818181818181 * flagHeightScale, 0),
		paddingLeft = 0,
		paddingRight = 0.5,
		paddingTop = 0.5,
		paddingBottom = 0.5
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Flag = createElement(Flag, {
			flagColor = self.props.flagColor,
			userId = self.props.clanOwnerUserId
		})
	})
	local wlRatio = PersistentCrewBattleUtils.calculateWLRatio(self.props.battlesWon, self.props.battlesPlayed)
	local onlineCount = 0
	if self.props.membersOnlineMap then
		for _, _ in self.props.membersOnlineMap do
			onlineCount = onlineCount + 1
		end
	end
	local isProvisionalRating = if string.find(self.props.clanDisplayRating, "?") == nil then false else self.props.isPlayersClan
	local ratingContainerSize = if isProvisionalRating then UDim2.new(1, 0, 0.1, 0) else UDim2.new(1, 0, 0.15, 0)
	local provisionalVerticalOffset = if isProvisionalRating then 0.02 else 0
	local ratingText = if self.props.leaderboardRank then ("RANK: %d, RATING: %s"):format(self.props.leaderboardRank, self.props.clanDisplayRating) else ("RATING: %s"):format(self.props.clanDisplayRating)
	local statsContainerProps = {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		position = UDim2.new(0, 0, 0.8181818181818181 * flagHeightScale + 0.09090909090909091, 0),
		size = UDim2.new(0.25, 0, 0.8181818181818181 * (1 - flagHeightScale), 0),
		paddingLeft = 0,
		paddingRight = 0.5,
		paddingTop = 0.5,
		paddingBottom = 0.5
	}
	local statsChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Rating = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			size = ratingContainerSize,
			paddingTop = 0,
			paddingBottom = 0
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Font = Enum.Font.FredokaOne,
				TextXAlignment = Enum.TextXAlignment.Center,
				Text = ratingText,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		})
	}
	statsChildren.ProvisionalRatingExplanation = isProvisionalRating and createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.09, 0),
		position = UDim2.new(0, 0, 0.08, 0),
		paddingTop = 0,
		paddingBottom = 0
	}, {
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Font = Enum.Font.FredokaOne,
			TextXAlignment = Enum.TextXAlignment.Center,
			Text = ("Leaderboard unlocks at %d battles"):format(PersistentCrewBattleConsts.NUM_PROVISIONAL_RATING_BATTLES),
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255)
		})
	})
	local onlineContainerProps = {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.125, 0),
		position = UDim2.new(0, 0, provisionalVerticalOffset + 0.15, 0),
		paddingTop = 0,
		paddingBottom = 0
	}
	local onlineContainerChildren = {}
	local onlineLabelProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Font = Enum.Font.FredokaOne,
		TextXAlignment = Enum.TextXAlignment.Center
	}
	onlineLabelProps.Text = if onlineCount then ("%d online"):format(onlineCount) else "... online"
	onlineLabelProps.LineHeight = 1
	onlineLabelProps.TextScaled = true
	onlineLabelProps.TextColor3 = Color3.new(0.7, 0.7, 0.7)
	onlineContainerChildren.Text = createElement("TextLabel", onlineLabelProps)
	statsChildren.Online = createElement(PaddedContainer, onlineContainerProps, onlineContainerChildren)
	statsChildren.Won = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.125, 0),
		position = UDim2.new(0, 0, provisionalVerticalOffset + 0.275, 0),
		paddingTop = 0,
		paddingBottom = 0
	}, {
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Font = Enum.Font.FredokaOne,
			TextXAlignment = Enum.TextXAlignment.Center,
			Text = ("%d battles"):format(self.props.battlesPlayed or 0),
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(0.7, 0.7, 0.7)
		})
	})
	local wlContainerProps = {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.125, 0),
		position = UDim2.new(0, 0, provisionalVerticalOffset + 0.4, 0),
		paddingTop = 0,
		paddingBottom = 0
	}
	local wlContainerChildren = {}
	local wlLabelProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Font = Enum.Font.FredokaOne,
		TextXAlignment = Enum.TextXAlignment.Center
	}
	wlLabelProps.Text = wlRatio and "W/L: " .. wlRatio or "W/L: ..."
	wlLabelProps.LineHeight = 1
	wlLabelProps.TextScaled = true
	wlLabelProps.TextColor3 = Color3.new(0.7, 0.7, 0.7)
	wlContainerChildren.Text = createElement("TextLabel", wlLabelProps)
	statsChildren.WLRatio = createElement(PaddedContainer, wlContainerProps, wlContainerChildren)
	statsChildren.RankedBattleTitleContainer = canEditCurrentClan and createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.1, 0),
		position = UDim2.new(0, 0, 0.6, 0),
		paddingTop = 0
	}, {
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Font = Enum.Font.FredokaOne,
			Text = ("BATTLE (RANKED, %dv%d)"):format(PersistentCrewBattleConsts.RANKED_BATTLE_TEAM_SIZE, PersistentCrewBattleConsts.RANKED_BATTLE_TEAM_SIZE),
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255)
		})
	})
	local readyUpContainer
	if canEditCurrentClan then
		local readyUpContainerProps = {
			backgroundTransparency = 1,
			size = UDim2.new(1, 0, 0.15, 0),
			position = UDim2.fromScale(0, 0.7),
			paddingTop = 0
		}
		local readyUpContainerChildren = {}
		local readyUpButtonProps = {
			size = UDim2.new(1, 0, 1, 0),
			position = UDim2.new(1, 0, 0, 0),
			anchorPoint = Vector2.new(1, 0)
		}
		readyUpButtonProps.text = if self.props.isReadiedUp then "LEAVE MATCHMAKING" else "ENTER MATCHMAKING"
		readyUpButtonProps.backgroundColor = Color3.fromRGB(88, 172, 246)
		readyUpButtonProps.onClick = self.props.isReadiedUp and self.props.onClickUnreadyUp or self.props.onClickReadyUp
		readyUpButtonProps.disabled = self.props.networkMutexLocked
		readyUpContainerChildren.Button = createElement(TextButton, readyUpButtonProps)
		readyUpContainer = createElement(PaddedContainer, readyUpContainerProps, readyUpContainerChildren)
	else
		readyUpContainer = isAdminOfCurrentClan
	end
	statsChildren.ReadyUpContainer = readyUpContainer
	statsChildren.Leave = self.props.isPlayersClan and createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1, 0.15),
		position = UDim2.fromScale(0, 0.85),
		paddingTop = 0
	}, {
		Button = createElement(TextButton, {
			size = UDim2.new(1, 0, 1, 0),
			text = "LEAVE CREW",
			backgroundColor = Color3.fromRGB(233, 76, 64),
			onClick = self.onClickLeave,
			disabled = self.props.networkMutexLocked
		})
	})
	statsChildren.JoinContainer = if self.props.playersClanId == nil then createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.15, 0),
		position = UDim2.fromScale(0, 0.85),
		paddingTop = 0
	}, {
		Button = createElement(TextButton, {
			size = UDim2.new(1, 0, 1, 0),
			position = UDim2.new(1, 0, 0, 0),
			anchorPoint = Vector2.new(1, 0),
			text = "REQUEST JOIN CREW",
			backgroundColor = Color3.fromRGB(88, 172, 246),
			onClick = function()
				self.props.attemptRequestJoinUserId(self.props.clanOwnerUserId)
			end,
			disabled = self.props.networkMutexLocked
		})
	}) else false
	statsChildren.UnrankedBattleTitleContainer = canStartRankedBattle and createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.15, 0),
		position = UDim2.new(0, 0, 0.7, 0),
		paddingTop = 0
	}, {
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Font = Enum.Font.FredokaOne,
			Text = "BATTLE (UNRANKED)",
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255)
		})
	})
	statsChildren.Battle = canStartRankedBattle and createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1, 0.15),
		position = UDim2.fromScale(0, 0.85),
		paddingTop = 0
	}, battleButtons)
	rootChildren.Body1Bottom = createElement(PaddedContainer, statsContainerProps, statsChildren)
	local isAdminOfViewingClan = self.props.isAdminOfViewingClan
	local tabBarContainerProps = {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		position = UDim2.new(0.25, 0, 0.09090909090909091, 0),
		size = UDim2.new(0.375, 0, 0.1, 0),
		paddingLeft = 0.5,
		paddingRight = 0.5,
		paddingTop = 0.5,
		paddingBottom = 0.5
	}
	local tabBarChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local membersTabProps = {
		backgroundTransparency = 1
	}
	membersTabProps.size = if isAdminOfViewingClan then UDim2.fromScale(0.5, 1) else UDim2.fromScale(1, 1)
	membersTabProps.paddingRight = if isAdminOfViewingClan then 0.5 else 1
	tabBarChildren.Left = createElement(PaddedContainer, membersTabProps, {
		Button = createElement(TextButton, {
			size = UDim2.new(1, 0, 1, 0),
			position = UDim2.new(1, 0, 0, 0),
			anchorPoint = Vector2.new(1, 0),
			text = ("MEMBERS (%d)"):format(#self.props.members),
			backgroundColor = Color3.fromRGB(88, 172, 246),
			disabled = not self.props.showRequests,
			onClick = self.props.onClickToggleRequests
		})
	})
	tabBarChildren.Right = isAdminOfViewingClan and createElement(PaddedContainer, {
		backgroundTransparency = 1,
		position = UDim2.new(0.5, 0, 0, 0),
		size = UDim2.new(0.5, 0, 1, 0),
		paddingLeft = 0.5
	}, {
		Button = createElement(TextButton, {
			size = UDim2.new(1, 0, 1, 0),
			position = UDim2.new(1, 0, 0, 0),
			anchorPoint = Vector2.new(1, 0),
			text = ("REQUESTS (%d)"):format(#self.props.joinRequests),
			backgroundColor = Color3.fromRGB(88, 172, 246),
			disabled = self.props.showRequests,
			onClick = self.props.onClickToggleRequests
		})
	})
	rootChildren.Body2TopLeft = createElement(PaddedContainer, tabBarContainerProps, tabBarChildren)
	rootChildren.Search = createElement(PaddedContainer, {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		position = UDim2.new(0.625, 0, 0.09090909090909091, 0),
		size = UDim2.new(0.375, 0, 0.1, 0),
		paddingLeft = 0.5,
		paddingRight = 0,
		paddingTop = 0.5,
		paddingBottom = 0.5
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Container = createElement(PaddedContainer, {
			backgroundTransparency = 1
		}, {
			UsernameContainer = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
				Size = UDim2.new(1, 0, 1, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0)
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Input = createElement("TextBox", {
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.new(255/255, 0/255, 255/255),
					BorderSizePixel = 0,
					Size = UDim2.new(0.8, 0, 1, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					PlaceholderText = "Find a member...",
					TextColor3 = Color3.new(0/255, 0/255, 0/255),
					Text = "",
					Font = Enum.Font.Bangers,
					TextScaled = true,
					[Roact.Change.Text] = self.playerSearchTextBoxTextChanged
				})
			})
		})
	})
	rootChildren.Body2Bottom = createElement(PaddedContainer, {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		position = UDim2.new(0.25, 0, 0.19090909090909092, 0),
		size = UDim2.new(0.75, 0, 0.7181818181818181, 0),
		paddingLeft = 0.5,
		paddingRight = 0,
		paddingTop = 0.5,
		paddingBottom = 0.5
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Scrolling = createElement(paddedScrollingGrid, {
			exposePaddedContainerProps = true,
			rowsPerPage = 7.5,
			colsPerRow = 1,
			component = Member,
			items = self.lastMembers,
			itemDefaults = {
				networkMutexLocked = self.props.networkMutexLocked,
				showRequests = self.props.showRequests,
				uncurryPropsIndex = self.uncurryPropsIndex,
				onClickAdmin = self.props.onClickAdmin,
				onClickUnAdmin = self.props.onClickUnAdmin,
				onClickKick = self.props.onClickKick,
				onClickJoinRequestAccept = self.props.onClickJoinRequestAccept,
				onClickJoinRequestDeny = self.props.onClickJoinRequestDeny
			}
		})
	})
	local footerContainerProps = {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		position = UDim2.new(0, 0, 0.9090909090909091, 0),
		size = UDim2.new(1, 0, 0.09090909090909091, 0),
		paddingLeft = 0,
		paddingRight = 0,
		paddingTop = 0.5,
		paddingBottom = 0
	}
	local footerChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Left = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1)
		}, {
			UIListLayout = createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				SortOrder = Enum.SortOrder.LayoutOrder
			}),
			SearchContainer = createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.3333333333333333, 0, 1, 0),
				LayoutOrder = 10
			}, {
				Search = createElement(PaddedContainer, {}, {
					UsernameContainer = createElement("Frame", {
						BorderSizePixel = 0,
						BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
						Size = UDim2.new(1, 0, 1, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.new(0.5, 0, 0.5, 0)
					}, {
						UICorner = createElement("UICorner", {
							CornerRadius = UDim.new(0, 4)
						}),
						Input = createElement("TextBox", {
							BackgroundTransparency = 1,
							BackgroundColor3 = Color3.new(255/255, 0/255, 255/255),
							BorderSizePixel = 0,
							Size = UDim2.new(0.9, 0, 1, 0),
							AnchorPoint = Vector2.new(0.5, 0.5),
							Position = UDim2.new(0.5, 0, 0.5, 0),
							PlaceholderText = "Search for another player\'s crew",
							TextColor3 = Color3.new(0/255, 0/255, 0/255),
							Text = "",
							Font = Enum.Font.Bangers,
							TextScaled = true,
							[Roact.Ref] = self.crewSearchTextBoxRef,
							[Roact.Event.FocusLost] = self.crewSearchTextBoxFocusLost,
							[Roact.Change.Text] = self.crewSearchTextBoxTextChanged
						})
					})
				})
			})
		})
	}
	local rightFrameProps = {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1)
	}
	local rightFrameChildren = {
		UIListLayout = createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			SortOrder = Enum.SortOrder.LayoutOrder
		}),
		CloseContainer = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.15, 0, 1, 0),
			LayoutOrder = 10
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
	}
	rightFrameChildren.BackContainer = not self.props.isPlayersClan and createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.15, 0, 1, 0),
		LayoutOrder = 1
	}, {
		Container = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			paddingLeft = 0.5,
			paddingRight = 0.5
		}, {
			Button = createElement(TextButton, {
				size = UDim2.new(1, 0, 1, 0),
				position = UDim2.new(1, 0, 0, 0),
				anchorPoint = Vector2.new(1, 0),
				text = "BACK",
				backgroundColor = Color3.fromRGB(88, 172, 246),
				onClick = self.props.onClickViewMe,
				disabled = self.props.networkMutexLocked
			})
		})
	})
	footerChildren.Right = createElement("Frame", rightFrameProps, rightFrameChildren)
	rootChildren.Footer = createElement(PaddedContainer, footerContainerProps, footerChildren)
	return createElement(PaddedContainer, {
		backgroundTransparency = 1,
		backgroundColor = Color3.new(255/255, 255/255, 255/255),
		aspectRatio = self.props.aspectRatio,
		verticalPaddingRatio = self.props.verticalPaddingRatio
	}, rootChildren)
end
return InfoComponent
