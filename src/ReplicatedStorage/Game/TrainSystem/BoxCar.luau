local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local Default = require(script.Parent.Default)
return {
	MakeCar = function(boxCar, configData)
		local Model = boxCar.Model
		CollectionService:AddTag(Model.Model.TrainCargo, "RobberyMarker")
		local Skeleton = Model:FindFirstChild("Skeleton")
		Joint.Weld(Model.Skeleton.LeftDoorClosed, Model.Base)
		Joint.Weld(Model.Skeleton.LeftDoorOpen, Model.Base)
		boxCar.DoorMotor = Joint.BlankMotor(Model.Skeleton.LeftDoor, Model.Skeleton.LeftDoorClosed)
		boxCar.DoorOpenC1 = Model.Skeleton.LeftDoorClosed.CFrame:toObjectSpace(Model.Skeleton.LeftDoorOpen.CFrame)
		Model.Skeleton.LeftDoorClosed.Anchored = false
		Model.Skeleton.LeftDoorOpen.Anchored = false
		Model.Skeleton.LeftDoor.Anchored = false
		Joint.Weld(Model.Skeleton.RightDoorClosed, Model.Base)
		Joint.Weld(Model.Skeleton.RightDoorOpen, Model.Base)
		Joint.BlankMotor(Model.Skeleton.RightDoor, Model.Skeleton.RightDoorClosed)
		Model.Skeleton.RightDoorClosed.Anchored = false
		Model.Skeleton.RightDoorOpen.Anchored = false
		Model.Skeleton.RightDoor.Anchored = false
		Joint.Weld(Model.Skeleton.RoofDoorClosed, Model.Base)
		Joint.Weld(Model.Skeleton.RoofDoorOpen, Model.Base)
		boxCar.RoofDoorMotor = Joint.BlankMotor(Model.Skeleton.RoofDoor, Model.Skeleton.RoofDoorClosed)
		boxCar.RoofDoorOpenC1 = Model.Skeleton.RoofDoorClosed.CFrame:toObjectSpace(Model.Skeleton.RoofDoorOpen.CFrame)
		Model.Skeleton.RoofDoorClosed.Anchored = false
		Model.Skeleton.RoofDoorOpen.Anchored = false
		Model.Skeleton.RoofDoor.Anchored = false
		Joint.WeldAllTo(Skeleton.Vault, Skeleton.Vault.Hinge)
		Joint.Weld(Skeleton.VaultHinge, Model.Base)
		boxCar.VaultMotor = Joint.BlankMotor(Skeleton.Vault.Hinge, Skeleton.VaultHinge)
		Skeleton.VaultHinge.Anchored = false
		boxCar.VaultOpenC1 = CFrame.Angles(0, -math.pi / 2, 0)
		return Default.MakeCar(boxCar)
	end,
	MoveCar = function(boxCar, config, p3, p4)
		local Speed = config.Speed
		return Default.MoveCar(boxCar, config, p3, p4)
	end,
	DestroyCar = function(boxCar)
		return Default.DestroyCar(boxCar)
	end
}
