local HotbarItemRes = require(script.Parent.HotbarItemRes)
return {
	init = function()
		require(script.Parent.HotbarItemSystem).init()
	end,
	setColor = function(color)
		for i, hotbarItem in ipairs(HotbarItemRes.gui.Container:GetChildren()) do
			if hotbarItem:IsA(HotbarItemRes.presetFrame.ClassName) then
				hotbarItem.ImageColor3 = color
				hotbarItem.Index.TextColor3 = color
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
