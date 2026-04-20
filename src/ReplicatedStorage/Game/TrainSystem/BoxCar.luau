local Default_upvr = require(script.Parent.Default)
local CollectionService_upvr = game:GetService("CollectionService")
local Joint_upvr = require(game:GetService("ReplicatedStorage").Std.Joint)
return {
    MakeCar = function(arg1, arg2) -- Line 6, Named "MakeCar"
        local Model = arg1.Model
        CollectionService_upvr:AddTag(Model.Model.TrainCargo, "RobberyMarker")
        local Skeleton = Model:FindFirstChild("Skeleton")
        Joint_upvr.Weld(Model.Skeleton.LeftDoorClosed, Model.Base)
        Joint_upvr.Weld(Model.Skeleton.LeftDoorOpen, Model.Base)
        arg1.DoorMotor = Joint_upvr.BlankMotor(Model.Skeleton.LeftDoor, Model.Skeleton.LeftDoorClosed)
        arg1.DoorOpenC1 = Model.Skeleton.LeftDoorClosed.CFrame:toObjectSpace(Model.Skeleton.LeftDoorOpen.CFrame)
        Model.Skeleton.LeftDoorClosed.Anchored = false
        Model.Skeleton.LeftDoorOpen.Anchored = false
        Model.Skeleton.LeftDoor.Anchored = false
        Joint_upvr.Weld(Model.Skeleton.RightDoorClosed, Model.Base)
        Joint_upvr.Weld(Model.Skeleton.RightDoorOpen, Model.Base)
        Joint_upvr.BlankMotor(Model.Skeleton.RightDoor, Model.Skeleton.RightDoorClosed)
        Model.Skeleton.RightDoorClosed.Anchored = false
        Model.Skeleton.RightDoorOpen.Anchored = false
        Model.Skeleton.RightDoor.Anchored = false
        Joint_upvr.Weld(Model.Skeleton.RoofDoorClosed, Model.Base)
        Joint_upvr.Weld(Model.Skeleton.RoofDoorOpen, Model.Base)
        arg1.RoofDoorMotor = Joint_upvr.BlankMotor(Model.Skeleton.RoofDoor, Model.Skeleton.RoofDoorClosed)
        arg1.RoofDoorOpenC1 = Model.Skeleton.RoofDoorClosed.CFrame:toObjectSpace(Model.Skeleton.RoofDoorOpen.CFrame)
        Model.Skeleton.RoofDoorClosed.Anchored = false
        Model.Skeleton.RoofDoorOpen.Anchored = false
        Model.Skeleton.RoofDoor.Anchored = false
        Joint_upvr.WeldAllTo(Skeleton.Vault, Skeleton.Vault.Hinge)
        Joint_upvr.Weld(Skeleton.VaultHinge, Model.Base)
        arg1.VaultMotor = Joint_upvr.BlankMotor(Skeleton.Vault.Hinge, Skeleton.VaultHinge)
        Skeleton.VaultHinge.Anchored = false
        arg1.VaultOpenC1 = CFrame.Angles(0, (-math.pi/2), 0)
        return Default_upvr.MakeCar(arg1)
    end;
    MoveCar = function(arg1, arg2, arg3, arg4) -- Line 66, Named "MoveCar"
        return Default_upvr.MoveCar(arg1, arg2, arg3, arg4)
    end;
    DestroyCar = function(arg1) -- Line 70, Named "DestroyCar"
        return Default_upvr.DestroyCar(arg1)
    end;
}