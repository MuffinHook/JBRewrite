-- Reviewed by Claude
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
local t = {}
t.__index = t
setmetatable(t, NPC)
function t.new(p1, p2)
	local instance = NPC.new(p1, p2)
	setmetatable(instance, t)
	local instance3 = Maid.new()
	instance._maid:GiveTask(instance3)
	local function observePlayerObj(p1)
		instance3:DoCleaning()
		if p1 then
			instance3:GivePromise(InventoryItemOwnerBinder:Promise(p1):andThen(function(p1)
				local var12 = ItemSystem.GetEquipped(p1)
				if var12 then
					instance:_onItemEquipped(var12)
				end
				instance3:GiveTask(ItemSystem.onItemEquipped:Connect(function(p12)
					if p12.Player == p1 then
						instance:_onItemEquipped(p12)
					end
				end))
			end))
		end
	end
	observePlayerObj(p2.characterToPlayerObj.Value)
	instance._maid:GiveTask(p2.characterToPlayerObj.Changed:Connect(observePlayerObj))
	instance._maid:GiveTask(MinimapService.add({
		part = instance.obj.PrimaryPart,
		color = Color3.fromRGB(255, 204, 0),
		name = Math.Base85UUID(5),
		size = UDim2.new(0, 12, 0, 12),
		flash = true
	}))
	local function initializePlayerPushing()
		local t = {}
		instance._maid:GiveTask(RunService.Heartbeat:Connect(function()
			local var12 = workspace:GetServerTimeNow()
			local t2 = {}
			for instance3, var4 in Players:GetPlayers() do
				local v2
				local Character = var4.Character
				if Character then
					v2 = if t[var4.UserId] then var12 - t[var4.UserId] else 1.797693134862316e308
					if (Character.PrimaryPart.Position - instance.obj.PrimaryPart.Position).Magnitude <= GuardNPCConsts.DIST_TO_PUSH_WITHIN and GuardNPCConsts.TIME_BETWEEN_PUSHES < v2 then
						t[var4.UserId] = var12
						table.insert(t2, Character)
					end
				end
			end
			for var5, var6 in t2 do
				var6.PrimaryPart:ApplyImpulse((var6.PrimaryPart.Position - instance.obj.PrimaryPart.Position).Unit * GuardNPCConsts.PUSH_IMPULSE_MULTIPLIER)
			end
			return true
		end))
	end
	return instance
end
function t._onItemEquipped(p1, p2)
	local instance = math.random() * 100
	p2.SimulateLocal = true
	p2.MinimalFx = true
	p2.BulletEmitter.SimulateLocal = true
	p2.BulletEmitter.IgnoreLocalPlayer = false
	p2.BulletEmitter.ShieldBlockPct = 0.75
	p2.BulletEmitter.IgnoreGuards = true
	p2.BulletEmitter.Color = Color3.fromRGB(196, 40, 28)
	local v2 = 0
	local instance3 = Vector3.new()
	local var4 = os.clock()
	local var5 = 0
	local var6 = false
	local var7 = os.clock()
	local function update()
		local var12 = os.clock() + instance
		if p1.obj.Humanoid and not (p1.obj.Humanoid.Health <= 0) then
			if p1:GetTargetType() == NPCConsts.DEST_TYPE.IDLE then
				if var12 - v2 > 1.5 then
					local var22 = GeomUtils.randomPointInCircle()
					instance3 = Vector3.new(var22.X, 0, var22.Y)
					v2 = var12
				end
				local sum = p1.obj.PrimaryPart.Position + p1.obj.PrimaryPart.CFrame.LookVector * 10
				if p1.obj.PrimaryPart.Velocity.Magnitude < 8 then
					sum = sum + instance3 * 7
				end
				p2:SetThirdMousePosition(sum)
			else
				local var32 = p1:GetTarget()
				if var32 and typeof(var32) == "Instance" then
					if var12 - var7 > 1 then
						var6 = GuardNPCShared.canSeeTarget(p1.obj, var32, p1.occlusionCastParams)
						var7 = var12
					end
					if var6 then
						local var42 = var32.Parent
						if var42 then
							local Position = var42:FindFirstChild("Head").Position
							p2.BulletSpread = GuardNPCUtils.getBulletSpread(p1.obj)
							p2:SetThirdMousePosition(Position)
							local var52 = GuardNPCUtils.getTriggerPressFreq(p1.obj)
							if 1 / var52 < var12 - var4 then
								var4 = var12
								var5 = math.random()
								p2:InputBegan({
									UserInputType = Enum.UserInputType.MouseButton1
								})
								task.delay(math.min(0.5, 1 / var52 * var5), function()
									if not p2.Destroyed then
										p2:InputEnded({
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
	p1._maid.itemHeartbeat = RunService.Heartbeat:Connect(function()
		debug.profilebegin("GuardNPC Heartbeat")
		update()
		debug.profileend()
	end)
end
return ManifestBinder.new(GuardNPCConsts.TAG_NAME, {
	humanoid = "Humanoid",
	characterToPlayerObj = GuardNPCConsts.CHARCTER_TO_PLAYER_OBJ_NAME
}, t)
