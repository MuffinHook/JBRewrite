game:GetService("ReplicatedStorage")
local Default = require(script.Parent.Default)
return {
	MakeCar = function(p1) --[[ Name: MakeCar | Line: 4 | Upvalues: Default (copy) ]]
		return Default.MakeCar(p1)
	end,
	MoveCar = function(p1, p2, p3, p4) --[[ Name: MoveCar | Line: 7 | Upvalues: Default (copy) ]]
		if p2.Speed <= 5 and not p2.OpenedVault then
			p2.OpenedVault = true
			local VaultDoorMain = p1.Model.Model:FindFirstChild("VaultDoorMain")
			if not VaultDoorMain then
				error("Missing VaultDoorMain model")
			end
			VaultDoorMain:Destroy()
		end
		return Default.MoveCar(p1, p2, p3, p4)
	end,
	DestroyCar = function(p1) --[[ Name: DestroyCar | Line: 21 | Upvalues: Default (copy) ]]
		return Default.DestroyCar(p1)
	end
}