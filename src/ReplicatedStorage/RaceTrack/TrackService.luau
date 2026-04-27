local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TrackService = {}
local screenTextValue, updateScreenText = require(ReplicatedStorage.Roact).createBinding("")
TrackService.screenText = screenTextValue
TrackService.updateScreenText = updateScreenText
return TrackService
