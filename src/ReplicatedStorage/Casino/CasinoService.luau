-- Reviewed by Claude
return {
	init = function()
		require(script.Parent.VaultDoorPuzzleBinder):Start()
		require(script.Parent.CuttableGlassBinder):Start()
		require(script.Parent.CasinoRobberyService).init()
		require(script.Parent.NightclubService).init()
		require(script.Parent.SpinnerBinder):Start()
	end
}