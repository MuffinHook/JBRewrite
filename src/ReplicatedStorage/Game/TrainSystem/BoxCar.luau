local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local Default = require(script.Parent.Default)
return {
	MakeCar = function(p1, p2) --[[ Name: MakeCar | Line: 6 | Upvalues: CollectionService (copy), Joint (copy), Default (copy) ]]
		local Model = p1.Model
		CollectionService:AddTag(Model.Model.TrainCargo, "RobberyMarker")
		local Skeleton = Model:FindFirstChild("Skeleton")
		Joint.Weld(Model.Skeleton.LeftDoorClosed, Model.Base)
		Joint.Weld(Model.Skeleton.LeftDoorOpen, Model.Base)
		p1.DoorMotor = Joint.BlankMotor(Model.Skeleton.LeftDoor, Model.Skeleton.LeftDoorClosed)
		p1.DoorOpenC1 = Model.Skeleton.LeftDoorClosed.CFrame:toObjectSpace(Model.Skeleton.LeftDoorOpen.CFrame)
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
		p1.RoofDoorMotor = Joint.BlankMotor(Model.Skeleton.RoofDoor, Model.Skeleton.RoofDoorClosed)
		p1.RoofDoorOpenC1 = Model.Skeleton.RoofDoorClosed.CFrame:toObjectSpace(Model.Skeleton.RoofDoorOpen.CFrame)
		Model.Skeleton.RoofDoorClosed.Anchored = false
		Model.Skeleton.RoofDoorOpen.Anchored = false
		Model.Skeleton.RoofDoor.Anchored = false
		Joint.WeldAllTo(Skeleton.Vault, Skeleton.Vault.Hinge)
		Joint.Weld(Skeleton.VaultHinge, Model.Base)
		p1.VaultMotor = Joint.BlankMotor(Skeleton.Vault.Hinge, Skeleton.VaultHinge)
		Skeleton.VaultHinge.Anchored = false
		p1.VaultOpenC1 = CFrame.Angles(0, -1.5707963267948966, 0)
		return Default.MakeCar(p1)
	end,
	MoveCar = function(p1, p2, p3, p4) --[[ Name: MoveCar | Line: 66 | Upvalues: Default (copy) ]]
		local Speed = p2.Speed
		return Default.MoveCar(p1, p2, p3, p4)
	end,
	DestroyCar = function(p1) --[[ Name: DestroyCar | Line: 70 | Upvalues: Default (copy) ]]
		return Default.DestroyCar(p1)
	end
}