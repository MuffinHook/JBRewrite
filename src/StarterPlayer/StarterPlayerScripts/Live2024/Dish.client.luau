local ReplicatedStorage = game:GetService("ReplicatedStorage")
if require(ReplicatedStorage.App.RunUtils).getWorld() ~= require(ReplicatedStorage.App.RunConsts).MAIN_WORLD_NAME then return end