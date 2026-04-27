local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local WorldMarkerGroup = require(script.Parent.WorldMarkerGroup)
local WorldMarkerSystem = {
	Gui = nil,
	_listGroup = {}
}
function WorldMarkerSystem.addGroup(markerGroup)
	assert(markerGroup.__ClassName == WorldMarkerGroup.__ClassName)
	table.insert(WorldMarkerSystem._listGroup, markerGroup)
end
function WorldMarkerSystem.init()
	local WorldMarkersGui = Instance.new("ScreenGui")
	WorldMarkersGui.Name = "WorldMarkersGui"
	WorldMarkersGui.Parent = LocalPlayer.PlayerGui
	WorldMarkersGui.Enabled = true
	WorldMarkersGui.IgnoreGuiInset = true
	WorldMarkerSystem.gui = WorldMarkersGui
	RunService.RenderStepped:Connect(function()
		debug.profilebegin("WorldMarkerSystem Update")
		for i, markerGroup in ipairs(WorldMarkerSystem._listGroup) do
			if markerGroup._enabled then
				markerGroup:Update()
			end
		end
		debug.profileend()
	end)
end
return WorldMarkerSystem
