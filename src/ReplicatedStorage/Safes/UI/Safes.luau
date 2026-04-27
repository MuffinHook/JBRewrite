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
local SafesComponent = Roact.PureComponent:extend("Safes")
SafesComponent.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	anchorPoint = Vector2.new(0, 0)
}
function SafesComponent.init(self)
	self:_computeShopItems()
	self:_computeShopSidebarItems()
	function self.onSelectBuySafes()
 self.props.setSafesInventoryOpen(false)
	end
	function self.onSelectOpenSafes()
 self.props.setSafesInventoryOpen(true)
	end
	function self.onSelectExit()
 self.props.setSafesOpen(false)
	end
	function self.onSelectPurchase()
 local typeEnum = self.state.shopSidebarItems[self.props.safesSelectedTypeEnum].typeEnum
 assert(typeEnum ~= nil, "missing typeEnum")
 ReplicatedStorage:FindFirstChild(SafesConsts.SAFE_PURCHASE_REMOTE_NAME):FireServer(typeEnum)
	end
	function self.onSafeOpen(safeItemId)
 ReplicatedStorage:FindFirstChild(SafesConsts.SAFE_OPEN_REMOTE_NAME):FireServer(safeItemId)
	end
end
function SafesComponent._isRewardOwned(self, rewardData)
	if rewardData.Type == "UniqueItem" then
 if rewardData.ItemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
 local CategoryName = rewardData.CategoryName
 local ItemName = rewardData.ItemName
 if CategoryName and ItemName then
 return ItemOwnershipUtils.isVehicleCustomizationOwned(CategoryName, ItemName)
 else
 return false
 end
 elseif rewardData.ItemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
 local Make = rewardData.Make
 if Make then
 return ItemOwnershipUtils.isVehicleOwned(Make)
 else
 return false
 end
 elseif rewardData.ItemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
 local ItemName = rewardData.ItemName
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
function SafesComponent._computeShopItems(self)
	local itemsList = {}
	for typeEnum, rewardData in SAFE_DATA[self.props.safesSelectedTypeEnum].RewardData do
 local itemProps = getItemPropsFromRewardData(rewardData)
 itemProps.owned = self:_isRewardOwned(rewardData)
 table.insert(itemsList, itemProps)
	end
	table.sort(itemsList, function(itemA, itemB)
 if itemA.rarityIndex == itemB.rarityIndex then
 return itemA.title < itemB.title
 else
 return itemA.rarityIndex > itemB.rarityIndex
 end
	end)
	self:setState({
 shopItems = itemsList
	})
end
function SafesComponent._computeShopSidebarItems(self)
	local sidebarItemsList = {}
	for typeEnum, safeData in SAFE_DATA do
 table.insert(sidebarItemsList, {
 typeEnum = typeEnum,
 imageId = safeData.ImageId
 })
	end
	self:setState({
 shopSidebarItems = sidebarItemsList
	})
end
function SafesComponent.render(self)
	if self.props.open then
 local sidebarMetadata = {}
 for i = 1, #self.state.shopSidebarItems do
 local typeEnum = self.state.shopSidebarItems[i].typeEnum
 local typeMetadata = {
 count = 0
 }
 if typeEnum == self.props.safesSelectedTypeEnum then
 typeMetadata.selected = true
 end
 function typeMetadata.onSelect()
 self.props.setSafesSelectedSafeTypeEnum(typeEnum)
 end
 sidebarMetadata[typeEnum] = typeMetadata
 end
 for typeEnum, inventoryItem in self.props.safesInventoryItems do
 local itemMetadata = sidebarMetadata[inventoryItem.typeEnum]
 itemMetadata.count = itemMetadata.count + 1
 end
 if self.props.inventoryOpen then
 local filteredInventoryItems = TableUtils.filter(self.props.safesInventoryItems, function(item)
 return item.typeEnum == self.props.safesSelectedTypeEnum
 end)
 local inventoryItemMetadata = {}
 for j = 1, #filteredInventoryItems do
 local currentItem = filteredInventoryItems[j]
 table.insert(inventoryItemMetadata, {
 onSelect = function()
 self.onSafeOpen(currentItem.itemOwnedId)
 end
 })
 end
 return createElement(SafesInventory, {
 size = self.props.size,
 position = self.props.position,
 anchorPoint = self.props.anchorPoint,
 sidebarItems = self.state.shopSidebarItems,
 sidebarItemMetadata = sidebarMetadata,
 items = filteredInventoryItems,
 itemMetadata = inventoryItemMetadata,
 onSelectBuySafes = self.onSelectBuySafes,
 onSelectExit = self.onSelectExit
 })
 else
 return createElement(SafesShop, {
 size = self.props.size,
 position = self.props.position,
 anchorPoint = self.props.anchorPoint,
 items = self.state.shopItems,
 sidebarItems = self.state.shopSidebarItems,
 sidebarItemMetadata = sidebarMetadata,
 selectedSafeTierData = SAFE_DATA[self.props.safesSelectedTypeEnum],
 onSelectOpenSafes = self.onSelectOpenSafes,
 onSelectExit = self.onSelectExit,
 onSelectPurchase = self.onSelectPurchase,
 policyCashAvailable = self.props.policyCashAvailable
 })
 end
	end
end
function SafesComponent.didUpdate(self, previousProps, previousState)
	if self.props.safesSelectedTypeEnum ~= previousProps.safesSelectedTypeEnum or self.props.garageOwned ~= previousProps.garageOwned then
 self:_computeShopItems()
	end
end
return RoactRodux.connect(function(state, dispatch)
	return {
 safesSelectedTypeEnum = state.safesSelectedTypeEnum,
 safesInventoryItems = state.safesInventoryItems,
 inventoryOpen = state.safesInventoryOpen,
 open = state.safesOpen,
 garageOwned = state.garageOwned
	}
end, function(dispatch)
	return {
 setSafesSelectedSafeTypeEnum = function(typeEnum)
 dispatch({
 type = "setSafesSelectedSafeTypeEnum",
 typeEnum = typeEnum
 })
 end,
 setSafesInventoryOpen = function(isOpen)
 dispatch({
 type = "setSafesInventoryOpen",
 value = isOpen
 })
 end,
 setSafesOpen = function(isOpen)
 dispatch({
 type = "setSafesOpen",
 value = isOpen
 })
 end
	}
end)(SafesComponent)
