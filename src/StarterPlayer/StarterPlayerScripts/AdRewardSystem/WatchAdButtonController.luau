local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notification = require(ReplicatedStorage.Game.Notification)
local AdRewardsController = require(script.Parent:WaitForChild("AdRewardsController"))
local Telemetry = require(script.Parent.Telemetry)
local t = {}
local AdRewardEvents = ReplicatedStorage:WaitForChild("AdRewardSystem"):WaitForChild("AdRewardEvents")
local GrantReward = AdRewardEvents:WaitForChild("GrantReward")
local GetAdPlacementStatus = AdRewardEvents:WaitForChild("GetAdPlacementStatus")
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local v5 = nil
local t6 = {}
local v6 = 0
local function registerTween(p1) --[[ Line: 48 | Upvalues: t6 (copy) ]]
	if p1 then
		table.insert(t6, p1)
	end
	return p1
end
local function CancelAllIdleTweens() --[[ Line: 55 | Upvalues: v6 (ref), t6 (copy) ]]
	v6 = v6 + 1
	for i, v in ipairs(t6) do
		if v then
			pcall(function() --[[ Line: 59 | Upvalues: v (copy) ]]
				v:Cancel()
			end)
		end
	end
	table.clear(t6)
end
local function getAvailability() --[[ Line: 71 | Upvalues: v3 (ref) ]]
	if v3 then
		return v3()
	else
		warn("WatchAdButtonController: GetAdState not set")
		return false, false, false
	end
end
local function tweenGuiPosition(p1, p2, p3) --[[ Line: 84 | Upvalues: CancelAllIdleTweens (copy), TweenService (copy), t6 (copy) ]]
	if p1 and p1.Parent then
		CancelAllIdleTweens()
		local v1 = TweenService:Create(p1, TweenInfo.new(p3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Position = p2
		})
		if v1 then
			table.insert(t6, v1)
		end
		v1:Play()
		return v1
	else
		return nil
	end
end
local function bouncelooptween(p1, p2) --[[ Line: 103 | Upvalues: v6 (ref), TweenService (copy), t6 (copy) ]]
	if p1 then
		task.spawn(function() --[[ Line: 108 | Upvalues: p1 (copy), v6 (ref), p2 (copy), TweenService (ref), t6 (ref) ]]
			if p1 and p1.Parent then
				local Position = p1.Position
				local v1 = v6
				task.wait(1)
				for i = 1, p2 or 20 do
					if p1 and (p1.Parent and (p1.Visible and v1 == v6)) then
						task.wait(1)
						if p1 and (p1.Parent and (p1.Visible and v1 == v6)) then
							local v3 = Position + UDim2.new(0, 0, -0.05, 0)
							local v4 = Position + UDim2.new(0, 0, 0.02, 0)
							local v5 = TweenService:Create(p1, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Position = v3
							})
							if v5 then
								table.insert(t6, v5)
							end
							local v7 = TweenService:Create(p1, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
								Position = v4
							})
							if v7 then
								table.insert(t6, v7)
							end
							local v9 = TweenService:Create(p1, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Position = Position
							})
							if v9 then
								table.insert(t6, v9)
							end
							v5:Play()
							v5.Completed:Wait()
							if p1 and (p1.Parent and (p1.Visible and v1 == v6)) then
								v7:Play()
								v7.Completed:Wait()
								if p1 and (p1.Parent and (p1.Visible and v1 == v6)) then
									v9:Play()
									v9.Completed:Wait()
									local _ = p1 and (p1.Parent and (p1.Visible and v1 == v6))
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
local function hoveranimation(p1) --[[ Line: 199 | Upvalues: v6 (ref), TweenService (copy), t6 (copy) ]]
	if p1 then
		task.spawn(function() --[[ Line: 204 | Upvalues: p1 (copy), v6 (ref), TweenService (ref), t6 (ref) ]]
			if p1 and p1.Parent then
				local Position = p1.Position
				local v1 = UDim2.new(0, 0, 0, 4)
				local v2 = v6
				local v3 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				local _ = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
				for i = 1, 20 do
					if p1 and (p1.Parent and (p1.Visible and v2 == v6)) then
						local v4 = TweenService:Create(p1, v3, {
							Position = Position + v1
						})
						if v4 then
							table.insert(t6, v4)
						end
						v4:Play()
						v4.Completed:Wait()
						task.wait(1)
						local _ = p1 and (p1.Parent and (p1.Visible and v2 == v6))
					end
					break
				end
			end
		end)
	end
end
GrantReward.OnClientEvent:Connect(function(p1, p2) --[[ Line: 259 | Upvalues: Notification (copy) ]]
	if p1 == "2xCash" and typeof(p2) == "number" then
		Notification.new({
			Text = string.format("You\'ve Earned %s min of 2x CASH!", p2 / 60),
			Style = "Gift"
		})
	end
end)
local function refreshPlacementStatus(p1, p2) --[[ Line: 272 | Upvalues: t3 (ref), GetAdPlacementStatus (copy), t5 (ref), t4 (ref) ]]
	local v1 = t3[p1]
	if v1 then
		local Config = v1.Config
		if Config then
			local AdPlacementID = Config.AdPlacementID
			if AdPlacementID and GetAdPlacementStatus then
				local v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
				if p2 then
					v2, v3 = pcall(function() --[[ Line: 295 | Upvalues: GetAdPlacementStatus (ref), AdPlacementID (copy) ]]
						return GetAdPlacementStatus:InvokeServer(AdPlacementID)
					end)
					if v2 and (v3 and typeof(v3) == "table") then
						t5[p1] = {
							result = v3,
							lastUpdate = os.time()
						}
						v4 = v3.claimString or Config.ClaimString
						Config.ClaimString = v4
						v5 = v3.itemName or Config.ItemName
						Config.ItemName = v5
						Config.Cooldown = v3.cooldown or 0
						v6 = t4[p1]
						if v6 then
							v6.claimCount = v6.claimCount or 0
							v6.serverUsed = v3.used
							v6.serverLimit = v3.limit
						else
							v7 = {
								claimCount = 0,
								firstClaimAt = nil,
								lastClaimAt = nil,
								serverUsed = v3.used,
								serverLimit = v3.limit
							}
							v6 = v7
						end
						t4[p1] = v6
						v8 = v6.serverUsed
						v9 = tonumber(v8) or 0
						v10 = v6.serverLimit
						v11 = tonumber(v10) or 0
						print(string.format("Placement %s Claims %d/%d", p1, v9, v11))
					else
						warn("[AdClientDebug] refreshPlacementStatus RF failed for", p1, "err=", v3)
						t5[p1] = {
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
					local v12 = t5[p1]
					if v12 and v12.result then
						return
					end
					v2, v3 = pcall(function() --[[ Line: 295 | Upvalues: GetAdPlacementStatus (ref), AdPlacementID (copy) ]]
						return GetAdPlacementStatus:InvokeServer(AdPlacementID)
					end)
					if v2 and (v3 and typeof(v3) == "table") then
						t5[p1] = {
							result = v3,
							lastUpdate = os.time()
						}
						v4 = v3.claimString or Config.ClaimString
						Config.ClaimString = v4
						v5 = v3.itemName or Config.ItemName
						Config.ItemName = v5
						Config.Cooldown = v3.cooldown or 0
						v6 = t4[p1]
						if v6 then
							v6.claimCount = v6.claimCount or 0
							v6.serverUsed = v3.used
							v6.serverLimit = v3.limit
						else
							v7 = {
								claimCount = 0,
								firstClaimAt = nil,
								lastClaimAt = nil,
								serverUsed = v3.used,
								serverLimit = v3.limit
							}
							v6 = v7
						end
						t4[p1] = v6
						v8 = v6.serverUsed
						v9 = tonumber(v8) or 0
						v10 = v6.serverLimit
						v11 = tonumber(v10) or 0
						print(string.format("Placement %s Claims %d/%d", p1, v9, v11))
					else
						warn("[AdClientDebug] refreshPlacementStatus RF failed for", p1, "err=", v3)
						t5[p1] = {
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
local function applyVisibilityToButton(p1, p2) --[[ Line: 342 | Upvalues: CancelAllIdleTweens (copy), tweenGuiPosition (copy), v6 (ref), TweenService (copy), t6 (copy) ]]
	local Button = p1.Button
	if Button and Button.Parent then
		Button.Visible = p2
		local MoveFrame = p1.MoveFrame
		local OriginalPos = p1.OriginalPos
		local TargetPos = p1.TargetPos
		local MoveTime = p1.MoveTime
		local MoveOnLoad = p1.MoveOnLoad
		local AnimateFrame = p1.AnimateFrame
		CancelAllIdleTweens()
		if MoveFrame and (OriginalPos and TargetPos) and p2 then
			if p1.IsShown then
				return
			end
			p1.IsShown = true
			if MoveOnLoad and MoveFrame.Position ~= TargetPos then
				local v1 = tweenGuiPosition(MoveFrame, TargetPos, MoveTime)
				if v1 then
					v1.Completed:Connect(function() --[[ Line: 369 | Upvalues: AnimateFrame (copy), v6 (ref), TweenService (ref), t6 (ref), MoveFrame (copy) ]]
						if AnimateFrame and AnimateFrame.Parent then
							local v1 = AnimateFrame
							if v1 then
								local v2 = 20
								task.spawn(function() --[[ Line: 108 | Upvalues: v1 (copy), v6 (ref), v2 (copy), TweenService (ref), t6 (ref) ]]
									if v1 and v1.Parent then
										local Position = v1.Position
										local v12 = v6
										task.wait(1)
										for i = 1, v2 or 20 do
											if v1 and (v1.Parent and (v1.Visible and v12 == v6)) then
												task.wait(1)
												if v1 and (v1.Parent and (v1.Visible and v12 == v6)) then
													local v3 = Position + UDim2.new(0, 0, -0.05, 0)
													local v4 = Position + UDim2.new(0, 0, 0.02, 0)
													local v5 = TweenService:Create(v1, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
														Position = v3
													})
													if v5 then
														table.insert(t6, v5)
													end
													local v7 = TweenService:Create(v1, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
														Position = v4
													})
													if v7 then
														table.insert(t6, v7)
													end
													local v9 = TweenService:Create(v1, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
														Position = Position
													})
													if v9 then
														table.insert(t6, v9)
													end
													v5:Play()
													v5.Completed:Wait()
													if v1 and (v1.Parent and (v1.Visible and v12 == v6)) then
														v7:Play()
														v7.Completed:Wait()
														if v1 and (v1.Parent and (v1.Visible and v12 == v6)) then
															v9:Play()
															v9.Completed:Wait()
															local _ = v1 and (v1.Parent and (v1.Visible and v12 == v6))
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
							local v3 = MoveFrame
							if v3 then
								task.spawn(function() --[[ Line: 204 | Upvalues: v3 (copy), v6 (ref), TweenService (ref), t6 (ref) ]]
									if v3 and v3.Parent then
										local Position = v3.Position
										local v1 = UDim2.new(0, 0, 0, 4)
										local v2 = v6
										local v32 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
										local _ = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
										for i = 1, 20 do
											if v3 and (v3.Parent and (v3.Visible and v2 == v6)) then
												local v4 = TweenService:Create(v3, v32, {
													Position = Position + v1
												})
												if v4 then
													table.insert(t6, v4)
												end
												v4:Play()
												v4.Completed:Wait()
												task.wait(1)
												local _ = v3 and (v3.Parent and (v3.Visible and v2 == v6))
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
		elseif MoveFrame and (OriginalPos and TargetPos) and p1.IsShown then
			p1.IsShown = false
			tweenGuiPosition(MoveFrame, OriginalPos, MoveTime)
		end
	end
end
local function evaluatePlacementVisibility(p1) --[[ Line: 389 | Upvalues: t3 (ref), t4 (ref), v3 (ref), CancelAllIdleTweens (copy), tweenGuiPosition (copy), refreshPlacementStatus (copy), t5 (ref), applyVisibilityToButton (copy) ]]
	local v1 = t3[p1]
	if v1 then
		local Config = v1.Config
		if Config then
			local v2 = t4[p1]
			local v32 = v2 and v2.lastClaimAt or nil
			local v4, v5
			if v3 then
				local v6, v7 = v3()
				v4 = v6
				v5 = v7
			else
				warn("WatchAdButtonController: GetAdState not set")
				v4 = false
				v5 = false
			end
			local v8 = v4 and v5
			local v9 = os.time()
			local v10 = tonumber(Config.Cooldown) or 0
			if v32 and (v10 > 0 and v9 - v32 < v10) then
				for i, v in ipairs(v1.buttons) do
					local Button = v.Button
					if Button and Button.Parent then
						Button.Visible = false
						local MoveFrame = v.MoveFrame
						local OriginalPos = v.OriginalPos
						local MoveTime = v.MoveTime
						local MoveOnLoad = v.MoveOnLoad
						local AnimateFrame = v.AnimateFrame
						CancelAllIdleTweens()
						if MoveFrame and (OriginalPos and v.TargetPos) and v.IsShown then
							v.IsShown = false
							tweenGuiPosition(MoveFrame, OriginalPos, MoveTime)
						end
					end
				end
			else
				refreshPlacementStatus(p1, true)
				local v11 = t5[p1]
				if v11 and v11.result then
					local result = v11.result
					if result.allowed ~= true then
						v8 = false
					end
					Config.Cooldown = result.cooldown or Config.Cooldown or 0
					local _ = tonumber(Config.Cooldown) or 0
				else
					v8 = false
				end
				local v14 = t4[p1]
				local v16 = v14 and v14.serverLimit or 0
				if v8 and (v16 > 0 and v16 <= (v14 and v14.claimCount or 0)) then
					v8 = false
				end
				for i, v in ipairs(v1.buttons) do
					applyVisibilityToButton(v, v8)
				end
			end
		end
	end
end
local function evaluateAllPlacementButtonsInternal() --[[ Line: 450 | Upvalues: t3 (ref), evaluatePlacementVisibility (copy) ]]
	for k, v in pairs(t3) do
		evaluatePlacementVisibility(k)
	end
end
local function connectclaimbutton(p1) --[[ Line: 460 | Upvalues: tweenGuiPosition (copy), CancelAllIdleTweens (copy), v6 (ref), TweenService (copy), t6 (copy), v4 (ref), Telemetry (copy), t3 (ref), AdRewardsController (copy), refreshPlacementStatus (copy), v3 (ref), v2 (ref), v5 (ref) ]]
	local v1 = p1.Parent
	if v1 and v1:IsA("GuiButton") then
		local v22 = p1:GetAttribute("AdPlacementID")
		local v42 = tostring(v22 or v1:GetFullName())
		local MoveFrame = p1:FindFirstChild("MoveFrame")
		local AnimateFrame = p1:FindFirstChild("AnimateFrame")
		local v52 = nil
		local v62 = nil
		local v7 = nil
		local v8 = false
		local v9 = nil
		local v10 = nil
		if MoveFrame and MoveFrame:IsA("ObjectValue") then
			local v11 = MoveFrame.Value
			if v11 and v11:IsA("GuiObject") then
				local v12 = MoveFrame:GetAttribute("Pos")
				if typeof(v12) == "UDim2" then
					v52 = v11
					v62 = v12
					v7 = v11.Position
					local v13 = MoveFrame:GetAttribute("MoveTime")
					if typeof(v13) == "number" and v13 > 0 then
						v9 = v13
					end
					local v14 = p1:GetAttribute("MoveTime")
					if not v9 and (typeof(v14) == "number" and v14 > 0) then
						v9 = v14
					end
					local v15 = MoveFrame:GetAttribute("MoveOnLoad")
					if typeof(v15) == "boolean" and v15 == true then
						v8 = true
					end
				else
					warn("MoveFrame on", p1:GetFullName(), "missing or invalid Pos attribute")
				end
			end
		end
		if AnimateFrame and AnimateFrame:IsA("ObjectValue") then
			local v16 = AnimateFrame.Value
			if v16 and v16:IsA("GuiObject") then
				v10 = v16
			else
				warn("AnimateFrame on", p1:GetFullName(), "missing or invalid GuiObject value")
			end
		end
		local v17 = v52 and v52.Name or v1.Name
		local MoveOnSignal = p1:FindFirstChild("MoveOnSignal")
		if MoveOnSignal and (MoveOnSignal:IsA("ObjectValue") and (v52 and v62)) then
			local v18 = MoveOnSignal.Value
			if v18 and v18:IsA("BindableEvent") then
				local v19 = MoveOnSignal:GetAttribute("StringReq")
				if typeof(v19) == "string" and v19 ~= "" then
					v18.Event:Connect(function(p1) --[[ Line: 532 | Upvalues: v52 (ref), v7 (ref), tweenGuiPosition (ref), v9 (ref), v19 (copy), v1 (copy), CancelAllIdleTweens (ref), v62 (ref), v10 (ref), v6 (ref), TweenService (ref), t6 (ref), v4 (ref), Telemetry (ref) ]]
						if p1 == nil then
							if v52 and v7 then
								tweenGuiPosition(v52, v7, v9)
							end
						elseif p1 == v19 and v1.Visible then
							CancelAllIdleTweens()
							local v12 = tweenGuiPosition(v52, v62, v9)
							if v12 then
								v12.Completed:Connect(function() --[[ Line: 549 | Upvalues: v10 (ref), v6 (ref), TweenService (ref), t6 (ref), v52 (ref) ]]
									if v10 and v10.Parent then
										local v1 = v10
										if v1 then
											local v2 = 20
											task.spawn(function() --[[ Line: 108 | Upvalues: v1 (copy), v6 (ref), v2 (copy), TweenService (ref), t6 (ref) ]]
												if v1 and v1.Parent then
													local Position = v1.Position
													local v12 = v6
													task.wait(1)
													for i = 1, v2 or 20 do
														if v1 and (v1.Parent and (v1.Visible and v12 == v6)) then
															task.wait(1)
															if v1 and (v1.Parent and (v1.Visible and v12 == v6)) then
																local v3 = Position + UDim2.new(0, 0, -0.05, 0)
																local v4 = Position + UDim2.new(0, 0, 0.02, 0)
																local v5 = TweenService:Create(v1, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
																	Position = v3
																})
																if v5 then
																	table.insert(t6, v5)
																end
																local v7 = TweenService:Create(v1, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
																	Position = v4
																})
																if v7 then
																	table.insert(t6, v7)
																end
																local v9 = TweenService:Create(v1, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
																	Position = Position
																})
																if v9 then
																	table.insert(t6, v9)
																end
																v5:Play()
																v5.Completed:Wait()
																if v1 and (v1.Parent and (v1.Visible and v12 == v6)) then
																	v7:Play()
																	v7.Completed:Wait()
																	if v1 and (v1.Parent and (v1.Visible and v12 == v6)) then
																		v9:Play()
																		v9.Completed:Wait()
																		local _ = v1 and (v1.Parent and (v1.Visible and v12 == v6))
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
									if v52 and v52.Parent then
										local v3 = v52
										if v3 then
											task.spawn(function() --[[ Line: 204 | Upvalues: v3 (copy), v6 (ref), TweenService (ref), t6 (ref) ]]
												if v3 and v3.Parent then
													local Position = v3.Position
													local v1 = UDim2.new(0, 0, 0, 4)
													local v2 = v6
													local v32 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
													local _ = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
													for i = 1, 20 do
														if v3 and (v3.Parent and (v3.Visible and v2 == v6)) then
															local v4 = TweenService:Create(v3, v32, {
																Position = Position + v1
															})
															if v4 then
																table.insert(t6, v4)
															end
															v4:Play()
															v4.Completed:Wait()
															task.wait(1)
															local _ = v3 and (v3.Parent and (v3.Visible and v2 == v6))
														end
														break
													end
												end
											end)
										end
									end
								end)
							end
							local v2 = v4 and v4() or nil
							if v2 then
								Telemetry.send("PromptRegion_" .. v2)
							end
						end
					end)
				else
					warn("MoveOnSignal on", p1:GetFullName(), "missing or invalid StringReq attribute")
				end
			else
				warn("MoveOnSignal on", p1:GetFullName(), "missing or invalid BindableEvent value")
			end
		end
		if not t3[v42] then
			t3[v42] = {
				buttons = {},
				Config = {
					AdPlacementID = v22,
					ClaimString = nil,
					ItemName = nil,
					Cooldown = 0,
					PromptName = v17
				}
			}
		end
		local t = {
			Button = v1,
			MoveFrame = v52,
			OriginalPos = v7,
			TargetPos = v62,
			MoveOnLoad = v8,
			MoveTime = v9,
			AnimateFrame = v10,
			IsShown = false
		}
		if v52 then
			local Close = v52:FindFirstChild("Close", true)
			if Close and Close:IsA("GuiButton") then
				Close.MouseButton1Click:Connect(function() --[[ Line: 603 | Upvalues: t (copy), CancelAllIdleTweens (ref), tweenGuiPosition (ref), AdRewardsController (ref) ]]
					local v1 = t
					local Button = v1.Button
					if Button and Button.Parent then
						Button.Visible = false
						local MoveFrame = v1.MoveFrame
						local OriginalPos = v1.OriginalPos
						local MoveTime = v1.MoveTime
						local MoveOnLoad = v1.MoveOnLoad
						local AnimateFrame = v1.AnimateFrame
						CancelAllIdleTweens()
						if MoveFrame and (OriginalPos and (v1.TargetPos and v1.IsShown)) then
							v1.IsShown = false
							tweenGuiPosition(MoveFrame, OriginalPos, MoveTime)
						end
					end
					if AdRewardsController and AdRewardsController.TriggerPromptInteracted then
						AdRewardsController.TriggerPromptInteracted()
					end
				end)
			end
		end
		table.insert(t3[v42].buttons, t)
		local Button = t.Button
		if Button and Button.Parent then
			Button.Visible = false
			local MoveFrame_2 = t.MoveFrame
			local OriginalPos = t.OriginalPos
			local MoveTime = t.MoveTime
			local MoveOnLoad = t.MoveOnLoad
			local AnimateFrame_2 = t.AnimateFrame
			CancelAllIdleTweens()
			if MoveFrame_2 and (OriginalPos and (t.TargetPos and t.IsShown)) then
				t.IsShown = false
				tweenGuiPosition(MoveFrame_2, OriginalPos, MoveTime)
			end
		end
		refreshPlacementStatus(v42, false)
		v1.MouseButton1Down:Connect(function() --[[ Line: 628 | Upvalues: v3 (ref), v2 (ref), CancelAllIdleTweens (ref), v4 (ref), v5 (ref), v42 (copy), t3 (ref), t (copy), tweenGuiPosition (ref), Telemetry (ref), v22 (copy), AdRewardsController (ref) ]]
			local v1, v23, v32
			if v3 then
				local v43, v52, v6 = v3()
				v1 = v43
				v23 = v52
				v32 = v6
			else
				warn("WatchAdButtonController: GetAdState not set")
				v1 = false
				v23 = false
				v32 = false
			end
			if v1 then
				if v23 then
					if not v32 and v2 then
						CancelAllIdleTweens()
						local v7 = v4 and v4() or nil
						v5 = {
							placementKey = v42,
							config = t3[v42].Config,
							regionTag = v7
						}
						local v8 = t
						local Button = v8.Button
						if Button and Button.Parent then
							Button.Visible = false
							local MoveFrame = v8.MoveFrame
							local OriginalPos = v8.OriginalPos
							local MoveTime = v8.MoveTime
							local MoveOnLoad = v8.MoveOnLoad
							local AnimateFrame = v8.AnimateFrame
							CancelAllIdleTweens()
							if MoveFrame and (OriginalPos and (v8.TargetPos and v8.IsShown)) then
								v8.IsShown = false
								tweenGuiPosition(MoveFrame, OriginalPos, MoveTime)
							end
						end
						Telemetry.send("StartAd_" .. (t3[v42].Config.PromptName or v42))
						if v7 then
							Telemetry.send("StartAdRegion_" .. v7)
						end
						if v2(v22) and (AdRewardsController and AdRewardsController.TriggerPromptInteracted) then
							AdRewardsController.TriggerPromptInteracted()
						end
					elseif not v32 then
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
		warn("WatchAdToClaim parent is not a GuiButton:", p1:GetFullName())
	end
end
local function findclaimbuttons() --[[ Line: 684 | Upvalues: t2 (copy), t3 (ref), t4 (ref), t5 (ref), v1 (ref), connectclaimbutton (copy), evaluatePlacementVisibility (copy) ]]
	table.clear(t2)
	t3 = {}
	t4 = {}
	t5 = {}
	if v1 then
		for k, v in pairs((v1:GetDescendants())) do
			if v.Name == "WatchAdToClaim" and v:IsA("Configuration") then
				table.insert(t2, v)
			end
		end
		for k, v in pairs(t2) do
			connectclaimbutton(v)
		end
		for k, v in pairs(t3) do
			evaluatePlacementVisibility(k)
		end
	else
		warn("WatchAdButtonController: PlayerGui nil in findclaimbuttons")
	end
end
function t.Init(p1) --[[ Line: 711 | Upvalues: v1 (ref), v2 (ref), v3 (ref), v4 (ref), findclaimbuttons (copy) ]]
	v1 = p1.PlayerGui
	v2 = p1.PlayAd
	v3 = p1.GetAdState
	v4 = p1.GetCurrentRegionTag
	local v12, v22 = pcall(function() --[[ Line: 722 | Upvalues: findclaimbuttons (ref) ]]
		findclaimbuttons()
	end)
	if not v12 then
		warn("WatchAdButtonController: findclaimbuttons failed:", v22)
	end
end
function t.EvaluateAllPlacementButtons() --[[ Line: 731 | Upvalues: t3 (ref), evaluatePlacementVisibility (copy) ]]
	for k, v in pairs(t3) do
		evaluatePlacementVisibility(k)
	end
end
function t.OnAdCompleted(p1, p2) --[[ Line: 739 | Upvalues: v5 (ref), t4 (ref), refreshPlacementStatus (copy), Telemetry (copy), evaluatePlacementVisibility (copy) ]]
	local v1 = v5
	v5 = nil
	if v1 then
		local placementKey = v1.placementKey
		local config = v1.config
		local regionTag = v1.regionTag
		if placementKey and config then
			local v2 = config.PromptName or placementKey
			local v3 = config.ClaimString or "UnknownReward"
			local v4 = os.time()
			local v52 = t4[placementKey]
			if v52 then
				v52.claimCount = v52.claimCount or 0
			else
				v52 = {
					claimCount = 0,
					firstClaimAt = nil,
					lastClaimAt = nil,
					serverUsed = nil,
					serverLimit = nil
				}
			end
			if p1 and p2 == Enum.ShowAdResult.ShowCompleted then
				v52.claimCount = v52.claimCount + 1
				v52.firstClaimAt = v52.firstClaimAt or v4
				v52.lastClaimAt = v4
				t4[placementKey] = v52
				task.spawn(function() --[[ Line: 781 | Upvalues: refreshPlacementStatus (ref), placementKey (copy) ]]
					refreshPlacementStatus(placementKey, true)
				end)
				Telemetry.send("AdWatchComplete_" .. v2)
				if regionTag then
					Telemetry.send("AdWatchComplete_" .. regionTag)
					Telemetry.send("RewardGrant_" .. v3 .. "_" .. regionTag)
				else
					Telemetry.send("RewardGrant_" .. v3)
				end
				evaluatePlacementVisibility(placementKey)
				local v6 = tonumber(config.Cooldown) or 0
				if v6 > 0 then
					task.delay(v6, function() --[[ Line: 798 | Upvalues: evaluatePlacementVisibility (ref), placementKey (copy) ]]
						evaluatePlacementVisibility(placementKey)
					end)
				end
			else
				Telemetry.send("AdWatchIncomplete_" .. v2)
				if regionTag then
					Telemetry.send("AdWatchIncomplete_" .. regionTag)
				end
			end
		end
	end
end
return t