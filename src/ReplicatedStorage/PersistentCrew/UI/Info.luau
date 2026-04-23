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
local v1 = Roact.PureComponent:extend("Info")
function v1.init(p1) --[[ Line: 18 | Upvalues: Roact (copy), Players (copy), Notification (copy) ]]
	p1:setState({
		searchText = "",
		isRenamingClan = false
	})
	function p1.onClickLeave() --[[ Line: 23 | Upvalues: p1 (copy) ]]
		p1.props.attemptLeave()
	end
	function p1.playerSearchTextBoxTextChanged(p12) --[[ Line: 27 | Upvalues: p1 (copy) ]]
		p1:setState({
			searchText = p12.Text
		})
	end
	function p1.crewSearchTextBoxFocusLost(p12, p2) --[[ Line: 33 | Upvalues: p1 (copy) ]]
		if p2 then
			p1.onClickViewClan()
		end
	end
	p1.crewSearchTextBoxRef = Roact.createRef()
	function p1.onClickViewClan() --[[ Line: 40 | Upvalues: p1 (copy), Players (ref) ]]
		local v1 = p1.crewSearchTextBoxRef:getValue()
		local Text = v1.Text
		if Text == "" then
			return
		end
		v1.Text = ""
		local v2 = Players:GetUserIdFromNameAsync(Text)
		if v2 then
			p1.props.attemptViewUserIdClan(v2)
		end
	end
	p1.crewRenameTextBoxRef = Roact.createRef()
	function p1.renameCrewTextFocusLost() --[[ Line: 55 | Upvalues: p1 (copy) ]]
		local v1 = p1.crewRenameTextBoxRef:getValue()
		if v1 then
			local Text = v1.Text
			if Text ~= "" then
				v1.Text = ""
				p1:setState({
					isEditingClanName = false
				})
				p1.props.onClickRenameCrew(Text)
			end
		end
	end
	function p1.onClickBattle(p12) --[[ Line: 71 | Upvalues: p1 (copy), Notification (ref) ]]
		assert(typeof(p12) == "number", "count must be a number")
		return function() --[[ Line: 73 | Upvalues: p1 (ref), Notification (ref), p12 (copy) ]]
			if p1.props.isReadiedUp then
				Notification.new({
					Text = "Cannot start unranked battle while in ranked matchamking!"
				})
			end
			p1.props.attemptBattleClanId(p1.props.clanId, p12)
		end
	end
	p1:_buildMembers()
	function p1.uncurryPropsIndex(p12, p2) --[[ Line: 86 | Upvalues: p1 (copy) ]]
		return function(p13) --[[ Line: 87 | Upvalues: p12 (copy), p1 (ref), p2 (copy) ]]
			return p12(p1.lastMembers[p2])
		end
	end
end
v1.defaultProps = {
	flagColor = Color3.new(255/255, 0/255, 0/255)
}
function v1._buildMembers(p1) --[[ Line: 95 ]]
	local t = {}
	local searchText = p1.state.searchText
	local v1 = if p1.props.showRequests then p1.props.joinRequests else p1.props.members
	if v1 then
		for v3, v4 in v1 do
			local v2
			v2 = not (#searchText > 0) or string.find(string.lower(v4.displayName), string.lower(searchText))
			if v2 then
				if p1.props.membersOnlineMap then
					v4.isOnline = p1.props.membersOnlineMap[tostring(v4.userId)]
				end
				table.insert(t, v4)
			end
		end
	end
	if not p1.props.showRequests then
		table.sort(t, function(p1, p2) --[[ Line: 121 ]]
			if p1.isOnline == p2.isOnline then
				if p1.isAdmin == p2.isAdmin then
					local v3 = p1.battlesWon / (p1.battlesPlayed - p1.battlesWon)
					local v4 = p2.battlesPlayed / (p2.battlesPlayed - p2.battlesWon)
					if v3 == v4 then
						return p1.displayName < p2.displayName
					else
						return v4 < v3
					end
				else
					return p1.isAdmin
				end
			else
				return p1.isOnline
			end
		end)
	end
	p1.lastMembers = t
end
function v1.render(p1) --[[ Line: 140 | Upvalues: createElement (copy), PaddedContainer (copy), TextButton (copy), Players (copy), Roact (copy), Flag (copy), PersistentCrewBattleUtils (copy), PersistentCrewBattleConsts (copy), paddedScrollingGrid (copy), Member (copy) ]]
	local t = {}
	p1:_buildMembers()
	local isAdminOfCurrentClan = p1.props.isAdminOfCurrentClan
	if isAdminOfCurrentClan then
		isAdminOfCurrentClan = p1.props.isPlayersClan
		if isAdminOfCurrentClan then
			isAdminOfCurrentClan = if p1.props.playersClanId == nil then false else not p1.props.playerHasAcceptedInvite
		end
	end
	local isAdminOfCurrentClan_2 = p1.props.isAdminOfCurrentClan
	if isAdminOfCurrentClan_2 then
		isAdminOfCurrentClan_2 = not p1.props.isPlayersClan
		if isAdminOfCurrentClan_2 then
			isAdminOfCurrentClan_2 = if p1.props.playersClanId == nil then false else not p1.props.playerHasAcceptedInvite
		end
	end
	local t2 = { 1, 2, 3, 4, 5 }
	local t3 = {}
	for v4, v5 in t2 do
		local v2, v3
		local t4 = {
			backgroundTransparency = 1,
			size = UDim2.fromScale(1 / #t2, 1),
			position = UDim2.fromScale((v4 - 1) / #t2, 0)
		}
		v2 = if v4 > 1 then 0.5 else 0
		t4.paddingLeft = v2
		v3 = if v4 < #t2 then 0.5 else 0
		t4.paddingRight = v3
		t4.paddingTop = 0
		t4.paddingBottom = 0
		t3[v4] = createElement(PaddedContainer, t4, {
			Button = createElement(TextButton, {
				size = UDim2.new(1, 0, 1, 0),
				text = ("%dv%d"):format(v5, v5),
				backgroundColor = Color3.fromRGB(88, 172, 246),
				onClick = p1.onClickBattle(v5),
				disabled = p1.props.networkMutexLocked
			})
		})
	end
	local v8 = 0.3055555555555556 * p1.props.aspectRatio / 1.5
	local LocalPlayer = Players.LocalPlayer
	if LocalPlayer then
		LocalPlayer = if Players.LocalPlayer.UserId == p1.props.clanOwnerUserId then not p1.state.isEditingClanName else false
	end
	local LocalPlayer_2 = Players.LocalPlayer
	if LocalPlayer_2 then
		LocalPlayer_2 = if Players.LocalPlayer.UserId == p1.props.clanOwnerUserId then p1.state.isEditingClanName else false
	end
	local v9 = LocalPlayer or LocalPlayer_2
	local t5 = {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		size = UDim2.new(1, 0, 0.09090909090909091, 0),
		paddingLeft = 0,
		paddingRight = 0,
		paddingTop = 0,
		paddingBottom = 0.5
	}
	local t6 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local t7 = {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 1, 0)
	}
	local t8 = {}
	local t9 = {
		backgroundTransparency = 1,
		size = UDim2.new(0.1, 0, 1, 0),
		paddingRight = 0.5,
		paddingTop = 0,
		paddingBottom = 0,
		paddingLeft = 0
	}
	local t10 = {}
	t10.RenameButton = LocalPlayer and createElement(TextButton, {
		size = UDim2.new(1, 0, 1, 0),
		text = "RENAME",
		backgroundColor = Color3.fromRGB(88, 172, 246),
		onClick = function() --[[ Name: onClick | Line: 230 | Upvalues: p1 (copy) ]]
			p1:setState({
				isEditingClanName = true
			})
		end,
		disabled = p1.props.networkMutexLocked
	})
	t10.CancelButton = LocalPlayer_2 and createElement(TextButton, {
		size = UDim2.new(1, 0, 1, 0),
		text = "CANCEL",
		backgroundColor = Color3.fromRGB(88, 172, 246),
		onClick = function() --[[ Name: onClick | Line: 239 | Upvalues: p1 (copy) ]]
			p1:setState({
				isEditingClanName = false
			})
		end,
		disabled = p1.props.networkMutexLocked
	})
	t8.ButtonContainer = createElement(PaddedContainer, t9, t10)
	t8.RenameNameContainer = LocalPlayer_2 and createElement(PaddedContainer, {
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
			[Roact.Ref] = p1.crewRenameTextBoxRef,
			[Roact.Event.FocusLost] = p1.renameCrewTextFocusLost
		})
	})
	local v19 = not LocalPlayer_2
	if v19 then
		local t11 = {
			backgroundTransparency = 1
		}
		t11.size = if v9 then UDim2.fromScale(0.9, 1) else UDim2.fromScale(1, 1)
		t11.position = if v9 then UDim2.fromScale(0.1, 0) else UDim2.fromScale(0, 0)
		t11.paddingRight = 0
		t11.paddingTop = 0
		t11.paddingBottom = 0
		t11.paddingLeft = if v9 then 0.5 else 0
		v19 = createElement(PaddedContainer, t11, {
			ClanName = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Font = Enum.Font.Bangers,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = p1.props.clanName,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		})
	end
	t8.NameContainer = v19
	t6.TitleContainer = createElement(PaddedContainer, t7, t8)
	t6.PlayerRatingContainer = createElement(PaddedContainer, {
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
				Text = "Personal Rating: " .. (p1.props.playerDisplayRating or "N/A"),
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
	t.Header = createElement(PaddedContainer, t5, t6)
	t.Flag = createElement(PaddedContainer, {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		position = UDim2.new(0, 0, 0.09090909090909091, 0),
		size = UDim2.new(0.25, 0, 0.8181818181818181 * v8, 0),
		paddingLeft = 0,
		paddingRight = 0.5,
		paddingTop = 0.5,
		paddingBottom = 0.5
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Flag = createElement(Flag, {
			flagColor = p1.props.flagColor,
			userId = p1.props.clanOwnerUserId
		})
	})
	local v25 = PersistentCrewBattleUtils.calculateWLRatio(p1.props.battlesWon, p1.props.battlesPlayed)
	local count = 0
	if p1.props.membersOnlineMap then
		for v26, v27 in p1.props.membersOnlineMap do
			count = count + 1
		end
	end
	local v28 = if string.find(p1.props.clanDisplayRating, "?") == nil then false else p1.props.isPlayersClan
	local v29 = if v28 then UDim2.new(1, 0, 0.1, 0) else UDim2.new(1, 0, 0.15, 0)
	local v30 = if v28 then 0.02 else 0
	local v31 = if p1.props.leaderboardRank then ("RANK: %d, RATING: %s"):format(p1.props.leaderboardRank, p1.props.clanDisplayRating) else ("RATING: %s"):format(p1.props.clanDisplayRating)
	local t11 = {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		position = UDim2.new(0, 0, 0.8181818181818181 * v8 + 0.09090909090909091, 0),
		size = UDim2.new(0.25, 0, 0.8181818181818181 * (1 - v8), 0),
		paddingLeft = 0,
		paddingRight = 0.5,
		paddingTop = 0.5,
		paddingBottom = 0.5
	}
	local t12 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Rating = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			size = v29,
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
				Text = v31,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		})
	}
	t12.ProvisionalRatingExplanation = v28 and createElement(PaddedContainer, {
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
	local t13 = {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.125, 0),
		position = UDim2.new(0, 0, v30 + 0.15, 0),
		paddingTop = 0,
		paddingBottom = 0
	}
	local t14 = {}
	local t15 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Font = Enum.Font.FredokaOne,
		TextXAlignment = Enum.TextXAlignment.Center
	}
	t15.Text = if count then ("%d online"):format(count) else "... online"
	t15.LineHeight = 1
	t15.TextScaled = true
	t15.TextColor3 = Color3.new(0.7, 0.7, 0.7)
	t14.Text = createElement("TextLabel", t15)
	t12.Online = createElement(PaddedContainer, t13, t14)
	t12.Won = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.125, 0),
		position = UDim2.new(0, 0, v30 + 0.275, 0),
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
			Text = ("%d battles"):format(p1.props.battlesPlayed or 0),
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(0.7, 0.7, 0.7)
		})
	})
	local t16 = {
		backgroundTransparency = 1,
		size = UDim2.new(1, 0, 0.125, 0),
		position = UDim2.new(0, 0, v30 + 0.4, 0),
		paddingTop = 0,
		paddingBottom = 0
	}
	local t17 = {}
	local t18 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Font = Enum.Font.FredokaOne,
		TextXAlignment = Enum.TextXAlignment.Center
	}
	t18.Text = v25 and "W/L: " .. v25 or "W/L: ..."
	t18.LineHeight = 1
	t18.TextScaled = true
	t18.TextColor3 = Color3.new(0.7, 0.7, 0.7)
	t17.Text = createElement("TextLabel", t18)
	t12.WLRatio = createElement(PaddedContainer, t16, t17)
	t12.RankedBattleTitleContainer = isAdminOfCurrentClan and createElement(PaddedContainer, {
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
	local v48
	if isAdminOfCurrentClan then
		local t19 = {
			backgroundTransparency = 1,
			size = UDim2.new(1, 0, 0.15, 0),
			position = UDim2.fromScale(0, 0.7),
			paddingTop = 0
		}
		local t20 = {}
		local t21 = {
			size = UDim2.new(1, 0, 1, 0),
			position = UDim2.new(1, 0, 0, 0),
			anchorPoint = Vector2.new(1, 0)
		}
		t21.text = if p1.props.isReadiedUp then "LEAVE MATCHMAKING" else "ENTER MATCHMAKING"
		t21.backgroundColor = Color3.fromRGB(88, 172, 246)
		t21.onClick = p1.props.isReadiedUp and p1.props.onClickUnreadyUp or p1.props.onClickReadyUp
		t21.disabled = p1.props.networkMutexLocked
		t20.Button = createElement(TextButton, t21)
		v48 = createElement(PaddedContainer, t19, t20)
	else
		v48 = isAdminOfCurrentClan
	end
	t12.ReadyUpContainer = v48
	t12.Leave = p1.props.isPlayersClan and createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1, 0.15),
		position = UDim2.fromScale(0, 0.85),
		paddingTop = 0
	}, {
		Button = createElement(TextButton, {
			size = UDim2.new(1, 0, 1, 0),
			text = "LEAVE CREW",
			backgroundColor = Color3.fromRGB(233, 76, 64),
			onClick = p1.onClickLeave,
			disabled = p1.props.networkMutexLocked
		})
	})
	t12.JoinContainer = if p1.props.playersClanId == nil then createElement(PaddedContainer, {
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
		onClick = function() --[[ Name: onClick | Line: 542 | Upvalues: p1 (copy) ]]
			p1.props.attemptRequestJoinUserId(p1.props.clanOwnerUserId)
		end,
		disabled = p1.props.networkMutexLocked
	})
}) else false
	t12.UnrankedBattleTitleContainer = isAdminOfCurrentClan_2 and createElement(PaddedContainer, {
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
	t12.Battle = isAdminOfCurrentClan_2 and createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1, 0.15),
		position = UDim2.fromScale(0, 0.85),
		paddingTop = 0
	}, t3)
	t.Body1Bottom = createElement(PaddedContainer, t11, t12)
	local isAdminOfViewingClan = p1.props.isAdminOfViewingClan
	local t19 = {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		position = UDim2.new(0.25, 0, 0.09090909090909091, 0),
		size = UDim2.new(0.375, 0, 0.1, 0),
		paddingLeft = 0.5,
		paddingRight = 0.5,
		paddingTop = 0.5,
		paddingBottom = 0.5
	}
	local t20 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local t21 = {
		backgroundTransparency = 1
	}
	t21.size = if isAdminOfViewingClan then UDim2.fromScale(0.5, 1) else UDim2.fromScale(1, 1)
	t21.paddingRight = if isAdminOfViewingClan then 0.5 else 1
	t20.Left = createElement(PaddedContainer, t21, {
		Button = createElement(TextButton, {
			size = UDim2.new(1, 0, 1, 0),
			position = UDim2.new(1, 0, 0, 0),
			anchorPoint = Vector2.new(1, 0),
			text = ("MEMBERS (%d)"):format(#p1.props.members),
			backgroundColor = Color3.fromRGB(88, 172, 246),
			disabled = not p1.props.showRequests,
			onClick = p1.props.onClickToggleRequests
		})
	})
	t20.Right = isAdminOfViewingClan and createElement(PaddedContainer, {
		backgroundTransparency = 1,
		position = UDim2.new(0.5, 0, 0, 0),
		size = UDim2.new(0.5, 0, 1, 0),
		paddingLeft = 0.5
	}, {
		Button = createElement(TextButton, {
			size = UDim2.new(1, 0, 1, 0),
			position = UDim2.new(1, 0, 0, 0),
			anchorPoint = Vector2.new(1, 0),
			text = ("REQUESTS (%d)"):format(#p1.props.joinRequests),
			backgroundColor = Color3.fromRGB(88, 172, 246),
			disabled = p1.props.showRequests,
			onClick = p1.props.onClickToggleRequests
		})
	})
	t.Body2TopLeft = createElement(PaddedContainer, t19, t20)
	t.Search = createElement(PaddedContainer, {
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
					[Roact.Change.Text] = p1.playerSearchTextBoxTextChanged
				})
			})
		})
	})
	t.Body2Bottom = createElement(PaddedContainer, {
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
			items = p1.lastMembers,
			itemDefaults = {
				networkMutexLocked = p1.props.networkMutexLocked,
				showRequests = p1.props.showRequests,
				uncurryPropsIndex = p1.uncurryPropsIndex,
				onClickAdmin = p1.props.onClickAdmin,
				onClickUnAdmin = p1.props.onClickUnAdmin,
				onClickKick = p1.props.onClickKick,
				onClickJoinRequestAccept = p1.props.onClickJoinRequestAccept,
				onClickJoinRequestDeny = p1.props.onClickJoinRequestDeny
			}
		})
	})
	local t22 = {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		position = UDim2.new(0, 0, 0.9090909090909091, 0),
		size = UDim2.new(1, 0, 0.09090909090909091, 0),
		paddingLeft = 0,
		paddingRight = 0,
		paddingTop = 0.5,
		paddingBottom = 0
	}
	local t23 = {
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
							[Roact.Ref] = p1.crewSearchTextBoxRef,
							[Roact.Event.FocusLost] = p1.crewSearchTextBoxFocusLost,
							[Roact.Change.Text] = p1.crewSearchTextBoxTextChanged
						})
					})
				})
			})
		})
	}
	local t24 = {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1)
	}
	local t25 = {
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
					onClick = p1.props.onClickClose
				})
			})
		})
	}
	t25.BackContainer = not p1.props.isPlayersClan and createElement("Frame", {
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
				onClick = p1.props.onClickViewMe,
				disabled = p1.props.networkMutexLocked
			})
		})
	})
	t23.Right = createElement("Frame", t24, t25)
	t.Footer = createElement(PaddedContainer, t22, t23)
	return createElement(PaddedContainer, {
		backgroundTransparency = 1,
		backgroundColor = Color3.new(255/255, 255/255, 255/255),
		aspectRatio = p1.props.aspectRatio,
		verticalPaddingRatio = p1.props.verticalPaddingRatio
	}, t)
end
return v1