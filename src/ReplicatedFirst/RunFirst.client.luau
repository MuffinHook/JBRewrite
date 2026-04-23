local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local TweenService = game:GetService("TweenService")
if script.Parent == ReplicatedFirst then
	local t = {
		Trade = {
			image = "rbxassetid://9839090323",
			aspectRatio = 2
		},
		Battle = {
			image = "rbxassetid://12668259770",
			aspectRatio = 2
		},
		Jailbreak = {
			image = "rbxassetid://106002273326214",
			aspectRatio = 2
		}
	}
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.DisplayOrder = 50
	local Frame = Instance.new("Frame")
	Frame.Parent = ScreenGui
	Frame.Size = UDim2.new(1, 0, 1, 0)
	Frame.BackgroundTransparency = 0
	Frame.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	Frame.BorderSizePixel = 0
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Size = UDim2.new(0.25, 0, 0.25, 0)
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Parent = ScreenGui
	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.Parent = ImageLabel
	local TextLabel = Instance.new("TextLabel")
	TextLabel.BackgroundTransparency = 1
	TextLabel.Size = UDim2.new(1, 0, 0.085, 0)
	TextLabel.Position = UDim2.new(0, 0, 0.672, 0)
	TextLabel.TextStrokeTransparency = 1
	TextLabel.TextScaled = true
	TextLabel.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	TextLabel.Font = Enum.Font.LuckiestGuy
	TextLabel.Text = ""
	TextLabel.Parent = ScreenGui
	TweenService:Create(ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.In, -1, true), {
		ImageTransparency = 1,
		Size = UDim2.fromScale(0.4, 0.4)
	}):Play()
	local function setTitle(p1) --[[ Line: 59 | Upvalues: UIAspectRatioConstraint (copy), ImageLabel (copy) ]]
		UIAspectRatioConstraint.AspectRatio = p1.aspectRatio
		ImageLabel.Image = p1.image
	end
	local LocalPlayer = Players.LocalPlayer
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local v1 = 0
	local function handleTeleport(p1) --[[ Line: 69 | Upvalues: v1 (ref), TextLabel (copy), t (copy), UIAspectRatioConstraint (copy), ImageLabel (copy), ScreenGui (copy), PlayerGui (copy) ]]
		v1 = v1 + 1
		local v12 = v1
		local v2 = p1 == nil
		local v3 = p1 or {}
		TextLabel.Text = ""
		if v3.tradeLoadingScreen or v3.worldName == "TRADE_WORLD" then
			local Trade = t.Trade
			UIAspectRatioConstraint.AspectRatio = Trade.aspectRatio
			ImageLabel.Image = Trade.image
		elseif v3.battleLoadingScreen then
			local Battle = t.Battle
			UIAspectRatioConstraint.AspectRatio = Battle.aspectRatio
			ImageLabel.Image = Battle.image
		else
			local Jailbreak = t.Jailbreak
			UIAspectRatioConstraint.AspectRatio = Jailbreak.aspectRatio
			ImageLabel.Image = Jailbreak.image
			if v3.migrationLoadingScreen then
				TextLabel.Text = "Server Updating... Please wait!"
			elseif v2 then
				task.delay(7, function() --[[ Line: 86 | Upvalues: ScreenGui (ref), v12 (copy), v1 (ref), TextLabel (ref) ]]
					if ScreenGui.Parent ~= nil and v12 == v1 then
						TextLabel.Text = "Roblox is taking a while to load your data. Please wait."
					end
				end)
			end
		end
		ScreenGui.Parent = PlayerGui
	end
	local v2 = false
	local v3 = TeleportService:GetLocalPlayerTeleportData()
	if v3 then
		ReplicatedFirst:RemoveDefaultLoadingScreen()
		handleTeleport(v3)
	else
		task.delay(3, function() --[[ Line: 102 | Upvalues: v2 (ref), handleTeleport (copy) ]]
			if not v2 then
				handleTeleport()
			end
		end)
	end
	if not game:IsLoaded() then
		game.Loaded:Wait()
	end
	if not LocalPlayer.Character then
		LocalPlayer.CharacterAdded:Wait()
	end
	ScreenGui.Parent = nil
	require(ReplicatedStorage.Std.Maid).new():GiveTask(ReplicatedStorage:WaitForChild(require(ReplicatedStorage.WorldTeleport.WorldTeleportConsts).TELEPORT_HAPPENING_REMOTE).onClientEvent:Connect(function(p1) --[[ Line: 125 | Upvalues: handleTeleport (copy), TeleportService (copy), ScreenGui (copy) ]]
		handleTeleport(p1)
		TeleportService:SetTeleportGui(ScreenGui)
		if not (p1 and p1.migrationLoadingScreen) then
			task.delay(10, function() --[[ Line: 133 | Upvalues: ScreenGui (ref) ]]
				ScreenGui.Parent = nil
			end)
		end
	end))
	TeleportService.TeleportInitFailed:Connect(function(p1) --[[ Line: 139 | Upvalues: LocalPlayer (copy), ScreenGui (copy) ]]
		if p1 == LocalPlayer then
			ScreenGui.Parent = nil
		end
	end)
end