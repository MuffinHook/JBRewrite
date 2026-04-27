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
local gamepassSignals = {}
local ownedGamepassesCache = {}
local GamepassSystem = {
	OnAnyOwned = Signal.new(),
	OnAnyPlayerAnyOwned = Signal.new()
}
function GamepassSystem.Init()
	GamepassSystem.OnAnyOwned:Connect(function(gamepassId)
		ownedGamepassesCache[gamepassId] = true
	end)
	waitForChild(LocalPlayer, "Gamepasses"):andThen(GamepassSystem.Listen)
	local playerMaids = {}
	local function playerRemoving(player)
		playerMaids[player] = nil
	end
	local function monitorGamepasses(player)
		local Gamepasses = player:WaitForChild("Gamepasses")
		playerMaids[player]:GiveTask(RxInstanceUtils.observeChildren(Gamepasses, function(gamepassInstance, removed)
			GamepassSystem.OnAnyPlayerAnyOwned:Fire(player, gamepassInstance.Value)
		end))
	end
	local function playerAdded(player)
		playerMaids[player] = Maid.new()
		local Gamepasses = player:WaitForChild("Gamepasses")
		playerMaids[player]:GiveTask(RxInstanceUtils.observeChildren(Gamepasses, function(gamepassInstance, removed)
			GamepassSystem.OnAnyPlayerAnyOwned:Fire(player, gamepassInstance.Value)
		end))
	end
	for index, player in Players:GetPlayers() do
		playerMaids[player] = Maid.new()
		local Gamepasses = player:WaitForChild("Gamepasses")
		playerMaids[player]:GiveTask(RxInstanceUtils.observeChildren(Gamepasses, function(gamepassInstance, removed)
			GamepassSystem.OnAnyPlayerAnyOwned:Fire(player, gamepassInstance.Value)
		end))
	end
	Players.PlayerAdded:Connect(playerAdded)
	Players.PlayerRemoving:Connect(playerRemoving)
end
function GamepassSystem.SetOwned(gamepassId)
	assert((GamepassUtils.GetGamepassFromEnum(gamepassId)))
	GamepassSystem.OnAnyOwned:Fire(gamepassId)
	if gamepassSignals[gamepassId] then
		gamepassSignals[gamepassId]:Fire(gamepassId)
	end
end
function GamepassSystem.DoesPlayerOwn(gamepassId)
	assert(gamepassId)
	assert(type(gamepassId) == "number")
	return ownedGamepassesCache[gamepassId] == true
end
function GamepassSystem.doesPlayerOwnCached(player, gamepassEnum)
	assert(player ~= nil, "missing player")
	assert(player.DisplayName ~= nil, "player was not a player")
	assert(gamepassEnum ~= nil, "missing gamepassEnum")
	local Gamepasses = player:FindFirstChild("Gamepasses")
	if Gamepasses then
		for index, gamepass in ipairs(Gamepasses:GetChildren()) do
			if gamepass.Value == gamepassEnum then
				return true
			end
		end
	end
	return false
end
function GamepassSystem.Listen(gamepassesFolder)
	assert(gamepassesFolder)
	local function OnGamepassAdded(gamepassInstance)
		if gamepassInstance:IsA("IntValue") then
			assert(gamepassInstance.Value > 0)
			GamepassSystem.SetOwned(gamepassInstance.Value)
		end
	end
	for index, gamepass in ipairs(gamepassesFolder:GetChildren()) do
		if gamepass:IsA("IntValue") then
			assert(gamepass.Value > 0)
			GamepassSystem.SetOwned(gamepass.Value)
		end
	end
	gamepassesFolder.ChildAdded:Connect(OnGamepassAdded)
end
function GamepassSystem.GetGamepassOwnedSignal(gamepassId)
	local signal = gamepassSignals[gamepassId]
	if signal == nil then
		local newSignal = Signal.new()
		gamepassSignals[gamepassId] = newSignal
		signal = newSignal
	end
	return signal
end
local gamepassInfoCache = {}
function GamepassSystem.promiseProperty(gamepassId, propertyName)
	if gamepassInfoCache[gamepassId] then
		return Promise.resolve(gamepassInfoCache[gamepassId][propertyName])
	else
		return Promise.defer(function(resolve)
			local productInfo = MarketplaceService:GetProductInfo(gamepassId, Enum.InfoType.GamePass)
			gamepassInfoCache[gamepassId] = productInfo
			resolve(productInfo[propertyName])
		end)
	end
end
function GamepassSystem.promisePrice(gamepassId)
	return GamepassSystem.promiseProperty(gamepassId, "PriceInRobux")
end
function GamepassSystem.promiseImageId(gamepassId)
	return GamepassSystem.promiseProperty(gamepassId, "IconImageAssetId")
end
return GamepassSystem
