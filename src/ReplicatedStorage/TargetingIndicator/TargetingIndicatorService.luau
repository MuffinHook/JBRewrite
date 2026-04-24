-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.TargetingIndicator.TargetingIndicatorConsts)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Maid = require(ReplicatedStorage.Std.Maid)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local Settings = require(ReplicatedStorage.Resource.Settings)
local TagUtils = require(ReplicatedStorage.Tag.TagUtils)
local TargetingIndicators = ReplicatedStorage.Resource:FindFirstChild("TargetingIndicators")
local Taser = require(ReplicatedStorage.Game.ItemConfig.Taser)
local Handcuffs = require(ReplicatedStorage.Game.ItemConfig.Handcuffs)
local t = {}
return {
	init = function()
		local t2 = {}
		local function getClosestPlayer(p1)
			if p1 and (p1.Character and p1.Character.PrimaryPart) then
				local Position = p1.Character.PrimaryPart.Position
				local v1 = nil
				local v2 = nil
				local v3 = nil
				local v4 = nil
				for v5, v6 in Players:GetChildren() do
					if v6 ~= p1 then
						local Character = v6.Character
						if Character and (Character.PrimaryPart ~= nil and (v6.TeamValue.Value == Settings.Team.Prisoner and not Character:GetAttribute("HasHandcuffs"))) then
							local v7 = Character.PrimaryPart.Position - Position
							local Magnitude = v7.Magnitude
							local Magnitude_2 = Vector3.new(v7.X, 0, v7.Z).Magnitude
							local Y = v7.Y
							if not v1 or Magnitude < v1 then
								v1 = Magnitude
								v2 = v6
								v3 = Magnitude_2
								v4 = Y
							end
						end
					end
				end
				return v2, v1, v3, v4
			else
				return nil, nil, nil, nil
			end
		end
		InventoryItemSystem.onInventoryItemUnequipped:Connect(function(p1)
			local v1 = InventoryItemUtils.getOwner(p1.obj)
			if v1 then
				local v2 = t[v1.UserId]
				if v2 then
					v2:Destroy()
				end
				return true
			else
				return false
			end
		end)
		InventoryItemSystem.onInventoryItemEquipped:Connect(function(p1)
			local obj = p1.obj
			local v1 = InventoryItemUtils.getName(obj)
			local v2 = nil
			local v3 = nil
			local v4 = nil
			if v1 == "Taser" then
				v2 = Taser.Range
			elseif v1 == "Handcuffs" then
				v3 = Handcuffs.ArrestDistance
				v4 = Handcuffs.ArrestDistance * 2
			end
			local v5 = InventoryItemUtils.getOwner(obj)
			if v5 then
				local v6 = t[v5.UserId]
				if v6 then
					v6:Destroy()
				end
				local v7 = Maid.new()
				t[v5.UserId] = v7
				v7:GiveTask(RunService.Heartbeat:Connect(function()
					local v12, v22, v32, v42 = getClosestPlayer(v5)
					local v52 = t2[v5.UserId] or {}
					t2[v5.UserId] = v52
					local Player = v52.Player
					local ItemName = v52.ItemName
					local Maid_2 = v52.Maid
					local v8 = if v2 == nil then if v3 == nil or v32 == nil then false else v32 <= v3 and if v4 == nil or v42 == nil then false else v42 <= v4 elseif v22 == nil then false else v22 <= v2
					if v12 and v8 then
						local Position = v5.Character.PrimaryPart.Position
						local v9 = v12.Character.PrimaryPart.Position - Position
						local Magnitude = v9.Magnitude
						if Magnitude == 0 then
							v7.targetingMaid = nil
							return
						end
						local Unit = v9.Unit
						if v1 == "Taser" and v5.Character.PrimaryPart.CFrame.LookVector:Dot(Unit) < 0.9 then
							v7.targetingMaid = nil
							return
						end
						local v10 = RaycastParams.new()
						v10.FilterDescendantsInstances = { v5.Character }
						local v11 = Raycast.collidable(Position, Unit, Magnitude, v10)
						if v11 and v11.Instance:IsDescendantOf(v12.Character) then
							if v12 and (v8 and (Player ~= v12 or ItemName ~= v1)) then
								local v122 = Maid.new()
								v7.targetingMaid = v122
								local v13 = nil
								local v14 = nil
								if v1 == "Taser" then
									v13 = TargetingIndicators:FindFirstChild("TaserBeam")
									v14 = TargetingIndicators:FindFirstChild("TaserFlash")
								elseif v1 == "Handcuffs" then
									v13 = TargetingIndicators:FindFirstChild("HandcuffsBeam")
									v14 = TargetingIndicators:FindFirstChild("HandcuffsFlash")
								else
									error("Unknown item")
								end
								t2[v5.UserId] = {
									Player = v12,
									ItemName = v1,
									Maid = v122
								}
								v122:GiveTask(function()
									t2[v5.UserId] = nil
								end)
								local v15 = v13:Clone()
								v15:FindFirstChild("Targeter").CanCollide = false
								v15:FindFirstChild("Targeter").CanQuery = false
								local v16 = v14:Clone()
								v16.CanCollide = false
								v16.CanQuery = false
								v15.Parent = workspace
								v16.Parent = workspace
								v122:GiveTask(v15)
								v122:GiveTask(v16)
								local v17 = os.clock()
								v122:GiveTask(RunService.Heartbeat:Connect(function()
									local Character = v12.Character
									local Character_2 = v5.Character
									if Character and Character_2 then
										local v13, v2, v3, v4, v52, v6, v72, v8, v9, v10, v11, v122
										if v1 == "Taser" then
											if TagUtils.isPointInTag(Character_2.PrimaryPart.Position, "NoTase") then
												v7.targetingMaid = nil
												return
											end
											v13 = Character:FindFirstChild("UpperTorso")
											v2 = Character_2:FindFirstChild("UpperTorso")
											if v13 and v2 then
												v3 = Character.PrimaryPart.Position
												v4 = Character.Humanoid.HipHeight + Character.PrimaryPart.Size.Y / 2
												v52 = v3 - Vector3.new(0, v4, 0)
												v6 = v15:FindFirstChild("Targeter")
												v72 = v6:FindFirstChild("Attachment")
												v8 = v6:FindFirstChild("AttachmentEnd")
												v72.WorldPosition = v2.Position
												v8.WorldPosition = v13.Position
												v9 = 6.283185307179586 * (os.clock() % 2) / 2
												v16.CFrame = CFrame.new(v52) * CFrame.Angles(0, v9, 0)
												v10 = os.clock() - v17
												v11 = 1 - (math.cos(v10) + 1) / 2
												v122 = math.min(0.9, v11)
												v16.Decal.Transparency = v122
											end
										else
											if v1 == "Handcuffs" and TagUtils.isPointInTag(Character_2.PrimaryPart.Position, "NoArrest") then
												v7.targetingMaid = nil
												return
											end
											v13 = Character:FindFirstChild("UpperTorso")
											v2 = Character_2:FindFirstChild("UpperTorso")
											if v13 and v2 then
												v3 = Character.PrimaryPart.Position
												v4 = Character.Humanoid.HipHeight + Character.PrimaryPart.Size.Y / 2
												v52 = v3 - Vector3.new(0, v4, 0)
												v6 = v15:FindFirstChild("Targeter")
												v72 = v6:FindFirstChild("Attachment")
												v8 = v6:FindFirstChild("AttachmentEnd")
												v72.WorldPosition = v2.Position
												v8.WorldPosition = v13.Position
												v9 = 6.283185307179586 * (os.clock() % 2) / 2
												v16.CFrame = CFrame.new(v52) * CFrame.Angles(0, v9, 0)
												v10 = os.clock() - v17
												v11 = 1 - (math.cos(v10) + 1) / 2
												v122 = math.min(0.9, v11)
												v16.Decal.Transparency = v122
											end
										end
									end
								end))
							end
						else
							v7.targetingMaid = nil
						end
					else
						v7.targetingMaid = nil
					end
				end))
			end
		end)
	end
}
