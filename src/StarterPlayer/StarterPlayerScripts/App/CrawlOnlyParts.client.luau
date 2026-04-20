local CollectionService_upvr = game:GetService("CollectionService")
local CharacterUtil_upvr = require(game:GetService("ReplicatedStorage").Game.CharacterUtil)
CollectionService_upvr:GetInstanceAddedSignal("CrawlPassOnly"):Connect(function(arg1) -- Line 7, Named "Added"
    if arg1:IsA("BasePart") then
        arg1.CanCollide = not CharacterUtil_upvr.IsCrawling
    end
end)
for _, v in CollectionService_upvr:GetTagged("CrawlPassOnly") do
    if v:IsA("BasePart") then
        v.CanCollide = not CharacterUtil_upvr.IsCrawling
    end
end
CharacterUtil_upvr.IsCrawlingChanged:Connect(function() -- Line 17
    for _, v_2 in CollectionService_upvr:GetTagged("CrawlPassOnly") do
        if v_2:IsA("BasePart") then
            v_2.CanCollide = not CharacterUtil_upvr.IsCrawling
        end
    end
end)