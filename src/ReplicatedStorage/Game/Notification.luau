
local StarterGui = game:GetService("StarterGui")

local Notification = {}
Notification.__index = Notification
Notification.Queue = {}
Notification.MaxVisibleGraphemes = 120

-- Decomp Error: Notification failed decompilation; rebuilt a minimal compatible notification API.
function Notification.Init(config)
	Notification.Config = config or {}
end

function Notification.getNumOfNotificationsWith(text)
	local count = 0
	for _, item in ipairs(Notification.Queue) do
		if item.Text == text then
			count += 1
		end
	end
	return count
end

function Notification.new(config)
	config = config or {}
	local self = setmetatable(config, Notification)
	table.insert(Notification.Queue, self)
	local text = tostring(config.Text or config.Message or "")
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = tostring(config.Title or "Notification"),
			Text = text,
			Duration = config.Duration or 3,
		})
	end)
	task.delay(config.Duration or 3, function()
		local index = table.find(Notification.Queue, self)
		if index then
			table.remove(Notification.Queue, index)
		end
	end)
	return self
end

function Notification.ProcessQueue() end
function Notification.Hook(callback) Notification.HookCallback = callback end
function Notification.ScaleNotification() end

function Notification.notifyBoss(message, extra)
	return Notification.new({
		Title = "CRIME BOSS ALERT",
		Text = tostring(message or extra or ""),
		Duration = 6,
	})
end

return Notification
