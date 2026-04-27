local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local InventoryItemOwnerBinder = require(ReplicatedStorage.Inventory.InventoryItemOwnerBinder)
local NPC = require(ReplicatedStorage.NPC.NPC)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local Maid = require(ReplicatedStorage.Std.Maid)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local GuardNPCShared = require(ReplicatedStorage.GuardNPC.GuardNPCShared)
local GuardNPCUtils = require(ReplicatedStorage.GuardNPC.GuardNPCUtils)
local GuardNPCConsts = require(ReplicatedStorage.GuardNPC.GuardNPCConsts)
local NPCConsts = require(ReplicatedStorage.NPC.NPCConsts)
local MinimapService = require(ReplicatedStorage.App.MinimapService)
local Math = require(ReplicatedStorage.Module.Math)
local Players = game:GetService("Players")
local GuardNPCBinder = {}
GuardNPCBinder.__index = GuardNPCBinder
setmetatable(GuardNPCBinder, NPC)
function GuardNPCBinder.new(character, characterData)
	local instance = NPC.new(character, characterData)
	setmetatable(instance, GuardNPCBinder)
	local maid = Maid.new()
	instance._maid:GiveTask(maid)
	local function observePlayerObj(player)
		maid:DoCleaning()
		if player then
			maid:GivePromise(InventoryItemOwnerBinder:Promise(player):andThen(function(playerBinding)
				local equippedItem = ItemSystem.GetEquipped(playerBinding)
				if equippedItem then
					instance:_onItemEquipped(equippedItem)
				end
				maid:GiveTask(ItemSystem.onItemEquipped:Connect(function(equippedItemEvent)
					if equippedItemEvent.Player == playerBinding then
						instance:_onItemEquipped(equippedItemEvent)
					end
				end))
			end))
		end
	end
	observePlayerObj(characterData.characterToPlayerObj.Value)
	instance._maid:GiveTask(characterData.characterToPlayerObj.Changed:Connect(observePlayerObj))
	instance._maid:GiveTask(MinimapService.add({
		part = instance.obj.PrimaryPart,
		color = Color3.fromRGB(255, 204, 0),
		name = Math.Base85UUID(5),
		size = UDim2.new(0, 12, 0, 12),
		flash = true
	}))
	local function initializePlayerPushing()
		local lastPushTimeByUserId = {}
		instance._maid:GiveTask(RunService.Heartbeat:Connect(function()
			local currentServerTime = workspace:GetServerTimeNow()
			local charactersToAffect = {}
			for index, player in Players:GetPlayers() do
				local timeSinceLastPush
				local Character = player.Character
				if Character then
					timeSinceLastPush = if lastPushTimeByUserId[player.UserId] then currentServerTime - lastPushTimeByUserId[player.UserId] else 1.797693134862316e308
					if (Character.PrimaryPart.Position - instance.obj.PrimaryPart.Position).Magnitude <= GuardNPCConsts.DIST_TO_PUSH_WITHIN and GuardNPCConsts.TIME_BETWEEN_PUSHES < timeSinceLastPush then
						lastPushTimeByUserId[player.UserId] = currentServerTime
						table.insert(charactersToAffect, Character)
					end
				end
			end
			for index, targetCharacter in charactersToAffect do
				targetCharacter.PrimaryPart:ApplyImpulse((targetCharacter.PrimaryPart.Position - instance.obj.PrimaryPart.Position).Unit * GuardNPCConsts.PUSH_IMPULSE_MULTIPLIER)
			end
			return true
		end))
	end
	return instance
end
function GuardNPCBinder._onItemEquipped(character, weapon)
	local randomClockOffset = math.random() * 100
	weapon.SimulateLocal = true
	weapon.MinimalFx = true
	weapon.BulletEmitter.SimulateLocal = true
	weapon.BulletEmitter.IgnoreLocalPlayer = false
	weapon.BulletEmitter.ShieldBlockPct = 0.75
	weapon.BulletEmitter.IgnoreGuards = true
	weapon.BulletEmitter.Color = Color3.fromRGB(196, 40, 28)
	local lastUpdateTime = 0
	local randomDirection = Vector3.new()
	local lastTriggerTime = os.clock()
	local randomTriggerDelay = 0
	local canSeeTarget = false
	local lastVisibilityCheckTime = os.clock()
	local function update()
		local currentTime = os.clock() + randomClockOffset
		if character.obj.Humanoid and not (character.obj.Humanoid.Health <= 0) then
			if character:GetTargetType() == NPCConsts.DEST_TYPE.IDLE then
				if currentTime - lastUpdateTime > 1.5 then
					local randomOffset = GeomUtils.randomPointInCircle()
					randomDirection = Vector3.new(randomOffset.X, 0, randomOffset.Y)
					lastUpdateTime = currentTime
				end
				local aimPosition = character.obj.PrimaryPart.Position + character.obj.PrimaryPart.CFrame.LookVector * 10
				if character.obj.PrimaryPart.Velocity.Magnitude < 8 then
					aimPosition = aimPosition + randomDirection * 7
				end
				weapon:SetThirdMousePosition(aimPosition)
			else
				local targetObject = character:GetTarget()
				if targetObject and typeof(targetObject) == "Instance" then
					if currentTime - lastVisibilityCheckTime > 1 then
						canSeeTarget = GuardNPCShared.canSeeTarget(character.obj, targetObject, character.occlusionCastParams)
						lastVisibilityCheckTime = currentTime
					end
					if canSeeTarget then
						local targetCharacter = targetObject.Parent
						if targetCharacter then
							local Position = targetCharacter:FindFirstChild("Head").Position
							weapon.BulletSpread = GuardNPCUtils.getBulletSpread(character.obj)
							weapon:SetThirdMousePosition(Position)
							local triggerFrequency = GuardNPCUtils.getTriggerPressFreq(character.obj)
							if 1 / triggerFrequency < currentTime - lastTriggerTime then
								lastTriggerTime = currentTime
								randomTriggerDelay = math.random()
								weapon:InputBegan({
									UserInputType = Enum.UserInputType.MouseButton1
								})
								task.delay(math.min(0.5, 1 / triggerFrequency * randomTriggerDelay), function()
									if not weapon.Destroyed then
										weapon:InputEnded({
											UserInputType = Enum.UserInputType.MouseButton1
										})
									end
								end)
								return true
							else
								return false
							end
						else
							return false
						end
					else
						return false
					end
				else
					return false
				end
			end
		end
		return false
	end
	character._maid.itemHeartbeat = RunService.Heartbeat:Connect(function()
		debug.profilebegin("GuardNPC Heartbeat")
		update()
		debug.profileend()
	end)
end
return ManifestBinder.new(GuardNPCConsts.TAG_NAME, {
	humanoid = "Humanoid",
	characterToPlayerObj = GuardNPCConsts.CHARCTER_TO_PLAYER_OBJ_NAME
}, GuardNPCBinder)
