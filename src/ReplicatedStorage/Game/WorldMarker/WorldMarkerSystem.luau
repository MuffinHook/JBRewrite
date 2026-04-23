local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local WorldMarkerGroup = require(script.Parent.WorldMarkerGroup)
local t = {
	Gui = nil,
	_listGroup = {}
}
function t.addGroup(p1) --[[ Line: 10 | Upvalues: WorldMarkerGroup (copy), t (copy) ]]
	assert(p1.__ClassName == WorldMarkerGroup.__ClassName)
	table.insert(t._listGroup, p1)
end
function t.init() --[[ Line: 14 | Upvalues: LocalPlayer (copy), t (copy), RunService (copy) ]]
	local WorldMarkersGui = Instance.new("ScreenGui")
	WorldMarkersGui.Name = "WorldMarkersGui"
	WorldMarkersGui.Parent = LocalPlayer.PlayerGui
	WorldMarkersGui.Enabled = true
	WorldMarkersGui.IgnoreGuiInset = true
	t.gui = WorldMarkersGui
	RunService.RenderStepped:Connect(function() --[[ Line: 22 | Upvalues: t (ref) ]]
		debug.profilebegin("WorldMarkerSystem Update")
		for i, v in ipairs(t._listGroup) do
			if v._enabled then
				v:Update()
			end
		end
		debug.profileend()
	end)
end
return t