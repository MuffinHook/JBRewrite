-- Reviewed by Claude
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local GamepassUtils = require(script.Parent.GamepassUtils)
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Promise = require(ReplicatedStorage.Std.Promise)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local t = {}
local t2 = {}
local t3 = {
	OnAnyOwned = Signal.new(),
	OnAnyPlayerAnyOwned = Signal.new()
}
function t3.Init()
	t3.OnAnyOwned:Connect(function(p1)
		t2[p1] = true
	end)
	waitForChild(LocalPlayer, "Gamepasses"):andThen(t3.Listen)
	local t = {}
	local function playerRemoving(p1)
		t[p1] = nil
	end
	local function monitorGamepasses(p1)
		local Gamepasses = p1:WaitForChild("Gamepasses")
		t[p1]:GiveTask(RxInstanceUtils.observeChildren(Gamepasses, function(p12, p2)
			t3.OnAnyPlayerAnyOwned:Fire(p1, p12.Value)
		end))
	end
	local function playerAdded(p1)
		t[p1] = Maid.new()
		local Gamepasses = p1:WaitForChild("Gamepasses")
		t[p1]:GiveTask(RxInstanceUtils.observeChildren(Gamepasses, function(p12, p2)
			t3.OnAnyPlayerAnyOwned:Fire(p1, p12.Value)
		end))
	end
	for v1, v2 in Players:GetPlayers() do
		t[v2] = Maid.new()
		local Gamepasses = v2:WaitForChild("Gamepasses")
		t[v2]:GiveTask(RxInstanceUtils.observeChildren(Gamepasses, function(p1, p2)
			t3.OnAnyPlayerAnyOwned:Fire(v2, p1.Value)
		end))
	end
	Players.PlayerAdded:Connect(playerAdded)
	Players.PlayerRemoving:Connect(playerRemoving)
end
function t3.SetOwned(p1)
	assert((GamepassUtils.GetGamepassFromEnum(p1)))
	t3.OnAnyOwned:Fire(p1)
	if t[p1] then
		t[p1]:Fire(p1)
	end
end
function t3.DoesPlayerOwn(p1)
	assert(p1)
	assert(type(p1) == "number")
	return t2[p1] == true
end
function t3.doesPlayerOwnCached(p1, p2)
	assert(p1 ~= nil, "missing player")
	assert(p1.DisplayName ~= nil, "player was not a player")
	assert(p2 ~= nil, "missing gamepassEnum")
	local Gamepasses = p1:FindFirstChild("Gamepasses")
	if Gamepasses then
		for i, v in ipairs(Gamepasses:GetChildren()) do
			if v.Value == p2 then
				return true
			end
		end
	end
	return false
end
function t3.Listen(p1)
	assert(p1)
	local function OnObjAdded(p1)
		if p1:IsA("IntValue") then
			assert(p1.Value > 0)
			t3.SetOwned(p1.Value)
		end
	end
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("IntValue") then
			assert(v.Value > 0)
			t3.SetOwned(v.Value)
		end
	end
	p1.ChildAdded:Connect(OnObjAdded)
end
function t3.GetGamepassOwnedSignal(p1)
	local v1 = t[p1]
	if v1 == nil then
		local v2 = Signal.new()
		t[p1] = v2
		v1 = v2
	end
	return v1
end
local t4 = {}
function t3.promiseProperty(p1, p2)
	if t4[p1] then
		return Promise.resolve(t4[p1][p2])
	else
		return Promise.defer(function(p12)
			local v1 = MarketplaceService:GetProductInfo(p1, Enum.InfoType.GamePass)
			t4[p1] = v1
			p12(v1[p2])
		end)
	end
end
function t3.promisePrice(p1)
	return t3.promiseProperty(p1, "PriceInRobux")
end
function t3.promiseImageId(p1)
	return t3.promiseProperty(p1, "IconImageAssetId")
end
return t3
