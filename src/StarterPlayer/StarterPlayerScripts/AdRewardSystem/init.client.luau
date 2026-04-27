local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local AdRewardsController = require(script:WaitForChild("AdRewardsController"))
local WatchAdButtonController = require(script:WaitForChild("WatchAdButtonController"))
if script:WaitForChild("ServiceActive").Value == true and RunUtils.isMainWorld() then
	task.wait(5)
	AdRewardsController.Init(WatchAdButtonController)
end
