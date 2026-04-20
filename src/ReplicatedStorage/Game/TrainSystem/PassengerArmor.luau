local Default_upvr = require(script.Parent.Default)
return {
    MakeCar = function(arg1) -- Line 4, Named "MakeCar"
        return Default_upvr.MakeCar(arg1)
    end;
    MoveCar = function(arg1, arg2, arg3, arg4) -- Line 7, Named "MoveCar"
        if arg2.Speed <= 5 and not arg2.OpenedVault then
            arg2.OpenedVault = true
            local VaultDoorMain = arg1.Model.Model:FindFirstChild("VaultDoorMain")
            if not VaultDoorMain then
                error("Missing VaultDoorMain model")
            end
            VaultDoorMain:Destroy()
        end
        return Default_upvr.MoveCar(arg1, arg2, arg3, arg4)
    end;
    DestroyCar = function(arg1) -- Line 21, Named "DestroyCar"
        return Default_upvr.DestroyCar(arg1)
    end;
}