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
function t.new(p1, p2) --[[ Line: 21 | Upvalues: NPC (copy), t (copy), Maid (copy), InventoryItemOwnerBinder (copy), ItemSystem (copy), Math (copy), MinimapService (copy), RunService (copy), Players (copy), GuardNPCConsts (copy) ]]
	local v1 = NPC.new(p1, p2)
	setmetatable(v1, t)
	local v3 = Maid.new()
	v1._maid:GiveTask(v3)
	local function observePlayerObj(p1) --[[ Line: 27 | Upvalues: v3 (copy), InventoryItemOwnerBinder (ref), ItemSystem (ref), v1 (copy) ]]
		v3:DoCleaning()
		if p1 then
			v3:GivePromise(InventoryItemOwnerBinder:Promise(p1):andThen(function(p1) --[[ Line: 32 | Upvalues: ItemSystem (ref), v1 (ref), v3 (ref) ]]
				local v12 = ItemSystem.GetEquipped(p1)
				if v12 then
					v1:_onItemEquipped(v12)
				end
				v3:GiveTask(ItemSystem.onItemEquipped:Connect(function(p12) --[[ Line: 37 | Upvalues: p1 (copy), v1 (ref) ]]
					if p12.Player == p1 then
						v1:_onItemEquipped(p12)
					end
				end))
			end))
		end
	end
	observePlayerObj(p2.characterToPlayerObj.Value)
	v1._maid:GiveTask(p2.characterToPlayerObj.Changed:Connect(observePlayerObj))
	v1._maid:GiveTask(MinimapService.add({
		part = v1.obj.PrimaryPart,
		color = Color3.fromRGB(255, 204, 0),
		name = Math.Base85UUID(5),
		size = UDim2.new(0, 12, 0, 12),
		flash = true
	}))
	local function initializePlayerPushing() --[[ Line: 58 | Upvalues: v1 (copy), RunService (ref), Players (ref), GuardNPCConsts (ref) ]]
		local t = {}
		v1._maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 60 | Upvalues: Players (ref), v1 (ref), t (copy), GuardNPCConsts (ref) ]]
			local v12 = workspace:GetServerTimeNow()
			local t2 = {}
			for v3, v4 in Players:GetPlayers() do
				local v2
				local Character = v4.Character
				if Character then
					v2 = if t[v4.UserId] then v12 - t[v4.UserId] else 1.797693134862316e308
					if (Character.PrimaryPart.Position - v1.obj.PrimaryPart.Position).Magnitude <= GuardNPCConsts.DIST_TO_PUSH_WITHIN and GuardNPCConsts.TIME_BETWEEN_PUSHES < v2 then
						t[v4.UserId] = v12
						table.insert(t2, Character)
					end
				end
			end
			for v5, v6 in t2 do
				v6.PrimaryPart:ApplyImpulse((v6.PrimaryPart.Position - v1.obj.PrimaryPart.Position).Unit * GuardNPCConsts.PUSH_IMPULSE_MULTIPLIER)
			end
			return true
		end))
	end
	return v1
end
function t._onItemEquipped(p1, p2) --[[ Line: 96 | Upvalues: NPCConsts (copy), GeomUtils (copy), GuardNPCShared (copy), GuardNPCUtils (copy), RunService (copy) ]]
	local v1 = math.random() * 100
	p2.SimulateLocal = true
	p2.MinimalFx = true
	p2.BulletEmitter.SimulateLocal = true
	p2.BulletEmitter.IgnoreLocalPlayer = false
	p2.BulletEmitter.ShieldBlockPct = 0.75
	p2.BulletEmitter.IgnoreGuards = true
	p2.BulletEmitter.Color = Color3.fromRGB(196, 40, 28)
	local v2 = 0
	local v3 = Vector3.new()
	local v4 = os.clock()
	local v5 = 0
	local v6 = false
	local v7 = os.clock()
	local function update() --[[ Line: 118 | Upvalues: v1 (copy), p1 (copy), NPCConsts (ref), v2 (ref), GeomUtils (ref), v3 (ref), p2 (copy), v7 (ref), v6 (ref), GuardNPCShared (ref), GuardNPCUtils (ref), v4 (ref), v5 (ref) ]]
		local v12 = os.clock() + v1
		if p1.obj.Humanoid and not (p1.obj.Humanoid.Health <= 0) then
			if p1:GetTargetType() == NPCConsts.DEST_TYPE.IDLE then
				if v12 - v2 > 1.5 then
					local v22 = GeomUtils.randomPointInCircle()
					v3 = Vector3.new(v22.X, 0, v22.Y)
					v2 = v12
				end
				local sum = p1.obj.PrimaryPart.Position + p1.obj.PrimaryPart.CFrame.LookVector * 10
				if p1.obj.PrimaryPart.Velocity.Magnitude < 8 then
					sum = sum + v3 * 7
				end
				p2:SetThirdMousePosition(sum)
			else
				local v32 = p1:GetTarget()
				if v32 and typeof(v32) == "Instance" then
					if v12 - v7 > 1 then
						v6 = GuardNPCShared.canSeeTarget(p1.obj, v32, p1.occlusionCastParams)
						v7 = v12
					end
					if v6 then
						local v42 = v32.Parent
						if v42 then
							local Position = v42:FindFirstChild("Head").Position
							p2.BulletSpread = GuardNPCUtils.getBulletSpread(p1.obj)
							p2:SetThirdMousePosition(Position)
							local v52 = GuardNPCUtils.getTriggerPressFreq(p1.obj)
							if 1 / v52 < v12 - v4 then
								v4 = v12
								v5 = math.random()
								p2:InputBegan({
									UserInputType = Enum.UserInputType.MouseButton1
								})
								task.delay(math.min(0.5, 1 / v52 * v5), function() --[[ Line: 168 | Upvalues: p2 (ref) ]]
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
	p1._maid.itemHeartbeat = RunService.Heartbeat:Connect(function() --[[ Line: 179 | Upvalues: update (copy) ]]
		debug.profilebegin("GuardNPC Heartbeat")
		update()
		debug.profileend()
	end)
end
return ManifestBinder.new(GuardNPCConsts.TAG_NAME, {
	humanoid = "Humanoid",
	characterToPlayerObj = GuardNPCConsts.CHARCTER_TO_PLAYER_OBJ_NAME
}, t)