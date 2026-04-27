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
function t.init()
	t.updateBounties()
	BountyData:GetPropertyChangedSignal("Value"):Connect(t.updateBounties)
end
local function thumbnailBust(userId)
	return ("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420"):format(userId)
end
local function comma(numberStr)
	local prefix, middleDigits, suffix = string.match(numberStr, "^([^%d]*%d)(%d*)(.-)$")
	return prefix .. middleDigits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix
end
local function clearFrame(parentFrame)
	for _, child in parentFrame:GetChildren() do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
end
function t.updateGui(boardFrame, bountiesData)
	local isPlayerFrame = boardFrame:IsDescendantOf(Players)
	clearFrame(boardFrame)
	for i = 1, if isPlayerFrame then 6 else 4 do
		local playerFrame = ReplicatedStorage.Bounty.Res.PlayerFrame:Clone()
		playerFrame.Visible = true
		playerFrame.LayoutOrder = i
		if isPlayerFrame then
			playerFrame.Size = UDim2.new(0.28, 0, 0.5, 0)
			playerFrame.BountyText.TextScaled = true
		end
		local bountyData = bountiesData[i]
		if bountyData then
			playerFrame.NameText.Text = Players:GetPlayerByUserId(bountyData.UserId).DisplayName
			local prefix, middleDigits, suffix = string.match(bountyData.Bounty, "^([^%d]*%d)(%d*)(.-)$")
			playerFrame.BountyText.Text = "$" .. prefix .. middleDigits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix
			playerFrame.ImageLabel.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420"):format(bountyData.UserId)
		else
			playerFrame:ClearAllChildren()
			playerFrame.BackgroundTransparency = 1
		end
		playerFrame.Parent = boardFrame
	end
end
function t.getTopBounties(maxCount)
	local topBounties = {}
	for _, bountyData in t.Bounties do
		if maxCount <= #topBounties then
			break
		end
		table.insert(topBounties, bountyData)
	end
	return topBounties
end
function t.updateBounties()
	table.clear(t.Bounties)
	t.Bounties = HttpService:JSONDecode(BountyData.Value)
	t.onBountiesUpdated:Fire(t.Bounties)
	for _, boardFrame in CollectionService:GetTagged(BountyConsts.BOARD_LIST_TAG_NAME) do
		t.updateGui(boardFrame, (t.getTopBounties(4)))
	end
end
return t