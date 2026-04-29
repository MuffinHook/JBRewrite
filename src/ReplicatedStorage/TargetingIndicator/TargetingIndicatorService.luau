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
local targetingMaids = {}
return {
	init = function()
		local targetingCache = {}
		local function getClosestPlayer(player)
			if player and (player.Character and player.Character.PrimaryPart) then
				local playerPosition = player.Character.PrimaryPart.Position
				local closestPlayer = nil
				local closestDistance = nil
				local closestHorizontalDistance = nil
				local closestVerticalDistance = nil
				for _, otherPlayer in Players:GetChildren() do
					if otherPlayer ~= player then
						local Character = otherPlayer.Character
						if Character and (Character.PrimaryPart ~= nil and (otherPlayer.TeamValue.Value == Settings.Team.Prisoner and not Character:GetAttribute("HasHandcuffs"))) then
							local offset = Character.PrimaryPart.Position - playerPosition
							local Magnitude = offset.Magnitude
							local Magnitude_2 = Vector3.new(offset.X, 0, offset.Z).Magnitude
							local Y = offset.Y
							if not closestDistance or Magnitude < closestDistance then
								closestDistance = Magnitude
								closestPlayer = otherPlayer
								closestHorizontalDistance = Magnitude_2
								closestVerticalDistance = Y
							end
						end
					end
				end
				return closestPlayer, closestDistance, closestHorizontalDistance, closestVerticalDistance
			else
				return nil, nil, nil, nil
			end
		end
		InventoryItemSystem.onInventoryItemUnequipped:Connect(function(itemData)
			local owner = InventoryItemUtils.getOwner(itemData.obj)
			if owner then
				local maidInstance = targetingMaids[owner.UserId]
				if maidInstance then
					maidInstance:Destroy()
				end
				return true
			else
				return false
			end
		end)
		InventoryItemSystem.onInventoryItemEquipped:Connect(function(itemData)
			local obj = itemData.obj
			local itemName = InventoryItemUtils.getName(obj)
			local taserRange = nil
			local handcuffsArrestDistance = nil
			local handcuffsArrestRangeDouble = nil
			if itemName == "Taser" then
				taserRange = Taser.Range
			elseif itemName == "Handcuffs" then
				handcuffsArrestDistance = Handcuffs.ArrestDistance
				handcuffsArrestRangeDouble = Handcuffs.ArrestDistance * 2
			end
			local itemOwner = InventoryItemUtils.getOwner(obj)
			if itemOwner then
				local existingMaid = targetingMaids[itemOwner.UserId]
				if existingMaid then
					existingMaid:Destroy()
				end
				local maidInstance = Maid.new()
				targetingMaids[itemOwner.UserId] = maidInstance
				maidInstance:GiveTask(RunService.Heartbeat:Connect(function()
					local targetPlayer, targetDistance, targetHorizontalDistance, targetVerticalDistance = getClosestPlayer(itemOwner)
					local cacheEntry = targetingCache[itemOwner.UserId] or {}
					targetingCache[itemOwner.UserId] = cacheEntry
					local Player = cacheEntry.Player
					local ItemName = cacheEntry.ItemName
					local Maid_2 = cacheEntry.Maid
					local isInRange = if taserRange == nil then if handcuffsArrestDistance == nil or targetHorizontalDistance == nil then false else targetHorizontalDistance <= handcuffsArrestDistance and if handcuffsArrestRangeDouble == nil or targetVerticalDistance == nil then false else targetVerticalDistance <= handcuffsArrestRangeDouble elseif targetDistance == nil then false else targetDistance <= taserRange
					if targetPlayer and isInRange then
						local itemOwnerPosition = itemOwner.Character.PrimaryPart.Position
						local directionVector = targetPlayer.Character.PrimaryPart.Position - itemOwnerPosition
						local Magnitude = directionVector.Magnitude
						if Magnitude == 0 then
							maidInstance.targetingMaid = nil
							return
						end
						local Unit = directionVector.Unit
						if itemName == "Taser" and itemOwner.Character.PrimaryPart.CFrame.LookVector:Dot(Unit) < 0.9 then
							maidInstance.targetingMaid = nil
							return
						end
						local raycastParams = RaycastParams.new()
						raycastParams.FilterDescendantsInstances = { itemOwner.Character }
						local raycastResult = Raycast.collidable(itemOwnerPosition, Unit, Magnitude, raycastParams)
						if raycastResult and raycastResult.Instance:IsDescendantOf(targetPlayer.Character) then
							if targetPlayer and (isInRange and (Player ~= targetPlayer or ItemName ~= itemName)) then
								local targetingMaidInstance = Maid.new()
								maidInstance.targetingMaid = targetingMaidInstance
								local beamPart = nil
								local flashPart = nil
								if itemName == "Taser" then
									beamPart = TargetingIndicators:FindFirstChild("TaserBeam")
									flashPart = TargetingIndicators:FindFirstChild("TaserFlash")
								elseif itemName == "Handcuffs" then
									beamPart = TargetingIndicators:FindFirstChild("HandcuffsBeam")
									flashPart = TargetingIndicators:FindFirstChild("HandcuffsFlash")
								else
									error("Unknown item")
								end
								targetingCache[itemOwner.UserId] = {
									Player = targetPlayer,
									ItemName = itemName,
									Maid = targetingMaidInstance
								}
								targetingMaidInstance:GiveTask(function()
									targetingCache[itemOwner.UserId] = nil
								end)
								local clonedBeam = beamPart:Clone()
								clonedBeam:FindFirstChild("Targeter").CanCollide = false
								clonedBeam:FindFirstChild("Targeter").CanQuery = false
								local clonedFlash = flashPart:Clone()
								clonedFlash.CanCollide = false
								clonedFlash.CanQuery = false
								clonedBeam.Parent = workspace
								clonedFlash.Parent = workspace
								targetingMaidInstance:GiveTask(clonedBeam)
								targetingMaidInstance:GiveTask(clonedFlash)
								local startTime = os.clock()
								targetingMaidInstance:GiveTask(RunService.Heartbeat:Connect(function()
									local Character = targetPlayer.Character
									local Character_2 = itemOwner.Character
									if Character and Character_2 then
										local targetUpperTorso, ownerUpperTorso, targetPosition, heightOffset, adjustedPosition, beamTargeter, attachmentStart, attachmentEnd, rotationAngle, elapsedTime, animationValue, transparency
										if itemName == "Taser" then
											if TagUtils.isPointInTag(Character_2.PrimaryPart.Position, "NoTase") then
												maidInstance.targetingMaid = nil
												return
											end
											targetUpperTorso = Character:FindFirstChild("UpperTorso")
											ownerUpperTorso = Character_2:FindFirstChild("UpperTorso")
											if targetUpperTorso and ownerUpperTorso then
												targetPosition = Character.PrimaryPart.Position
												heightOffset = Character.Humanoid.HipHeight + Character.PrimaryPart.Size.Y / 2
												adjustedPosition = targetPosition - Vector3.new(0, heightOffset, 0)
												beamTargeter = clonedBeam:FindFirstChild("Targeter")
												attachmentStart = beamTargeter:FindFirstChild("Attachment")
												attachmentEnd = beamTargeter:FindFirstChild("AttachmentEnd")
												attachmentStart.WorldPosition = ownerUpperTorso.Position
												attachmentEnd.WorldPosition = targetUpperTorso.Position
												rotationAngle = math.tau * (os.clock() % 2) / 2
												clonedFlash.CFrame = CFrame.new(adjustedPosition) * CFrame.Angles(0, rotationAngle, 0)
												elapsedTime = os.clock() - startTime
												animationValue = 1 - (math.cos(elapsedTime) + 1) / 2
												transparency = math.min(0.9, animationValue)
												clonedFlash.Decal.Transparency = transparency
											end
										else
											if itemName == "Handcuffs" and TagUtils.isPointInTag(Character_2.PrimaryPart.Position, "NoArrest") then
												maidInstance.targetingMaid = nil
												return
											end
											targetUpperTorso = Character:FindFirstChild("UpperTorso")
											ownerUpperTorso = Character_2:FindFirstChild("UpperTorso")
											if targetUpperTorso and ownerUpperTorso then
												targetPosition = Character.PrimaryPart.Position
												heightOffset = Character.Humanoid.HipHeight + Character.PrimaryPart.Size.Y / 2
												adjustedPosition = targetPosition - Vector3.new(0, heightOffset, 0)
												beamTargeter = clonedBeam:FindFirstChild("Targeter")
												attachmentStart = beamTargeter:FindFirstChild("Attachment")
												attachmentEnd = beamTargeter:FindFirstChild("AttachmentEnd")
												attachmentStart.WorldPosition = ownerUpperTorso.Position
												attachmentEnd.WorldPosition = targetUpperTorso.Position
												rotationAngle = math.tau * (os.clock() % 2) / 2
												clonedFlash.CFrame = CFrame.new(adjustedPosition) * CFrame.Angles(0, rotationAngle, 0)
												elapsedTime = os.clock() - startTime
												animationValue = 1 - (math.cos(elapsedTime) + 1) / 2
												transparency = math.min(0.9, animationValue)
												clonedFlash.Decal.Transparency = transparency
											end
										end
									end
								end))
							end
						else
							maidInstance.targetingMaid = nil
						end
					else
						maidInstance.targetingMaid = nil
					end
				end))
			end
		end)
	end
}
