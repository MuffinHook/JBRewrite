local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local function Added(p1) --[[ Line: 7 | Upvalues: CharacterUtil (copy) ]]
	if p1:IsA("BasePart") then
		p1.CanCollide = not CharacterUtil.IsCrawling
	end
end
CollectionService:GetInstanceAddedSignal("CrawlPassOnly"):Connect(Added)
for v1, v2 in CollectionService:GetTagged("CrawlPassOnly") do
	if v2:IsA("BasePart") then
		v2.CanCollide = not CharacterUtil.IsCrawling
	end
end
CharacterUtil.IsCrawlingChanged:Connect(function() --[[ Line: 17 | Upvalues: CollectionService (copy), CharacterUtil (copy) ]]
	for v1, v2 in CollectionService:GetTagged("CrawlPassOnly") do
		if v2:IsA("BasePart") then
			v2.CanCollide = not CharacterUtil.IsCrawling
		end
	end
end)