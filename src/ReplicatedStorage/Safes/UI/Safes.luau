-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
require(ReplicatedStorage.Std.String)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local SafesConsts = require(ReplicatedStorage.Safes.SafesConsts)
local SAFE_DATA = SafesConsts.SAFE_DATA
local getItemPropsFromRewardData = require(ReplicatedStorage.RewardSpinner.getItemPropsFromRewardData)
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local ItemOwnershipUtils = require(ReplicatedStorage.App.ItemOwnershipUtils)
local SafesInventory = require(script.Parent.SafesInventory)
local SafesShop = require(script.Parent.SafesShop)
local v1 = Roact.PureComponent:extend("Safes")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	anchorPoint = Vector2.new(0, 0)
}
function v1.init(p1)
	p1:_computeShopItems()
	p1:_computeShopSidebarItems()
	function p1.onSelectBuySafes()
 p1.props.setSafesInventoryOpen(false)
	end
	function p1.onSelectOpenSafes()
 p1.props.setSafesInventoryOpen(true)
	end
	function p1.onSelectExit()
 p1.props.setSafesOpen(false)
	end
	function p1.onSelectPurchase()
 local typeEnum = p1.state.shopSidebarItems[p1.props.safesSelectedTypeEnum].typeEnum
 assert(typeEnum ~= nil, "missing typeEnum")
 ReplicatedStorage:FindFirstChild(SafesConsts.SAFE_PURCHASE_REMOTE_NAME):FireServer(typeEnum)
	end
	function p1.onSafeOpen(p1)
 ReplicatedStorage:FindFirstChild(SafesConsts.SAFE_OPEN_REMOTE_NAME):FireServer(p1)
	end
end
function v1._isRewardOwned(p1, p2)
	if p2.Type == "UniqueItem" then
 if p2.ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
 local CategoryName = p2.CategoryName
 local ItemName = p2.ItemName
 if CategoryName and ItemName then
 return ItemOwnershipUtils.isVehicleCustomizationOwned(CategoryName, ItemName)
 else
 return false
 end
 elseif p2.ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
 local Make = p2.Make
 if Make then
 return ItemOwnershipUtils.isVehicleOwned(Make)
 else
 return false
 end
 elseif p2.ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
 local ItemName = p2.ItemName
 if ItemName then
 return ItemOwnershipUtils.isHomeItemOwned(ItemName)
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
function v1._computeShopItems(p1)
	local t = {}
	for v1, v2 in SAFE_DATA[p1.props.safesSelectedTypeEnum].RewardData do
 local var3 = getItemPropsFromRewardData(v2)
 var3.owned = p1:_isRewardOwned(v2)
 table.insert(t, var3)
	end
	table.sort(t, function(p1, p2)
 if p1.rarityIndex == p2.rarityIndex then
 return p1.title < p2.title
 else
 return p1.rarityIndex > p2.rarityIndex
 end
	end)
	p1:setState({
 shopItems = t
	})
end
function v1._computeShopSidebarItems(p1)
	local t = {}
	for v1, v2 in SAFE_DATA do
 table.insert(t, {
 typeEnum = v1,
 imageId = v2.ImageId
 })
	end
	p1:setState({
 shopSidebarItems = t
	})
end
function v1.render(p1)
	if p1.props.open then
 local t = {}
 for i = 1, #p1.state.shopSidebarItems do
 local typeEnum = p1.state.shopSidebarItems[i].typeEnum
 local t2 = {
 count = 0
 }
 if typeEnum == p1.props.safesSelectedTypeEnum then
 t2.selected = true
 end
 function t2.onSelect()
 p1.props.setSafesSelectedSafeTypeEnum(typeEnum)
 end
 t[typeEnum] = t2
 end
 for v1, v2 in p1.props.safesInventoryItems do
 local var3 = t[v2.typeEnum]
 var3.count = var3.count + 1
 end
 if p1.props.inventoryOpen then
 local table4 = TableUtils.filter(p1.props.safesInventoryItems, function(p12)
 return p12.typeEnum == p1.props.safesSelectedTypeEnum
 end)
 local t2 = {}
 for j = 1, #table4 do
 local var5 = table4[j]
 table.insert(t2, {
 onSelect = function()
 p1.onSafeOpen(var5.itemOwnedId)
 end
 })
 end
 return createElement(SafesInventory, {
 size = p1.props.size,
 position = p1.props.position,
 anchorPoint = p1.props.anchorPoint,
 sidebarItems = p1.state.shopSidebarItems,
 sidebarItemMetadata = t,
 items = table4,
 itemMetadata = t2,
 onSelectBuySafes = p1.onSelectBuySafes,
 onSelectExit = p1.onSelectExit
 })
 else
 return createElement(SafesShop, {
 size = p1.props.size,
 position = p1.props.position,
 anchorPoint = p1.props.anchorPoint,
 items = p1.state.shopItems,
 sidebarItems = p1.state.shopSidebarItems,
 sidebarItemMetadata = t,
 selectedSafeTierData = SAFE_DATA[p1.props.safesSelectedTypeEnum],
 onSelectOpenSafes = p1.onSelectOpenSafes,
 onSelectExit = p1.onSelectExit,
 onSelectPurchase = p1.onSelectPurchase,
 policyCashAvailable = p1.props.policyCashAvailable
 })
 end
	end
end
function v1.didUpdate(p1, p2, p3)
	if p1.props.safesSelectedTypeEnum ~= p2.safesSelectedTypeEnum or p1.props.garageOwned ~= p2.garageOwned then
 p1:_computeShopItems()
	end
end
return RoactRodux.connect(function(p1, p2)
	return {
 safesSelectedTypeEnum = p1.safesSelectedTypeEnum,
 safesInventoryItems = p1.safesInventoryItems,
 inventoryOpen = p1.safesInventoryOpen,
 open = p1.safesOpen,
 garageOwned = p1.garageOwned
	}
end, function(p1)
	return {
 setSafesSelectedSafeTypeEnum = function(p12)
 p1({
 type = "setSafesSelectedSafeTypeEnum",
 typeEnum = p12
 })
 end,
 setSafesInventoryOpen = function(p12)
 p1({
 type = "setSafesInventoryOpen",
 value = p12
 })
 end,
 setSafesOpen = function(p12)
 p1({
 type = "setSafesOpen",
 value = p12
 })
 end
	}
end)(v1)