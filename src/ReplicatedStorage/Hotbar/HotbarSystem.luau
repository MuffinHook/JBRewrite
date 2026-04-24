-- Reviewed by Claude
local HotbarItemRes = require(script.Parent.HotbarItemRes)
return {
	init = function()
		require(script.Parent.HotbarItemSystem).init()
	end,
	setColor = function(p1)
		for i, v in ipairs(HotbarItemRes.gui.Container:GetChildren()) do
			if v:IsA(HotbarItemRes.presetFrame.ClassName) then
				v.ImageColor3 = p1
				v.Index.TextColor3 = p1
			end
		end
	end,
	show = function()
		local gui = HotbarItemRes.gui
		if gui then
			gui.Enabled = true
		end
	end,
	hide = function()
		local gui = HotbarItemRes.gui
		if gui then
			gui.Enabled = false
		end
	end
}
