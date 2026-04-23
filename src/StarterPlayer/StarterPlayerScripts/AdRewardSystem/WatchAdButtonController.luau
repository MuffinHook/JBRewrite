local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notification = require(ReplicatedStorage.Game.Notification)
local AdRewardsController = require(script.Parent:WaitForChild("AdRewardsController"))
local Telemetry = require(script.Parent.Telemetry)
local t = {}
local AdRewardEvents = ReplicatedStorage:WaitForChild("AdRewardSystem"):WaitForChild("AdRewardEvents")
local GrantReward = AdRewardEvents:WaitForChild("GrantReward")
local GetAdPlacementStatus = AdRewardEvents:WaitForChild("GetAdPlacementStatus")
local playerGui = nil
local playAdCallback = nil
local getAdStateCallback = nil
local getCurrentRegionTagCallback = nil
local claimButtonConfigs = {}
local claimDataByPlacement = {}
local buttonDataByPlacement = {}
local placementStatusCache = {}
local pendingAdContext = nil
local activeTweens = {}
local tweenGeneration = 0
local function registerTween(tween)
	if tween then
		table.insert(activeTweens, tween)
	end
	return tween
end
local function CancelAllIdleTweens()
	tweenGeneration = tweenGeneration + 1
	for i, tween in ipairs(activeTweens) do
		if tween then
			pcall(function()
				tween:Cancel()
			end)
		end
	end
	table.clear(activeTweens)
end
local function getAvailability()
	if getAdStateCallback then
		return getAdStateCallback()
	else
		warn("WatchAdButtonController: GetAdState not set")
		return false, false, false
	end
end
local function tweenGuiPosition(guiObject, targetPosition, duration)
	if guiObject and guiObject.Parent then
		CancelAllIdleTweens()
		local tween = TweenService:Create(guiObject, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Position = targetPosition
		})
		if tween then
			table.insert(activeTweens, tween)
		end
		tween:Play()
		return tween
	else
		return nil
	end
end
local function bouncelooptween(guiObject, repeatCount)
	if guiObject then
		task.spawn(function()
			if guiObject and guiObject.Parent then
				local Position = guiObject.Position
				local capturedGeneration = tweenGeneration
				task.wait(1)
				for i = 1, repeatCount or 20 do
					if guiObject and (guiObject.Parent and (guiObject.Visible and capturedGeneration == tweenGeneration)) then
						task.wait(1)
						if guiObject and (guiObject.Parent and (guiObject.Visible and capturedGeneration == tweenGeneration)) then
							local upPos = Position + UDim2.new(0, 0, -0.05, 0)
							local downPos = Position + UDim2.new(0, 0, 0.02, 0)
							local tweenUp = TweenService:Create(guiObject, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Position = upPos
							})
							if tweenUp then
								table.insert(activeTweens, tweenUp)
							end
							local tweenDown = TweenService:Create(guiObject, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
								Position = downPos
							})
							if tweenDown then
								table.insert(activeTweens, tweenDown)
							end
							local tweenReturn = TweenService:Create(guiObject, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Position = Position
							})
							if tweenReturn then
								table.insert(activeTweens, tweenReturn)
							end
							tweenUp:Play()
							tweenUp.Completed:Wait()
							if guiObject and (guiObject.Parent and (guiObject.Visible and capturedGeneration == tweenGeneration)) then
								tweenDown:Play()
								tweenDown.Completed:Wait()
								if guiObject and (guiObject.Parent and (guiObject.Visible and capturedGeneration == tweenGeneration)) then
									tweenReturn:Play()
									tweenReturn.Completed:Wait()
									local _ = guiObject and (guiObject.Parent and (guiObject.Visible and capturedGeneration == tweenGeneration))
								end
							end
						end
					end
					break
				end
			end
		end)
	end
end
local function hoveranimation(guiObject)
	if guiObject then
		task.spawn(function()
			if guiObject and guiObject.Parent then
				local Position = guiObject.Position
				local hoverOffset = UDim2.new(0, 0, 0, 4)
				local capturedGeneration = tweenGeneration
				local tweenInfoOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				local _ = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
				for i = 1, 20 do
					if guiObject and (guiObject.Parent and (guiObject.Visible and capturedGeneration == tweenGeneration)) then
						local tween = TweenService:Create(guiObject, tweenInfoOut, {
							Position = Position + hoverOffset
						})
						if tween then
							table.insert(activeTweens, tween)
						end
						tween:Play()
						tween.Completed:Wait()
						task.wait(1)
						local _ = guiObject and (guiObject.Parent and (guiObject.Visible and capturedGeneration == tweenGeneration))
					end
					break
				end
			end
		end)
	end
end
GrantReward.OnClientEvent:Connect(function(rewardType, rewardValue)
	if rewardType == "2xCash" and typeof(rewardValue) == "number" then
		Notification.new({
			Text = string.format("You\'ve Earned %s min of 2x CASH!", rewardValue / 60),
			Style = "Gift"
		})
	end
end)
local function refreshPlacementStatus(placementKey, forceRefresh)
	local placementEntry = claimButtonConfigs[placementKey]
	if placementEntry then
		local Config = placementEntry.Config
		if Config then
			local AdPlacementID = Config.AdPlacementID
			if AdPlacementID and GetAdPlacementStatus then
				local success, result, claimString, itemName, cooldown, claimEntry, newEntry, serverUsed, serverUsedNum, serverLimit, serverLimitNum
				if forceRefresh then
					success, result = pcall(function()
						return GetAdPlacementStatus:InvokeServer(AdPlacementID)
					end)
					if success and (result and typeof(result) == "table") then
						placementStatusCache[placementKey] = {
							result = result,
							lastUpdate = os.time()
						}
						claimString = result.claimString or Config.ClaimString
						Config.ClaimString = claimString
						itemName = result.itemName or Config.ItemName
						Config.ItemName = itemName
						Config.Cooldown = result.cooldown or 0
						claimEntry = buttonDataByPlacement[placementKey]
						if claimEntry then
							claimEntry.claimCount = claimEntry.claimCount or 0
							claimEntry.serverUsed = result.used
							claimEntry.serverLimit = result.limit
						else
							newEntry = {
								claimCount = 0,
								firstClaimAt = nil,
								lastClaimAt = nil,
								serverUsed = result.used,
								serverLimit = result.limit
							}
							claimEntry = newEntry
						end
						buttonDataByPlacement[placementKey] = claimEntry
						serverUsed = claimEntry.serverUsed
						serverUsedNum = tonumber(serverUsed) or 0
						serverLimit = claimEntry.serverLimit
						serverLimitNum = tonumber(serverLimit) or 0
						print(string.format("Placement %s Claims %d/%d", placementKey, serverUsedNum, serverLimitNum))
					else
						warn("[AdClientDebug] refreshPlacementStatus RF failed for", placementKey, "err=", result)
						placementStatusCache[placementKey] = {
							result = {
								allowed = false,
								cooldown = 0,
								limit = 0,
								used = 0
							},
							lastUpdate = os.time()
						}
					end
				else
					local cachedStatus = placementStatusCache[placementKey]
					if cachedStatus and cachedStatus.result then
						return
					end
					success, result = pcall(function()
						return GetAdPlacementStatus:InvokeServer(AdPlacementID)
					end)
					if success and (result and typeof(result) == "table") then
						placementStatusCache[placementKey] = {
							result = result,
							lastUpdate = os.time()
						}
						claimString = result.claimString or Config.ClaimString
						Config.ClaimString = claimString
						itemName = result.itemName or Config.ItemName
						Config.ItemName = itemName
						Config.Cooldown = result.cooldown or 0
						claimEntry = buttonDataByPlacement[placementKey]
						if claimEntry then
							claimEntry.claimCount = claimEntry.claimCount or 0
							claimEntry.serverUsed = result.used
							claimEntry.serverLimit = result.limit
						else
							newEntry = {
								claimCount = 0,
								firstClaimAt = nil,
								lastClaimAt = nil,
								serverUsed = result.used,
								serverLimit = result.limit
							}
							claimEntry = newEntry
						end
						buttonDataByPlacement[placementKey] = claimEntry
						serverUsed = claimEntry.serverUsed
						serverUsedNum = tonumber(serverUsed) or 0
						serverLimit = claimEntry.serverLimit
						serverLimitNum = tonumber(serverLimit) or 0
						print(string.format("Placement %s Claims %d/%d", placementKey, serverUsedNum, serverLimitNum))
					else
						warn("[AdClientDebug] refreshPlacementStatus RF failed for", placementKey, "err=", result)
						placementStatusCache[placementKey] = {
							result = {
								allowed = false,
								cooldown = 0,
								limit = 0,
								used = 0
							},
							lastUpdate = os.time()
						}
					end
				end
			end
		end
	end
end
local function applyVisibilityToButton(buttonEntry, visible)
	local Button = buttonEntry.Button
	if Button and Button.Parent then
		Button.Visible = visible
		local MoveFrame = buttonEntry.MoveFrame
		local OriginalPos = buttonEntry.OriginalPos
		local TargetPos = buttonEntry.TargetPos
		local MoveTime = buttonEntry.MoveTime
		local MoveOnLoad = buttonEntry.MoveOnLoad
		local AnimateFrame = buttonEntry.AnimateFrame
		CancelAllIdleTweens()
		if MoveFrame and (OriginalPos and TargetPos) and visible then
			if buttonEntry.IsShown then
				return
			end
			buttonEntry.IsShown = true
			if MoveOnLoad and MoveFrame.Position ~= TargetPos then
				local moveTween = tweenGuiPosition(MoveFrame, TargetPos, MoveTime)
				if moveTween then
					moveTween.Completed:Connect(function()
						if AnimateFrame and AnimateFrame.Parent then
							local animTarget = AnimateFrame
							if animTarget then
								local bounceCount = 20
								task.spawn(function()
									if animTarget and animTarget.Parent then
										local Position = animTarget.Position
										local capturedGeneration = tweenGeneration
										task.wait(1)
										for i = 1, bounceCount or 20 do
											if animTarget and (animTarget.Parent and (animTarget.Visible and capturedGeneration == tweenGeneration)) then
												task.wait(1)
												if animTarget and (animTarget.Parent and (animTarget.Visible and capturedGeneration == tweenGeneration)) then
													local upPos = Position + UDim2.new(0, 0, -0.05, 0)
													local downPos = Position + UDim2.new(0, 0, 0.02, 0)
													local tweenUp = TweenService:Create(animTarget, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
														Position = upPos
													})
													if tweenUp then
														table.insert(activeTweens, tweenUp)
													end
													local tweenDown = TweenService:Create(animTarget, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
														Position = downPos
													})
													if tweenDown then
														table.insert(activeTweens, tweenDown)
													end
													local tweenReturn = TweenService:Create(animTarget, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
														Position = Position
													})
													if tweenReturn then
														table.insert(activeTweens, tweenReturn)
													end
													tweenUp:Play()
													tweenUp.Completed:Wait()
													if animTarget and (animTarget.Parent and (animTarget.Visible and capturedGeneration == tweenGeneration)) then
														tweenDown:Play()
														tweenDown.Completed:Wait()
														if animTarget and (animTarget.Parent and (animTarget.Visible and capturedGeneration == tweenGeneration)) then
															tweenReturn:Play()
															tweenReturn.Completed:Wait()
															local _ = animTarget and (animTarget.Parent and (animTarget.Visible and capturedGeneration == tweenGeneration))
														end
													end
												end
											end
											break
										end
									end
								end)
							end
						end
						if MoveFrame and MoveFrame.Parent then
							local hoverTarget = MoveFrame
							if hoverTarget then
								task.spawn(function()
									if hoverTarget and hoverTarget.Parent then
										local Position = hoverTarget.Position
										local hoverOffset = UDim2.new(0, 0, 0, 4)
										local capturedGeneration = tweenGeneration
										local tweenInfoOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
										local _ = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
										for i = 1, 20 do
											if hoverTarget and (hoverTarget.Parent and (hoverTarget.Visible and capturedGeneration == tweenGeneration)) then
												local tween = TweenService:Create(hoverTarget, tweenInfoOut, {
													Position = Position + hoverOffset
												})
												if tween then
													table.insert(activeTweens, tween)
												end
												tween:Play()
												tween.Completed:Wait()
												task.wait(1)
												local _ = hoverTarget and (hoverTarget.Parent and (hoverTarget.Visible and capturedGeneration == tweenGeneration))
											end
											break
										end
									end
								end)
							end
						end
					end)
				end
			end
		elseif MoveFrame and (OriginalPos and TargetPos) and buttonEntry.IsShown then
			buttonEntry.IsShown = false
			tweenGuiPosition(MoveFrame, OriginalPos, MoveTime)
		end
	end
end
local function evaluatePlacementVisibility(placementKey)
	local placementEntry = claimButtonConfigs[placementKey]
	if placementEntry then
		local Config = placementEntry.Config
		if Config then
			local claimData = buttonDataByPlacement[placementKey]
			local lastClaimAt = claimData and claimData.lastClaimAt or nil
			local isEligible, isReady
			if getAdStateCallback then
				local eligible, ready = getAdStateCallback()
				isEligible = eligible
				isReady = ready
			else
				warn("WatchAdButtonController: GetAdState not set")
				isEligible = false
				isReady = false
			end
			local shouldShow = isEligible and isReady
			local now = os.time()
			local cooldown = tonumber(Config.Cooldown) or 0
			if lastClaimAt and (cooldown > 0 and now - lastClaimAt < cooldown) then
				for i, buttonEntry in ipairs(placementEntry.buttons) do
					local Button = buttonEntry.Button
					if Button and Button.Parent then
						Button.Visible = false
						local MoveFrame = buttonEntry.MoveFrame
						local OriginalPos = buttonEntry.OriginalPos
						local MoveTime = buttonEntry.MoveTime
						local MoveOnLoad = buttonEntry.MoveOnLoad
						local AnimateFrame = buttonEntry.AnimateFrame
						CancelAllIdleTweens()
						if MoveFrame and (OriginalPos and buttonEntry.TargetPos) and buttonEntry.IsShown then
							buttonEntry.IsShown = false
							tweenGuiPosition(MoveFrame, OriginalPos, MoveTime)
						end
					end
				end
			else
				refreshPlacementStatus(placementKey, true)
				local statusCache = placementStatusCache[placementKey]
				if statusCache and statusCache.result then
					local result = statusCache.result
					if result.allowed ~= true then
						shouldShow = false
					end
					Config.Cooldown = result.cooldown or Config.Cooldown or 0
					local _ = tonumber(Config.Cooldown) or 0
				else
					shouldShow = false
				end
				local updatedClaimData = buttonDataByPlacement[placementKey]
				local serverLimit = updatedClaimData and updatedClaimData.serverLimit or 0
				if shouldShow and (serverLimit > 0 and serverLimit <= (updatedClaimData and updatedClaimData.claimCount or 0)) then
					shouldShow = false
				end
				for i, buttonEntry in ipairs(placementEntry.buttons) do
					applyVisibilityToButton(buttonEntry, shouldShow)
				end
			end
		end
	end
end
local function evaluateAllPlacementButtonsInternal()
	for k, v in pairs(claimButtonConfigs) do
		evaluatePlacementVisibility(k)
	end
end
local function connectclaimbutton(configNode)
	local guiButton = configNode.Parent
	if guiButton and guiButton:IsA("GuiButton") then
		local adPlacementID = configNode:GetAttribute("AdPlacementID")
		local placementKey = tostring(adPlacementID or guiButton:GetFullName())
		local moveFrameObj = configNode:FindFirstChild("MoveFrame")
		local animateFrameObj = configNode:FindFirstChild("AnimateFrame")
		local moveFrameGui = nil
		local targetPos = nil
		local originalPos = nil
		local moveOnLoad = false
		local moveTime = nil
		local animateFrameGui = nil
		if moveFrameObj and moveFrameObj:IsA("ObjectValue") then
			local guiTarget = moveFrameObj.Value
			if guiTarget and guiTarget:IsA("GuiObject") then
				local posAttr = moveFrameObj:GetAttribute("Pos")
				if typeof(posAttr) == "UDim2" then
					moveFrameGui = guiTarget
					targetPos = posAttr
					originalPos = guiTarget.Position
					local moveTimeAttr = moveFrameObj:GetAttribute("MoveTime")
					if typeof(moveTimeAttr) == "number" and moveTimeAttr > 0 then
						moveTime = moveTimeAttr
					end
					local buttonMoveTime = configNode:GetAttribute("MoveTime")
					if not moveTime and (typeof(buttonMoveTime) == "number" and buttonMoveTime > 0) then
						moveTime = buttonMoveTime
					end
					local moveOnLoadAttr = moveFrameObj:GetAttribute("MoveOnLoad")
					if typeof(moveOnLoadAttr) == "boolean" and moveOnLoadAttr == true then
						moveOnLoad = true
					end
				else
					warn("MoveFrame on", configNode:GetFullName(), "missing or invalid Pos attribute")
				end
			end
		end
		if animateFrameObj and animateFrameObj:IsA("ObjectValue") then
			local guiTarget = animateFrameObj.Value
			if guiTarget and guiTarget:IsA("GuiObject") then
				animateFrameGui = guiTarget
			else
				warn("AnimateFrame on", configNode:GetFullName(), "missing or invalid GuiObject value")
			end
		end
		local promptName = moveFrameGui and moveFrameGui.Name or guiButton.Name
		local moveOnSignalObj = configNode:FindFirstChild("MoveOnSignal")
		if moveOnSignalObj and (moveOnSignalObj:IsA("ObjectValue") and (moveFrameGui and targetPos)) then
			local bindableEvent = moveOnSignalObj.Value
			if bindableEvent and bindableEvent:IsA("BindableEvent") then
				local stringReq = moveOnSignalObj:GetAttribute("StringReq")
				if typeof(stringReq) == "string" and stringReq ~= "" then
					bindableEvent.Event:Connect(function(signalArg)
						if signalArg == nil then
							if moveFrameGui and originalPos then
								tweenGuiPosition(moveFrameGui, originalPos, moveTime)
							end
						elseif signalArg == stringReq and guiButton.Visible then
							CancelAllIdleTweens()
							local moveTween = tweenGuiPosition(moveFrameGui, targetPos, moveTime)
							if moveTween then
								moveTween.Completed:Connect(function()
									if animateFrameGui and animateFrameGui.Parent then
										local animTarget = animateFrameGui
										if animTarget then
											local bounceCount = 20
											task.spawn(function()
												if animTarget and animTarget.Parent then
													local Position = animTarget.Position
													local capturedGeneration = tweenGeneration
													task.wait(1)
													for i = 1, bounceCount or 20 do
														if animTarget and (animTarget.Parent and (animTarget.Visible and capturedGeneration == tweenGeneration)) then
															task.wait(1)
															if animTarget and (animTarget.Parent and (animTarget.Visible and capturedGeneration == tweenGeneration)) then
																local upPos = Position + UDim2.new(0, 0, -0.05, 0)
																local downPos = Position + UDim2.new(0, 0, 0.02, 0)
																local tweenUp = TweenService:Create(animTarget, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
																	Position = upPos
																})
																if tweenUp then
																	table.insert(activeTweens, tweenUp)
																end
																local tweenDown = TweenService:Create(animTarget, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
																	Position = downPos
																})
																if tweenDown then
																	table.insert(activeTweens, tweenDown)
																end
																local tweenReturn = TweenService:Create(animTarget, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
																	Position = Position
																})
																if tweenReturn then
																	table.insert(activeTweens, tweenReturn)
																end
																tweenUp:Play()
																tweenUp.Completed:Wait()
																if animTarget and (animTarget.Parent and (animTarget.Visible and capturedGeneration == tweenGeneration)) then
																	tweenDown:Play()
																	tweenDown.Completed:Wait()
																	if animTarget and (animTarget.Parent and (animTarget.Visible and capturedGeneration == tweenGeneration)) then
																		tweenReturn:Play()
																		tweenReturn.Completed:Wait()
																		local _ = animTarget and (animTarget.Parent and (animTarget.Visible and capturedGeneration == tweenGeneration))
																	end
																end
															end
														end
														break
													end
												end
											end)
										end
									end
									if moveFrameGui and moveFrameGui.Parent then
										local hoverTarget = moveFrameGui
										if hoverTarget then
											task.spawn(function()
												if hoverTarget and hoverTarget.Parent then
													local Position = hoverTarget.Position
													local hoverOffset = UDim2.new(0, 0, 0, 4)
													local capturedGeneration = tweenGeneration
													local tweenInfoOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
													local _ = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
													for i = 1, 20 do
														if hoverTarget and (hoverTarget.Parent and (hoverTarget.Visible and capturedGeneration == tweenGeneration)) then
															local tween = TweenService:Create(hoverTarget, tweenInfoOut, {
																Position = Position + hoverOffset
															})
															if tween then
																table.insert(activeTweens, tween)
															end
															tween:Play()
															tween.Completed:Wait()
															task.wait(1)
															local _ = hoverTarget and (hoverTarget.Parent and (hoverTarget.Visible and capturedGeneration == tweenGeneration))
														end
														break
													end
												end
											end)
										end
									end
								end)
							end
							local regionTag = getCurrentRegionTagCallback and getCurrentRegionTagCallback() or nil
							if regionTag then
								Telemetry.send("PromptRegion_" .. regionTag)
							end
						end
					end)
				else
					warn("MoveOnSignal on", configNode:GetFullName(), "missing or invalid StringReq attribute")
				end
			else
				warn("MoveOnSignal on", configNode:GetFullName(), "missing or invalid BindableEvent value")
			end
		end
		if not claimButtonConfigs[placementKey] then
			claimButtonConfigs[placementKey] = {
				buttons = {},
				Config = {
					AdPlacementID = adPlacementID,
					ClaimString = nil,
					ItemName = nil,
					Cooldown = 0,
					PromptName = promptName
				}
			}
		end
		local buttonEntry = {
			Button = guiButton,
			MoveFrame = moveFrameGui,
			OriginalPos = originalPos,
			TargetPos = targetPos,
			MoveOnLoad = moveOnLoad,
			MoveTime = moveTime,
			AnimateFrame = animateFrameGui,
			IsShown = false
		}
		if moveFrameGui then
			local Close = moveFrameGui:FindFirstChild("Close", true)
			if Close and Close:IsA("GuiButton") then
				Close.MouseButton1Click:Connect(function()
					local entry = buttonEntry
					local Button = entry.Button
					if Button and Button.Parent then
						Button.Visible = false
						local MoveFrame = entry.MoveFrame
						local OriginalPos = entry.OriginalPos
						local MoveTime = entry.MoveTime
						local MoveOnLoad = entry.MoveOnLoad
						local AnimateFrame = entry.AnimateFrame
						CancelAllIdleTweens()
						if MoveFrame and (OriginalPos and (entry.TargetPos and entry.IsShown)) then
							entry.IsShown = false
							tweenGuiPosition(MoveFrame, OriginalPos, MoveTime)
						end
					end
					if AdRewardsController and AdRewardsController.TriggerPromptInteracted then
						AdRewardsController.TriggerPromptInteracted()
					end
				end)
			end
		end
		table.insert(claimButtonConfigs[placementKey].buttons, buttonEntry)
		local Button = buttonEntry.Button
		if Button and Button.Parent then
			Button.Visible = false
			local MoveFrame_2 = buttonEntry.MoveFrame
			local OriginalPos = buttonEntry.OriginalPos
			local MoveTime = buttonEntry.MoveTime
			local MoveOnLoad = buttonEntry.MoveOnLoad
			local AnimateFrame_2 = buttonEntry.AnimateFrame
			CancelAllIdleTweens()
			if MoveFrame_2 and (OriginalPos and (buttonEntry.TargetPos and buttonEntry.IsShown)) then
				buttonEntry.IsShown = false
				tweenGuiPosition(MoveFrame_2, OriginalPos, MoveTime)
			end
		end
		refreshPlacementStatus(placementKey, false)
		guiButton.MouseButton1Down:Connect(function()
			local isEligible, isReady, isWatching
			if getAdStateCallback then
				local eligible, ready, watching = getAdStateCallback()
				isEligible = eligible
				isReady = ready
				isWatching = watching
			else
				warn("WatchAdButtonController: GetAdState not set")
				isEligible = false
				isReady = false
				isWatching = false
			end
			if isEligible then
				if isReady then
					if not isWatching and playAdCallback then
						CancelAllIdleTweens()
						local regionTag = getCurrentRegionTagCallback and getCurrentRegionTagCallback() or nil
						pendingAdContext = {
							placementKey = placementKey,
							config = claimButtonConfigs[placementKey].Config,
							regionTag = regionTag
						}
						local entry = buttonEntry
						local Button = entry.Button
						if Button and Button.Parent then
							Button.Visible = false
							local MoveFrame = entry.MoveFrame
							local OriginalPos = entry.OriginalPos
							local MoveTime = entry.MoveTime
							local MoveOnLoad = entry.MoveOnLoad
							local AnimateFrame = entry.AnimateFrame
							CancelAllIdleTweens()
							if MoveFrame and (OriginalPos and (entry.TargetPos and entry.IsShown)) then
								entry.IsShown = false
								tweenGuiPosition(MoveFrame, OriginalPos, MoveTime)
							end
						end
						Telemetry.send("StartAd_" .. (claimButtonConfigs[placementKey].Config.PromptName or placementKey))
						if regionTag then
							Telemetry.send("StartAdRegion_" .. regionTag)
						end
						if playAdCallback(adPlacementID) and (AdRewardsController and AdRewardsController.TriggerPromptInteracted) then
							AdRewardsController.TriggerPromptInteracted()
						end
					elseif not isWatching then
						warn("PlayAd callback not set")
					end
				else
					warn("Ad not ready yet (placement button)")
				end
			else
				warn("Player not eligible for ads (placement button)")
			end
		end)
	else
		warn("WatchAdToClaim parent is not a GuiButton:", configNode:GetFullName())
	end
end
local function findclaimbuttons()
	table.clear(claimDataByPlacement)
	claimButtonConfigs = {}
	buttonDataByPlacement = {}
	placementStatusCache = {}
	if playerGui then
		for k, v in pairs((playerGui:GetDescendants())) do
			if v.Name == "WatchAdToClaim" and v:IsA("Configuration") then
				table.insert(claimDataByPlacement, v)
			end
		end
		for k, v in pairs(claimDataByPlacement) do
			connectclaimbutton(v)
		end
		for k, v in pairs(claimButtonConfigs) do
			evaluatePlacementVisibility(k)
		end
	else
		warn("WatchAdButtonController: PlayerGui nil in findclaimbuttons")
	end
end
function t.Init(initParams)
	playerGui = initParams.PlayerGui
	playAdCallback = initParams.PlayAd
	getAdStateCallback = initParams.GetAdState
	getCurrentRegionTagCallback = initParams.GetCurrentRegionTag
	local success, err = pcall(function()
		findclaimbuttons()
	end)
	if not success then
		warn("WatchAdButtonController: findclaimbuttons failed:", err)
	end
end
function t.EvaluateAllPlacementButtons()
	for k, v in pairs(claimButtonConfigs) do
		evaluatePlacementVisibility(k)
	end
end
function t.OnAdCompleted(adShown, showAdResult)
	local context = pendingAdContext
	pendingAdContext = nil
	if context then
		local placementKey = context.placementKey
		local config = context.config
		local regionTag = context.regionTag
		if placementKey and config then
			local promptName = config.PromptName or placementKey
			local claimString = config.ClaimString or "UnknownReward"
			local now = os.time()
			local claimEntry = buttonDataByPlacement[placementKey]
			if claimEntry then
				claimEntry.claimCount = claimEntry.claimCount or 0
			else
				claimEntry = {
					claimCount = 0,
					firstClaimAt = nil,
					lastClaimAt = nil,
					serverUsed = nil,
					serverLimit = nil
				}
			end
			if adShown and showAdResult == Enum.ShowAdResult.ShowCompleted then
				claimEntry.claimCount = claimEntry.claimCount + 1
				claimEntry.firstClaimAt = claimEntry.firstClaimAt or now
				claimEntry.lastClaimAt = now
				buttonDataByPlacement[placementKey] = claimEntry
				task.spawn(function()
					refreshPlacementStatus(placementKey, true)
				end)
				Telemetry.send("AdWatchComplete_" .. promptName)
				if regionTag then
					Telemetry.send("AdWatchComplete_" .. regionTag)
					Telemetry.send("RewardGrant_" .. claimString .. "_" .. regionTag)
				else
					Telemetry.send("RewardGrant_" .. claimString)
				end
				evaluatePlacementVisibility(placementKey)
				local cooldown = tonumber(config.Cooldown) or 0
				if cooldown > 0 then
					task.delay(cooldown, function()
						evaluatePlacementVisibility(placementKey)
					end)
				end
			else
				Telemetry.send("AdWatchIncomplete_" .. promptName)
				if regionTag then
					Telemetry.send("AdWatchIncomplete_" .. regionTag)
				end
			end
		end
	end
end
return t
