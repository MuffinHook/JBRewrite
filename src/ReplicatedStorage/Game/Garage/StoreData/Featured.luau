local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	GetItems = require(ReplicatedStorage.Sale.SaleShared).getOnSaleVehicleCustomizations
}