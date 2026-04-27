game:GetService("ReplicatedStorage")
local Default = require(script.Parent.Default)
return {
	MakeCar = function(carModel)
		return Default.MakeCar(carModel)
	end,
	MoveCar = function(carInstance, carData, deltaTime, direction)
		if carData.Speed <= 5 and not carData.OpenedVault then
			carData.OpenedVault = true
			local VaultDoorMain = carInstance.Model.Model:FindFirstChild("VaultDoorMain")
			if not VaultDoorMain then
				error("Missing VaultDoorMain model")
			end
			VaultDoorMain:Destroy()
		end
		return Default.MoveCar(carInstance, carData, deltaTime, direction)
	end,
	DestroyCar = function(carToDestroy)
		return Default.DestroyCar(carToDestroy)
	end
}
