local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LevelSystem = require(ReplicatedStorage.Game.Level2.LevelSystem)
local LevelUtils = require(ReplicatedStorage.Game.Level2.LevelUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Format = require(ReplicatedStorage.Module.Format)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GunShop = ReplicatedStorage.Resource.GunShop
local t = {}
t.__index = t
t.__ClassName = "GunShopItem"
function t.new() --[[ Line: 16 | Upvalues: t (copy), Maid (copy), GunShop (copy), LevelSystem (copy), LocalPlayer (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._itemFrame = GunShop.PresetItem:Clone()
	t2._maid:GiveTask(t2._itemFrame)
	t2._layoutOrder = 0
	local TextButton = Instance.new("TextButton")
	TextButton.BackgroundTransparency = 1
	TextButton.Text = ""
	TextButton.Size = UDim2.fromScale(1, 1)
	TextButton.Parent = t2._itemFrame
	t2.onMouseButton1Down = TextButton.MouseButton1Click
	t2._price = 0
	t2._owned = false
	t2._equipped = false
	t2._level = nil
	t2._itemName = nil
	t2._maid:GiveTask(LevelSystem.getOnLevelChangedSignal():Connect(function(p1) --[[ Line: 45 | Upvalues: LocalPlayer (ref), t2 (copy) ]]
		if p1 == LocalPlayer then
			t2:UpdateLevel()
		end
	end))
	return t2
end
function t.GetName(p1) --[[ Line: 54 ]]
	return p1._itemName
end
function t.SetName(p1, p2, p3) --[[ Line: 57 ]]
	p1._itemName = p2
	p1._itemFrame.Name = p2
	p1._itemFrame.Top.Title.Text = p3:upper()
end
function t.SetImageId(p1, p2) --[[ Line: 62 ]]
	if typeof(p2) == "number" then
		p2 = ("rbxassetid://%d"):format(p2)
	end
	p1._itemFrame.Top.Icon.Image = p2
end
function t.SetImageColor(p1, p2) --[[ Line: 68 ]]
	p1._itemFrame.Top.Icon.ImageColor3 = p2
end
function t.SetPrice(p1, p2) --[[ Line: 71 ]]
	p1._price = p2
	p1:Update()
end
function t.SetLevel(p1, p2) --[[ Line: 75 ]]
	p1._level = p2
	p1:UpdateLevel()
end
function t.SetOwned(p1, p2) --[[ Line: 79 ]]
	if p1._owned ~= p2 then
		p1._owned = p2
		p1:Update()
		p1:UpdateLevel()
	end
end
function t.GetEquipped(p1) --[[ Line: 86 ]]
	return p1._equipped
end
function t.SetEquipped(p1, p2) --[[ Line: 89 ]]
	if p1._equipped ~= p2 then
		p1._equipped = p2
		p1:Update()
	end
end
function t.UpdateLevel(p1) --[[ Line: 95 | Upvalues: LevelUtils (copy), LocalPlayer (copy) ]]
	local v1 = if p1._level == nil then false else not p1._owned
	p1._itemFrame.Bottom.Level.Visible = v1
	if v1 then
		p1._itemFrame.Bottom.Level.Text = ("LVL %d"):format(p1._level)
		p1._itemFrame.Bottom.Level.Lock.Visible = LevelUtils.yieldLevel(LocalPlayer) < p1._level
	end
end
function t.AddRequiredGamepass(p1, p2) --[[ Line: 105 | Upvalues: GunShop (copy), GamepassUtils (copy), GamepassSystem (copy) ]]
	assert(p2)
	local v1 = GunShop.PresetRequiredIcon:Clone()
	v1.Parent = p1._itemFrame.Bottom.RequiredContainer
	p1._maid:GivePromise(GamepassSystem.promiseImageId(GamepassUtils.GetGamepassFromEnum(p2).PassId):andThen(function(p1) --[[ Line: 112 | Upvalues: v1 (copy) ]]
		v1.Image = ("rbxassetid://%d"):format(p1)
		v1.Visible = true
	end):catch(warn))
	p1._maid:GiveTask(v1.MouseButton1Down:Connect(function() --[[ Line: 118 | Upvalues: GamepassUtils (ref), p2 (copy) ]]
		GamepassUtils.PromptGamepass(p2)
	end))
end
function t.Update(p1) --[[ Line: 122 | Upvalues: Format (copy) ]]
	if p1._equipped then
		p1._itemFrame.Bottom.Action.Text = "UNEQUIP"
		p1._itemFrame.Bottom.Action.TextColor3 = Color3.fromRGB(212, 39, 39)
	elseif p1._owned then
		p1._itemFrame.Bottom.Action.Text = "EQUIP"
		p1._itemFrame.Bottom.Action.TextColor3 = Color3.fromRGB(212, 39, 39)
	else
		if p1._price == 0 then
			p1._itemFrame.Bottom.Action.Text = "FREE"
		else
			p1._itemFrame.Bottom.Action.Text = Format.Currency(p1._price)
		end
		p1._itemFrame.Bottom.Action.TextColor3 = Color3.fromRGB(112, 212, 69)
	end
	if p1._owned then
		p1._itemFrame.Image = "rbxassetid://5834235796"
	else
		p1._itemFrame.Image = "rbxassetid://5834236192"
	end
end
function t.GetLayoutOrder(p1) --[[ Line: 144 ]]
	return p1._itemFrame.LayoutOrder
end
function t.SetLayoutOrder(p1, p2) --[[ Line: 147 ]]
	p1._itemFrame.LayoutOrder = p2
end
function t.SetParent(p1, p2) --[[ Line: 150 ]]
	p1._itemFrame.Parent = p2
end
function t.Destroy(p1) --[[ Line: 153 ]]
	p1._maid:Destroy()
	p1._maid = nil
end
return t