local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local function Added(addedPart)
	if addedPart:IsA("BasePart") then
		addedPart.CanCollide = not CharacterUtil.IsCrawling
	end
end
CollectionService:GetInstanceAddedSignal("CrawlPassOnly"):Connect(Added)
for index, taggedPart in CollectionService:GetTagged("CrawlPassOnly") do
	if taggedPart:IsA("BasePart") then
		taggedPart.CanCollide = not CharacterUtil.IsCrawling
	end
end
CharacterUtil.IsCrawlingChanged:Connect(function()
	for index, taggedPart in CollectionService:GetTagged("CrawlPassOnly") do
		if taggedPart:IsA("BasePart") then
			taggedPart.CanCollide = not CharacterUtil.IsCrawling
		end
	end
end)
