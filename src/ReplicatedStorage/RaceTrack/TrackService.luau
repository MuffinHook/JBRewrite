local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {}
local v1, v2 = require(ReplicatedStorage.Roact).createBinding("")
t.screenText = v1
t.updateScreenText = v2
return t