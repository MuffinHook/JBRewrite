local HotbarItemRes = require(script.Parent.HotbarItemRes)
return {
	init = function() --[[ Name: init | Line: 4 ]]
		require(script.Parent.HotbarItemSystem).init()
	end,
	setColor = function(p1) --[[ Name: setColor | Line: 7 | Upvalues: HotbarItemRes (copy) ]]
		for i, v in ipairs(HotbarItemRes.gui.Container:GetChildren()) do
			if v:IsA(HotbarItemRes.presetFrame.ClassName) then
				v.ImageColor3 = p1
				v.Index.TextColor3 = p1
			end
		end
	end,
	show = function() --[[ Name: show | Line: 16 | Upvalues: HotbarItemRes (copy) ]]
		local gui = HotbarItemRes.gui
		if gui then
			gui.Enabled = true
		end
	end,
	hide = function() --[[ Name: hide | Line: 22 | Upvalues: HotbarItemRes (copy) ]]
		local gui = HotbarItemRes.gui
		if gui then
			gui.Enabled = false
		end
	end
}