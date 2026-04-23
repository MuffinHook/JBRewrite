game:GetService("CollectionService")
game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local StreamingHelperUtils = require(ReplicatedStorage.App.StreamingHelperUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Players = game:GetService("Players")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local LocalPlayer = Players.LocalPlayer
local t = {}
local t2 = {}
local t3 = {}
local function RegisterModule(p1) --[[ Line: 19 | Upvalues: t3 (copy) ]]
	assert(p1.__ClassName ~= nil)
	t3[p1.__ClassName] = p1
end
local function Isv2(p1) --[[ Line: 23 ]]
	return p1.Meta ~= nil
end
local function Init(p1) --[[ Line: 26 | Upvalues: t2 (copy), t3 (copy), Maid (copy), Players (copy), t (copy), Binder (copy), StreamingHelperUtils (copy), TableUtils (copy), RxInstanceUtils (copy), LocalPlayer (copy) ]]
	local _ = p1.Event
	local function v1(p1, p2) --[[ Line: 31 | Upvalues: v1 (copy) ]]
		for v12, v2 in next, p1 do
			if type(v2) == "table" then
				v1(v2, p2)
			else
				p2[v12] = v2
			end
		end
	end
	local function ProcessPacket(p1) --[[ Line: 41 | Upvalues: t2 (ref), t3 (ref), Maid (ref), Players (ref), t (ref), v1 (copy) ]]
		assert(p1)
		local Id = p1.Id
		assert(Id)
		if t2[Id] == nil then
			local v12 = t3[p1.ClassName]
			if v12 == nil then
				error("No vehicle module has been registered for class name: " .. p1.ClassName)
			end
			if v12.FromPacket then
				v12.FromPacket(p1)
			else
				p1 = v12.new(p1)
			end
			if p1.Maid == nil then
				warn("No maid for vehicle packet", p1)
			end
			assert(p1.Seats, "Vehicle needs seats")
			local Maid_2 = p1.Maid
			for v2, v3 in p1.Seats do
				local PlayerName = v3.Part:WaitForChild("PlayerName")
				v3.Occupied = false
				v3.Maid = Maid.new()
				local function update() --[[ Line: 70 | Upvalues: v3 (copy), Players (ref), PlayerName (copy), p1 (ref) ]]
					local Occupied = v3.Occupied
					local v1 = Players:FindFirstChild(PlayerName.Value)
					local v2 = v1 ~= nil
					if v2 then
						v3.Player = v1
						v3.Occupied = v2
						v3.Maid:DoCleaning()
					end
					if v2 ~= Occupied and v2 then
						p1:MountPlayer(v3.Player, v3)
					elseif v2 ~= Occupied then
						p1:UnmountSeat(v3)
					end
					if not v2 then
						v3.Player = v1
						v3.Occupied = v2
						v3.Maid:DoCleaning()
					end
				end
				update()
				Maid_2:GiveTask(PlayerName.Changed:Connect(update))
			end
			table.insert(t, p1)
			t2[Id] = p1
		else
			if t2[Id].Meta ~= nil then
				v1(p1, t2[Id].Meta)
			else
				v1(p1, t2[Id])
			end
		end
	end
	local function removeIdFromList(p1) --[[ Line: 113 | Upvalues: t (ref), t2 (ref) ]]
		for i = #t, 1, -1 do
			local v1, v2
			local v3 = t[i]
			v1 = v3.Meta ~= nil
			v2 = if v1 then v3.Meta.Id else v3.Id
			assert(v2)
			if v2 == p1 then
				t2[v2] = nil
				table.remove(t, i)
				if v3.Seats then
					for j = 1, #v3.Seats do
						local v4 = v3.Seats[j]
						if v4.Occupied then
							v3:UnmountSeat(v4)
							v4.Maid:DoCleaning()
						end
					end
				end
				v3:Destroy()
			end
		end
	end
	Binder.new("VehicleSystemPacket", function(p1) --[[ Line: 140 | Upvalues: Maid (ref), StreamingHelperUtils (ref), TableUtils (ref), ProcessPacket (copy), removeIdFromList (copy), RxInstanceUtils (ref) ]]
		task.wait()
		local v1 = Maid.new()
		StreamingHelperUtils.yieldForAllValuesPopulated(p1)
		local v2 = TableUtils.createTableFromObjectValues(p1)
		local v3 = if v2.Meta ~= nil then v2.Meta.Id else v2.Id
		local function create() --[[ Line: 154 | Upvalues: ProcessPacket (ref), v2 (copy) ]]
			ProcessPacket(v2)
		end
		local function destroy() --[[ Line: 157 | Upvalues: removeIdFromList (ref), v3 (ref) ]]
			removeIdFromList(v3)
		end
		v1:GiveTask(RxInstanceUtils.observeOneChildNamed(v2.Model, "BoundingBox", function(p1, p2) --[[ Line: 161 | Upvalues: ProcessPacket (ref), v2 (copy), destroy (copy) ]]
			ProcessPacket(v2)
			p2:GiveTask(destroy)
		end))
		return v1
	end):Start()
	function p1.em.ih5093c4(p1) --[[ Line: 169 | Upvalues: t2 (ref), LocalPlayer (ref) ]]
		local v1 = t2[p1]
		assert(v1)
		v1:FollowPlayer(LocalPlayer)
	end
end
local function GetVehiclePacket(p1) --[[ Line: 208 | Upvalues: t (copy) ]]
	for i = 1, #t do
		local v1 = t[i]
		for j = 1, #v1.Seats do
			local v2 = v1.Seats[j]
			if v2.Occupied and v2.Player == p1 then
				return v1, v2
			end
		end
	end
	return nil
end
return {
	Init = Init,
	RegisterModule = RegisterModule,
	GetVehiclePacket = GetVehiclePacket,
	WaitForVehiclePacket = function(p1) --[[ Name: WaitForVehiclePacket | Line: 220 | Upvalues: GetVehiclePacket (copy) ]]
		local v1 = os.clock()
		while os.clock() - v1 < 5 do
			local v2, v3 = GetVehiclePacket(p1)
			if v2 ~= nil then
				return v2, v3
			end
			task.wait()
		end
		return nil
	end,
	GetPlayerSeat = function(p1, p2) --[[ Name: GetPlayerSeat | Line: 231 ]]
		assert(p1 ~= nil)
		assert(p2 ~= nil)
		for i = 1, #p1.Seats do
			local v3 = p1.Seats[i]
			if v3.Occupied and v3.Player == p2 then
				return v3
			end
		end
		return nil
	end
}