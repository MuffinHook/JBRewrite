local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local BountyConsts = require(ReplicatedStorage.Bounty.BountyConsts)
local t = {
	Bounties = {},
	onBountiesUpdated = require(ReplicatedStorage.Std.Signal).new()
}
local BountyData = ReplicatedStorage:FindFirstChild("BountyData")
function t.init() --[[ Line: 18 | Upvalues: t (copy), BountyData (copy) ]]
	t.updateBounties()
	BountyData:GetPropertyChangedSignal("Value"):Connect(t.updateBounties)
end
local function thumbnailBust(p1) --[[ Line: 23 ]]
	return ("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420"):format(p1)
end
local function comma(p1) --[[ Line: 26 ]]
	local v1, v2, v3 = string.match(p1, "^([^%d]*%d)(%d*)(.-)$")
	return v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v3
end
local function clearFrame(p1) --[[ Line: 30 ]]
	for v1, v2 in p1:GetChildren() do
		if v2:IsA("Frame") then
			v2:Destroy()
		end
	end
end
function t.updateGui(p1, p2) --[[ Line: 38 | Upvalues: Players (copy), clearFrame (copy), ReplicatedStorage (copy) ]]
	local v1 = p1:IsDescendantOf(Players)
	clearFrame(p1)
	for i = 1, if v1 then 6 else 4 do
		local v3 = ReplicatedStorage.Bounty.Res.PlayerFrame:Clone()
		v3.Visible = true
		v3.LayoutOrder = i
		if v1 then
			v3.Size = UDim2.new(0.28, 0, 0.5, 0)
			v3.BountyText.TextScaled = true
		end
		local v4 = p2[i]
		if v4 then
			v3.NameText.Text = Players:GetPlayerByUserId(v4.UserId).DisplayName
			local v6, v7, v8 = string.match(v4.Bounty, "^([^%d]*%d)(%d*)(.-)$")
			v3.BountyText.Text = "$" .. v6 .. v7:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v8
			v3.ImageLabel.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420"):format(v4.UserId)
		else
			v3:ClearAllChildren()
			v3.BackgroundTransparency = 1
		end
		v3.Parent = p1
	end
end
function t.getTopBounties(p1) --[[ Line: 70 | Upvalues: t (copy) ]]
	local t2 = {}
	for v1, v2 in t.Bounties do
		if p1 <= #t2 then
			break
		end
		table.insert(t2, v2)
	end
	return t2
end
function t.updateBounties() --[[ Line: 81 | Upvalues: t (copy), HttpService (copy), BountyData (copy), CollectionService (copy), BountyConsts (copy) ]]
	table.clear(t.Bounties)
	t.Bounties = HttpService:JSONDecode(BountyData.Value)
	t.onBountiesUpdated:Fire(t.Bounties)
	for v1, v2 in CollectionService:GetTagged(BountyConsts.BOARD_LIST_TAG_NAME) do
		t.updateGui(v2, (t.getTopBounties(4)))
	end
end
return t