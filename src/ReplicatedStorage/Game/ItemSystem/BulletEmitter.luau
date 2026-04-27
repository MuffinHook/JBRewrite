game:GetService("Debris")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CombatUtils = require(ReplicatedStorage.Combat.CombatUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local GuardNPCBinder = require(ReplicatedStorage.GuardNPC.GuardNPCBinder)
local Audio = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Module.Time)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local ForcefieldService = require(ReplicatedStorage.Forcefield.ForcefieldService)
require(ReplicatedStorage.Std.Raycast)
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local Math = require(ReplicatedStorage.Module.Math)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local SoundIdMap = {
	bullet_flyby_01 = 2121003369,
	bullet_flyby_04 = 2121003636,
	bullet_impact_body_thump_01 = 2121003873,
	bullet_impact_bass = 2837091387
}
local function IntersectRaySphereF(rayOriginX, rayOriginY, rayOriginZ, rayDirectionX, rayDirectionY, rayDirectionZ, rayLength, sphereCenterX, sphereCenterY, sphereCenterZ, sphereRadius)
	local coefficientA = rayLength * rayLength * rayDirectionX * rayDirectionX + rayLength * rayLength * rayDirectionY * rayDirectionY + rayLength * rayLength * rayDirectionZ * rayDirectionZ
	local coefficientB = 2 * (rayLength * rayDirectionX * (rayOriginX - sphereCenterX) + rayLength * rayDirectionY * (rayOriginY - sphereCenterY) + rayLength * rayDirectionZ * (rayOriginZ - sphereCenterZ))
	local coefficientC = coefficientB * coefficientB - 4 * coefficientA * (sphereCenterX * sphereCenterX + sphereCenterY * sphereCenterY + sphereCenterZ * sphereCenterZ + rayOriginX * rayOriginX + rayOriginY * rayOriginY + rayOriginZ * rayOriginZ - 2 * (sphereCenterX * rayOriginX + sphereCenterY * rayOriginY + sphereCenterZ * rayOriginZ) - sphereRadius * sphereRadius)
	if math.abs(coefficientA) < 0.001 or coefficientC < 0 then
		return nil, nil
	else
		local discriminantSqrt = coefficientC ^ 0.5
		local intersectionT1 = (-coefficientB - discriminantSqrt) / (2 * coefficientA)
		local intersectionT2 = (-coefficientB + discriminantSqrt) / (2 * coefficientA)
		if coefficientA * (1 - intersectionT1) * (intersectionT2 - intersectionT1) < 0 or coefficientA * intersectionT2 * (intersectionT2 - intersectionT1) < 0 then
			return nil, nil
		else
			return intersectionT1, intersectionT2
		end
	end
end
local function IntersectRaySphere(rayOrigin, rayDirection, rayLength, sphereCenter, sphereRadius)
	return IntersectRaySphereF(rayOrigin.x, rayOrigin.y, rayOrigin.z, rayDirection.x, rayDirection.y, rayDirection.z, rayLength, sphereCenter.x, sphereCenter.y, sphereCenter.z, sphereRadius)
end
local Part = Instance.new("Part")
Part.Anchored = true
Part.CFrame = CFrame.new(0, 0, 0)
Part.CanCollide = false
Part.Transparency = 1
Part.Parent = workspace
local BulletVisualsFolder = Instance.new("Folder")
BulletVisualsFolder.Parent = workspace
local BulletEmitter = {}
BulletEmitter.__index = BulletEmitter
function BulletEmitter.new(isLocalEmitter)
	assert(isLocalEmitter ~= nil)
	local instance = {}
	setmetatable(instance, BulletEmitter)
	instance.Maid = Maid.new()
	local onLocalHitPlayerSignal = Signal.new()
	instance.Maid:GiveTask(onLocalHitPlayerSignal)
	local onHitSurfaceSignal = Signal.new()
	instance.Maid:GiveTask(onHitSurfaceSignal)
	local onQueueEmptiedSignal = Signal.new()
	instance.Maid:GiveTask(onQueueEmptiedSignal)
	local onShieldDamageSignal = Signal.new()
	instance.Maid:GiveTask(onShieldDamageSignal)
	instance.BulletWhizEnabled = true
	instance.Local = isLocalEmitter
	instance.IgnoreList = {}
	instance.IgnoreLocalPlayer = true
	instance.OnLocalHitPlayer = onLocalHitPlayerSignal
	instance.OnHitSurface = onHitSurfaceSignal
	instance.OnQueueEmptied = onQueueEmptiedSignal
	instance.OnShieldDamage = onShieldDamageSignal
	instance.Bullets = {}
	instance.LastUpdate = nil
	instance.LastPlayedWhizSound = nil
	instance.GravityVector = nil
	instance.LifeSpan = nil
	instance.Color = Color3.fromRGB(255, 235, 141)
	instance._mapLastHitSurface = {}
	instance._customCollidableFunc = instance:_buildCustomCollidableFunc()
	return instance
end
function BulletEmitter.Emit(emitter, position, direction, speed)
	local LineHandleAdornment = Instance.new("LineHandleAdornment")
	LineHandleAdornment.Adornee = Part
	LineHandleAdornment.AdornCullingMode = Enum.AdornCullingMode.Automatic
	LineHandleAdornment.Transparency = 0
	LineHandleAdornment.Color3 = emitter.Color
	LineHandleAdornment.Thickness = 2
	LineHandleAdornment.SizeRelativeOffset = Vector3.new(0, 0, 0)
	LineHandleAdornment.Length = 0
	LineHandleAdornment.CFrame = CFrame.new()
	LineHandleAdornment.Parent = BulletVisualsFolder
	local bulletData = {
		position,
		direction,
		speed,
		LineHandleAdornment,
		emitter.LifeSpan,
		position
	}
	local ignoreListCopy = {}
	for i, ignoredPart in ipairs(emitter.IgnoreList) do
		ignoreListCopy[#ignoreListCopy + 1] = ignoredPart
	end
	bulletData[7] = ignoreListCopy
	emitter.Bullets[#emitter.Bullets + 1] = bulletData
end
local WhizSoundIds = { SoundIdMap.bullet_flyby_01, SoundIdMap.bullet_flyby_04 }
local WhizPartPool = {}
local function getWhizPart()
	local pooledPart = table.remove(WhizPartPool)
	if pooledPart then
		return pooledPart
	else
		local Part = Instance.new("Part")
		Part.Transparency = 1
		Part.Anchored = true
		Part.CanCollide = false
		Part.Size = Vector3.new(1, 1, 1)
		return Part
	end
end
local function returnWhizPart(whizPart)
	whizPart.Parent = nil
	if #WhizPartPool < 8 then
		WhizPartPool[#WhizPartPool + 1] = whizPart
	else
		whizPart:Destroy()
	end
end
function BulletEmitter.PlayWhiz(emitter, position, distance)
	local pooledPart = table.remove(WhizPartPool)
	local whizPart
	if pooledPart then
		whizPart = pooledPart
	else
		local Part = Instance.new("Part")
		Part.Transparency = 1
		Part.Anchored = true
		Part.CanCollide = false
		Part.Size = Vector3.new(1, 1, 1)
		whizPart = Part
	end
	whizPart.Position = position
	whizPart.Parent = workspace
	Audio.ObjectLocal(whizPart, WhizSoundIds[math.random(1, #WhizSoundIds)], {
		TimePosition = 0.3,
		Volume = 0.6 * (1 - distance / 10),
		Pitch = 1 + math.random() * 0.1 - 0.05
	})
	task.delay(3, returnWhizPart, whizPart)
end
function BulletEmitter.CheckWhiz(emitter, bulletData)
	local currentTime = tick()
	local playerRootPart = PlayerUtils.getRootPart(LocalPlayer)
	if playerRootPart ~= nil then
		local bulletOrigin = bulletData[1]
		local distanceToPlayer = (bulletOrigin - playerRootPart.Position).Magnitude
		if distanceToPlayer < 10 and (bulletData[3] > 100 and currentTime - (emitter.LastPlayedWhizSound or 0) > 0.1) then
			emitter:PlayWhiz(bulletOrigin, distanceToPlayer)
			emitter.LastPlayedWhizSound = currentTime
		end
	end
end
function BulletEmitter._buildCustomCollidableFunc(emitter)
	return function(part)
		if part:GetAttribute("InvisibleToBullets") == true then
			return false
		else
			if not part.CanCollide and emitter._listRootPart then
				for i, rootPart in ipairs(emitter._listRootPart) do
					local _ = part:IsDescendantOf(rootPart.Parent)
				end
			end
			return true
		end
	end
end
local attachmentNameSet = {
	HairAttachment = true,
	HatAttachment = true,
	FaceFrontAttachment = true,
	FaceCenterAttachment = true
}
function BulletEmitter.Update(emitter)
	debug.profilebegin("BulletEmitter Update")
	local currentTime = tick()
	local deltaTime = currentTime - (emitter.LastUpdate or currentTime)
	emitter.LastUpdate = currentTime
	local targetCharacterRootParts = nil
	local isLocalCollisionEnabled = emitter.Local or emitter.SimulateLocal
	if isLocalCollisionEnabled then
		targetCharacterRootParts = {}
		local rootPartSet = {}
		local localPlayerPrimaryPart = if LocalPlayer.Character then LocalPlayer.Character.PrimaryPart else nil
		for _, humanoid in CollectionService:GetTagged("Humanoid") do
			local shouldIncludeRootPart
			if humanoid:IsDescendantOf(workspace) then
				local RootPart = humanoid.RootPart
				if RootPart and not rootPartSet[RootPart] then
					rootPartSet[RootPart] = true
					shouldIncludeRootPart = not emitter.IgnoreLocalPlayer or RootPart ~= localPlayerPrimaryPart
					if emitter.IgnoreGuards and GuardNPCBinder:Get(RootPart.Parent) then
						shouldIncludeRootPart = false
					end
					if shouldIncludeRootPart then
						targetCharacterRootParts[#targetCharacterRootParts + 1] = RootPart
					end
				end
			end
		end
		emitter._listRootPart = targetCharacterRootParts
	end
	local shieldBlockChance = emitter.ShieldBlockPct or 1
	local bulletCount = #emitter.Bullets
	local LifeSpan = emitter.LifeSpan
	local ListShields = ForcefieldService.ListShields
	local shieldListLength = #ListShields
	if BulletEmitter._militaryForcefield and (BulletEmitter._militaryForcefield.Part.Transparency < 1 and not BulletEmitter._militaryForcefield.Ignore) then
		local shieldListClone = table.clone(ListShields)
		shieldListClone[shieldListLength + 1] = BulletEmitter._militaryForcefield
		ListShields = shieldListClone
	end
	local allPlayers = Players:GetPlayers()
	for i = bulletCount, 1, -1 do
		local hitPart, hitPosition, hitNormal, hitMaterial
		local currentBullet = emitter.Bullets[i]
		local bulletPosition = currentBullet[1]
		local bulletDirection = currentBullet[2]
		local bulletSpeed = currentBullet[3]
		local bulletVisual = currentBullet[4]
		local bulletLifespan = currentBullet[5]
		if bulletLifespan > 0 and bulletDirection then
			local rayDistance = bulletSpeed * deltaTime
			local shieldBlocked = nil
			local hitTargetHumanoid = nil
			local hitPlayerBullet = nil
			local headShotFlag = nil
			local reflectedDirection = nil
			local nextPosition = bulletPosition
			if not shieldBlocked then
				for i2, shield in ipairs(ListShields) do
					local Position = shield.Position
					local shieldIntersectionT = IntersectRaySphereF(bulletPosition.x, bulletPosition.y, bulletPosition.z, bulletDirection.x, bulletDirection.y, bulletDirection.z, rayDistance, Position.x, Position.y, Position.z, shield.Radius)
					if shieldIntersectionT ~= nil and math.random() < shieldBlockChance then
						shieldBlocked = true
						local blockPosition = bulletPosition + shieldIntersectionT * bulletDirection * rayDistance
						local blockNormal = (blockPosition - Position).Unit
						nextPosition = blockPosition + blockNormal * 0.001
						bulletDirection = bulletDirection - 2 * bulletDirection:Dot(blockNormal) * blockNormal
						if not shield.Part then
							emitter.OnShieldDamage:Fire(shield, nextPosition, blockNormal, hitTargetHumanoid)
						end
						break
					end
				end
				for _, player in allPlayers do
					local equippedItem = ItemSystem.GetEquipped(player)
					if equippedItem and InventoryItemUtils.getName(equippedItem.inventoryItemValue) == "ShieldSWAT" then
						local BulletCollide = equippedItem.Model:FindFirstChild("Skeleton"):FindFirstChild("BulletCollide")
						local planeIntersectionT = Math.IntersectRayPlane(bulletPosition, bulletDirection, BulletCollide.Position, BulletCollide.CFrame.LookVector)
					end
				end
			end
			if not shieldBlocked and isLocalCollisionEnabled then
				for i2, rootPart in ipairs(targetCharacterRootParts) do
					local Position = rootPart.Position
					local characterHitT = IntersectRaySphereF(bulletPosition.x, bulletPosition.y, bulletPosition.z, bulletDirection.x, bulletDirection.y, bulletDirection.z, rayDistance, Position.x, Position.y, Position.z, (CombatUtils.getRootPartHitRadius(rootPart)))
					if characterHitT ~= nil then
						nextPosition = bulletPosition + characterHitT * bulletDirection * rayDistance
						local characterNormal = (nextPosition - Position).Unit
						local Humanoid = rootPart.Parent:FindFirstChild("Humanoid")
						if not Humanoid or Humanoid.Health ~= 0 then
							hitTargetHumanoid = Humanoid
							hitPlayerBullet = true
							shieldBlocked = rootPart
							break
						end
						shieldBlocked = rootPart
						hitTargetHumanoid = nil
					end
				end
			end
			if not shieldBlocked then
				local rayHitPart, rayHitPosition, rayHitNormal, rayHitMaterial = RayCast.RayIgnoreNonCollideWithIgnoreList(bulletPosition, bulletDirection, rayDistance, currentBullet[7], nil, nil, emitter._customCollidableFunc)
				if rayHitPart then
					currentBullet[7][#currentBullet[7] + 1] = rayHitPart
					if isLocalCollisionEnabled then
						hitPart = rayHitPart
						nextPosition = rayHitPosition
						hitNormal = rayHitNormal
						hitMaterial = rayHitMaterial
						for _, rootPart in targetCharacterRootParts do
							if hitPart:IsDescendantOf(rootPart.Parent) then
								local Humanoid = rootPart.Parent:FindFirstChild("Humanoid")
								local _ = Humanoid and Humanoid.Health > 0
							end
						end
						if hitTargetHumanoid then
							local isPlayerHumanoid = Players:GetPlayerFromCharacter(hitTargetHumanoid.Parent) ~= nil
							if not isPlayerHumanoid and hitPart.Name == "Head" then
								headShotFlag = true
							elseif not isPlayerHumanoid then
								local Attachment = hitPart:FindFirstChildOfClass("Attachment")
								if Attachment and attachmentNameSet[Attachment.Name] then
									headShotFlag = true
								end
							end
						end
					else
						hitPart = rayHitPart
						nextPosition = rayHitPosition
						hitNormal = rayHitNormal
						hitMaterial = rayHitMaterial
					end
					emitter.OnHitSurface:Fire(hitPart, nextPosition, hitNormal, hitMaterial)
					hitPlayerBullet = true
				else
					nextPosition = rayHitPosition
				end
			end
			if hitTargetHumanoid then
				local bulletOrigin = currentBullet[6]
				local remainingLifespan = LifeSpan - (bulletLifespan - deltaTime * ((nextPosition - bulletPosition).Magnitude / rayDistance))
				local _ = GuardNPCBinder:Get(hitTargetHumanoid.Parent) == nil
				emitter.OnLocalHitPlayer:Fire(hitTargetHumanoid, 0.7483072263887747 * bulletOrigin.x - 0.6609848067581097 * bulletOrigin.y - 0.055994465523689876 * bulletOrigin.z, 0.2852117920578111 * bulletDirection.x + 0.3968011188544949 * bulletDirection.y - 0.8724695443091369 * bulletDirection.z, 0.7483072263887747 * nextPosition.x - 0.6609848067581097 * nextPosition.y - 0.055994465523689876 * nextPosition.z, 0.7483072263887747 * remainingLifespan, 0.2852117920578111 * bulletOrigin.x + 0.3968011188544949 * bulletOrigin.y - 0.8724695443091369 * bulletOrigin.z, 0.5989077797169704 * bulletOrigin.x + 0.6369049829533174 * bulletOrigin.y + 0.485449805936436 * bulletOrigin.z, 0.2852117920578111 * remainingLifespan, 0.5989077797169704 * bulletDirection.x + 0.6369049829533174 * bulletDirection.y + 0.485449805936436 * bulletDirection.z, 0.7483072263887747 * bulletDirection.x - 0.6609848067581097 * bulletDirection.y - 0.055994465523689876 * bulletDirection.z, 0.5989077797169704 * nextPosition.x + 0.6369049829533174 * nextPosition.y + 0.485449805936436 * nextPosition.z, 0.2852117920578111 * nextPosition.x + 0.3968011188544949 * nextPosition.y - 0.8724695443091369 * nextPosition.z, 0.5989077797169704 * remainingLifespan, {
					isHeadshot = headShotFlag
				})
			end
			if hitPlayerBullet then
				bulletLifespan = 0
			end
			bulletVisual.Length = (nextPosition - bulletPosition).Magnitude
			bulletVisual.CFrame = CFrame.new(nextPosition, bulletPosition)
			if emitter.Local == false and emitter.BulletWhizEnabled then
				emitter:CheckWhiz(currentBullet)
			end
			if emitter.GravityVector ~= nil then
				bulletDirection = bulletDirection + emitter.GravityVector * deltaTime / bulletSpeed
			end
			currentBullet[1] = nextPosition
			currentBullet[2] = bulletDirection
			currentBullet[3] = bulletSpeed
			currentBullet[5] = bulletLifespan - deltaTime
		else
			bulletVisual:Destroy()
			currentBullet[4] = nil
			table.remove(emitter.Bullets, i)
		end
	end
	if bulletCount > 0 and #emitter.Bullets == 0 then
		emitter.OnQueueEmptied:Fire()
	end
	debug.profileend()
end
function BulletEmitter.Destroy(emitter)
	for i = #emitter.Bullets, 1, -1 do
		local bullet = emitter.Bullets[i]
		bullet[4]:Destroy()
		bullet[4] = nil
	end
	emitter.Bullets = nil
	emitter.Maid:Destroy()
	emitter.Maid = nil
end
return BulletEmitter
