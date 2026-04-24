-- Reviewed by Claude
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
local function RegisterModule(p1)
	assert(p1.__ClassName ~= nil)
	t3[p1.__ClassName] = p1
end
local function Isv2(p1)
	return p1.Meta ~= nil
end
local function Init(p1)
	local _ = p1.Event
	local function localPlayer(p1, p2)
		for var12, table2 in next, p1 do
			if type(table2) == "table" then
				localPlayer(table2, p2)
			else
				p2[var12] = table2
			end
		end
	end
	local function ProcessPacket(p1)
		assert(p1)
		local Id = p1.Id
		assert(Id)
		if t2[Id] == nil then
			local var12 = t3[p1.ClassName]
			if var12 == nil then
				error("No vehicle module has been registered for class name: " .. p1.ClassName)
			end
			if var12.FromPacket then
				var12.FromPacket(p1)
			else
				p1 = var12.new(p1)
			end
			if p1.Maid == nil then
				warn("No maid for vehicle packet", p1)
			end
			assert(p1.Seats, "Vehicle needs seats")
			local Maid_2 = p1.Maid
			for table2, var3 in p1.Seats do
				local PlayerName = var3.Part:WaitForChild("PlayerName")
				var3.Occupied = false
				var3.Maid = Maid.new()
				local function update()
					local Occupied = var3.Occupied
					local localPlayer = Players:FindFirstChild(PlayerName.Value)
					local table2 = localPlayer ~= nil
					if table2 then
						var3.Player = localPlayer
						var3.Occupied = table2
						var3.Maid:DoCleaning()
					end
					if table2 ~= Occupied and table2 then
						p1:MountPlayer(var3.Player, var3)
					elseif table2 ~= Occupied then
						p1:UnmountSeat(var3)
					end
					if not table2 then
						var3.Player = localPlayer
						var3.Occupied = table2
						var3.Maid:DoCleaning()
					end
				end
				update()
				Maid_2:GiveTask(PlayerName.Changed:Connect(update))
			end
			table.insert(t, p1)
			t2[Id] = p1
		else
			if t2[Id].Meta ~= nil then
				localPlayer(p1, t2[Id].Meta)
			else
				localPlayer(p1, t2[Id])
			end
		end
	end
	local function removeIdFromList(p1)
		for i = #t, 1, -1 do
			local localPlayer, table2
			local var3 = t[i]
			localPlayer = var3.Meta ~= nil
			table2 = if localPlayer then var3.Meta.Id else var3.Id
			assert(table2)
			if table2 == p1 then
				t2[table2] = nil
				table.remove(t, i)
				if var3.Seats then
					for j = 1, #var3.Seats do
						local var4 = var3.Seats[j]
						if var4.Occupied then
							var3:UnmountSeat(var4)
							var4.Maid:DoCleaning()
						end
					end
				end
				var3:Destroy()
			end
		end
	end
	Binder.new("VehicleSystemPacket", function(p1)
		task.wait()
		local localPlayer = Maid.new()
		StreamingHelperUtils.yieldForAllValuesPopulated(p1)
		local table2 = TableUtils.createTableFromObjectValues(p1)
		local var3 = if table2.Meta ~= nil then table2.Meta.Id else table2.Id
		local function create()
			ProcessPacket(table2)
		end
		local function destroy()
			removeIdFromList(var3)
		end
		localPlayer:GiveTask(RxInstanceUtils.observeOneChildNamed(table2.Model, "BoundingBox", function(p1, p2)
			ProcessPacket(table2)
			p2:GiveTask(destroy)
		end))
		return localPlayer
	end):Start()
	function p1.em.ih5093c4(p1)
		local localPlayer = t2[p1]
		assert(localPlayer)
		localPlayer:FollowPlayer(LocalPlayer)
	end
end
local function GetVehiclePacket(p1)
	for i = 1, #t do
		local localPlayer = t[i]
		for j = 1, #localPlayer.Seats do
			local table2 = localPlayer.Seats[j]
			if table2.Occupied and table2.Player == p1 then
				return localPlayer, table2
			end
		end
	end
	return nil
end
return {
	Init = Init,
	RegisterModule = RegisterModule,
	GetVehiclePacket = GetVehiclePacket,
	WaitForVehiclePacket = function(p1)
		local localPlayer = os.clock()
		while os.clock() - localPlayer < 5 do
			local table2, var3 = GetVehiclePacket(p1)
			if table2 ~= nil then
				return table2, var3
			end
			task.wait()
		end
		return nil
	end,
	GetPlayerSeat = function(p1, p2)
		assert(p1 ~= nil)
		assert(p2 ~= nil)
		for i = 1, #p1.Seats do
			local var3 = p1.Seats[i]
			if var3.Occupied and var3.Player == p2 then
				return var3
			end
		end
		return nil
	end
}
