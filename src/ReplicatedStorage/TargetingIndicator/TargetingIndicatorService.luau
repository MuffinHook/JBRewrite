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
				local var3 = nil
				local var4 = nil
				for var5, var6 in Players:GetChildren() do
					if var6 ~= p1 then
						local Character = var6.Character
						if Character and (Character.PrimaryPart ~= nil and (var6.TeamValue.Value == Settings.Team.Prisoner and not Character:GetAttribute("HasHandcuffs"))) then
							local var7 = Character.PrimaryPart.Position - Position
							local Magnitude = var7.Magnitude
							local Magnitude_2 = Vector3.new(var7.X, 0, var7.Z).Magnitude
							local Y = var7.Y
							if not v1 or Magnitude < v1 then
								v1 = Magnitude
								v2 = var6
								var3 = Magnitude_2
								var4 = Y
							end
						end
					end
				end
				return v2, v1, var3, var4
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
			local var3 = nil
			local var4 = nil
			if v1 == "Taser" then
				v2 = Taser.Range
			elseif v1 == "Handcuffs" then
				var3 = Handcuffs.ArrestDistance
				var4 = Handcuffs.ArrestDistance * 2
			end
			local var5 = InventoryItemUtils.getOwner(obj)
			if var5 then
				local var6 = t[var5.UserId]
				if var6 then
					var6:Destroy()
				end
				local var7 = Maid.new()
				t[var5.UserId] = var7
				var7:GiveTask(RunService.Heartbeat:Connect(function()
					local v12, v22, v32, v42 = getClosestPlayer(var5)
					local table52 = t2[var5.UserId] or {}
					t2[var5.UserId] = table52
					local Player = table52.Player
					local ItemName = table52.ItemName
					local Maid_2 = table52.Maid
					local var8 = if v2 == nil then if var3 == nil or v32 == nil then false else v32 <= var3 and if var4 == nil or v42 == nil then false else v42 <= var4 elseif v22 == nil then false else v22 <= v2
					if v12 and var8 then
						local Position = var5.Character.PrimaryPart.Position
						local var9 = v12.Character.PrimaryPart.Position - Position
						local Magnitude = var9.Magnitude
						if Magnitude == 0 then
							var7.targetingMaid = nil
							return
						end
						local Unit = var9.Unit
						if v1 == "Taser" and var5.Character.PrimaryPart.CFrame.LookVector:Dot(Unit) < 0.9 then
							var7.targetingMaid = nil
							return
						end
						local instance10 = RaycastParams.new()
						instance10.FilterDescendantsInstances = { var5.Character }
						local var11 = Raycast.collidable(Position, Unit, Magnitude, instance10)
						if var11 and var11.Instance:IsDescendantOf(v12.Character) then
							if v12 and (var8 and (Player ~= v12 or ItemName ~= v1)) then
								local instance122 = Maid.new()
								var7.targetingMaid = instance122
								local var13 = nil
								local var14 = nil
								if v1 == "Taser" then
									var13 = TargetingIndicators:FindFirstChild("TaserBeam")
									var14 = TargetingIndicators:FindFirstChild("TaserFlash")
								elseif v1 == "Handcuffs" then
									var13 = TargetingIndicators:FindFirstChild("HandcuffsBeam")
									var14 = TargetingIndicators:FindFirstChild("HandcuffsFlash")
								else
									error("Unknown item")
								end
								t2[var5.UserId] = {
									Player = v12,
									ItemName = v1,
									Maid = instance122
								}
								instance122:GiveTask(function()
									t2[var5.UserId] = nil
								end)
								local var15 = var13:Clone()
								var15:FindFirstChild("Targeter").CanCollide = false
								var15:FindFirstChild("Targeter").CanQuery = false
								local var16 = var14:Clone()
								var16.CanCollide = false
								var16.CanQuery = false
								var15.Parent = workspace
								var16.Parent = workspace
								instance122:GiveTask(var15)
								instance122:GiveTask(var16)
								local var17 = os.clock()
								instance122:GiveTask(RunService.Heartbeat:Connect(function()
									local Character = v12.Character
									local Character_2 = var5.Character
									if Character and Character_2 then
										local var13, v2, var3, var4, table52, var6, v72, var8, var9, instance10, var11, instance122
										if v1 == "Taser" then
											if TagUtils.isPointInTag(Character_2.PrimaryPart.Position, "NoTase") then
												var7.targetingMaid = nil
												return
											end
											var13 = Character:FindFirstChild("UpperTorso")
											v2 = Character_2:FindFirstChild("UpperTorso")
											if var13 and v2 then
												var3 = Character.PrimaryPart.Position
												var4 = Character.Humanoid.HipHeight + Character.PrimaryPart.Size.Y / 2
												table52 = var3 - Vector3.new(0, var4, 0)
												var6 = var15:FindFirstChild("Targeter")
												v72 = var6:FindFirstChild("Attachment")
												var8 = var6:FindFirstChild("AttachmentEnd")
												v72.WorldPosition = v2.Position
												var8.WorldPosition = var13.Position
												var9 = 6.283185307179586 * (os.clock() % 2) / 2
												var16.CFrame = CFrame.new(table52) * CFrame.Angles(0, var9, 0)
												instance10 = os.clock() - var17
												var11 = 1 - (math.cos(instance10) + 1) / 2
												instance122 = math.min(0.9, var11)
												var16.Decal.Transparency = instance122
											end
										else
											if v1 == "Handcuffs" and TagUtils.isPointInTag(Character_2.PrimaryPart.Position, "NoArrest") then
												var7.targetingMaid = nil
												return
											end
											var13 = Character:FindFirstChild("UpperTorso")
											v2 = Character_2:FindFirstChild("UpperTorso")
											if var13 and v2 then
												var3 = Character.PrimaryPart.Position
												var4 = Character.Humanoid.HipHeight + Character.PrimaryPart.Size.Y / 2
												table52 = var3 - Vector3.new(0, var4, 0)
												var6 = var15:FindFirstChild("Targeter")
												v72 = var6:FindFirstChild("Attachment")
												var8 = var6:FindFirstChild("AttachmentEnd")
												v72.WorldPosition = v2.Position
												var8.WorldPosition = var13.Position
												var9 = 6.283185307179586 * (os.clock() % 2) / 2
												var16.CFrame = CFrame.new(table52) * CFrame.Angles(0, var9, 0)
												instance10 = os.clock() - var17
												var11 = 1 - (math.cos(instance10) + 1) / 2
												instance122 = math.min(0.9, var11)
												var16.Decal.Transparency = instance122
											end
										end
									end
								end))
							end
						else
							var7.targetingMaid = nil
						end
					else
						var7.targetingMaid = nil
					end
				end))
			end
		end)
	end
}
