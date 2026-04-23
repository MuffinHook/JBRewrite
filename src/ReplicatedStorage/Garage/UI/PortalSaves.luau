local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local PortalBase = require(script.Parent.PortalBase)
local v1 = Roact.PureComponent:extend("PortalSaves")
function v1.render(p1) --[[ Line: 11 | Upvalues: createElement (copy), PortalBase (copy) ]]
	local t = {}
	local t2 = {}
	for i, v in ipairs(p1.props.receipt) do
		t[v.name] = true
	end
	for i = 1, #p1.props.items do
		local v1, v2
		local v3 = p1.props.items[i]
		local v4 = p1.props.saves[v3.name]
		local t3 = {
			selected = t[v3.name]
		}
		v1 = v4 ~= nil
		t3.filled = v1
		t3.getInstCompare = v4
		v2 = v4 and function() --[[ Line: 24 | Upvalues: v3 (copy), v4 (copy) ]]
			return v3.getInstForSelection(v4)
		end
		t3.getInst = v2
		function t3.onSelect() --[[ Line: 28 | Upvalues: v3 (copy), p1 (copy) ]]
			if v3.available then
				p1.props.onSelectItem(v3)
			end
		end
		t2[i] = t3
	end
	return createElement(PortalBase, {
		title = "SAVES",
		items = p1.props.items,
		metadata = t2,
		sortId = p1.props.sortId,
		colsPerRow = 5,
		rowsPerPage = 2,
		cornerPixel = p1.props.cornerPixel,
		portalRatio = p1.props.portalRatio,
		paddingRatio = p1.props.paddingRatio,
		onSelectSort = p1.props.onSelectSort
	})
end
return RoactRodux.connect(function(p1, p2) --[[ Line: 50 ]]
	return {
		receipt = p1.garageReceipt
	}
end, function(p1) --[[ Line: 54 | Upvalues: Players (copy), Audio (copy) ]]
	return {
		onSelectItem = function(p12) --[[ Name: onSelectItem | Line: 56 | Upvalues: Players (ref), Audio (ref), p1 (copy) ]]
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.25
				})
			end
			p1({
				type = "addReceiptItem",
				category = "Saves",
				categoryTitle = "Save",
				name = p12.name,
				title = p12.title,
				filled = p12.filled
			})
		end
	}
end)(v1)