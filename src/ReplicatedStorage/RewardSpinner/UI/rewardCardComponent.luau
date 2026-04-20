local ReplicatedStorage = game:GetService("ReplicatedStorage")
local createElement_upvr = require(ReplicatedStorage.Roact).createElement
local ViewportFrame_upvr = require(ReplicatedStorage.EzUi.ViewportFrame)
return function(arg1) -- Line 12
    local aspectRatio = arg1.aspectRatio
    local var6 = arg1.backGlowEnabled or false
    local bubbleColor = arg1.bubbleColor
    local var8
    if arg1.getInst ~= nil then
        var8 = createElement_upvr(ViewportFrame_upvr, {
            backgroundColor = bubbleColor;
            backgroundTransparency = 0;
            getInst = arg1.getInst;
            getInstCompare = arg1.getInstCompare;
            updateCamera = arg1.updateCamera;
            size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0);
            position = UDim2.new(0.5, 0, 0.5, 0);
            anchorPoint = Vector2.new(0.5, 0.5);
            zIndex = 2;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1, 0);
            });
        })
    else
        var8 = createElement_upvr("Frame", {
            BackgroundColor3 = bubbleColor;
            Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            ZIndex = 2;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1, 0);
            });
            Icon = createElement_upvr("ImageLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(0.9, 0, 0.9, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Image = arg1.image;
            });
        })
    end
    local module = {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Size = arg1.size;
    }
    local position = arg1.position
    module.Position = position
    if var6 then
        position = 2
    else
        position = 1
    end
    module.ZIndex = position
    local module_2 = {
        BackGlow = createElement_upvr("ImageLabel", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://10046133665";
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            Size = UDim2.new(1.5 / aspectRatio, 0, 1.5, 0);
            ImageColor3 = bubbleColor;
            ZIndex = 1;
            Visible = var6;
        });
    }
    local tbl = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, arg1.cornerPixel);
        });
        FrontGlow = createElement_upvr("ImageLabel", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://10046133665";
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            Size = UDim2.new(1.1 / aspectRatio, 0, 1.1, 0);
            ImageTransparency = 0.5;
            ImageColor3 = bubbleColor;
            Visible = arg1.frontGlowEnabled or false;
        });
        Circle = var8;
    }
    local owned = arg1.owned
    if owned then
        owned = createElement_upvr
        owned = owned("ImageLabel", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://8724615287";
            ImageColor3 = Color3.new(0, 1, 0);
            Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            ZIndex = 3;
        })
    end
    tbl.Owned = owned
    tbl.Type = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.5, 0, 0.1, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = UDim2.new(0.5, 0, 0.075, 0);
        ZIndex = 3;
    }, {
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Text = arg1.typeTitle;
            Font = Enum.Font.Bangers;
            LineHeight = 1;
            TextScaled = true;
            TextColor3 = Color3.new(0.5, 0.5, 0.5);
        });
    })
    local var29 = false
    if arg1.subTitle ~= nil then
        var29 = createElement_upvr
        var29 = var29("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(0.5, 0, 0.1, 0);
            AnchorPoint = Vector2.new(0.5, 1);
            Position = UDim2.new(0.5, 0, 0.795, 0);
            ZIndex = 3;
        }, {
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1.25, 0, 1.25, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = arg1.subTitle;
                Font = Enum.Font.Bangers;
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
            });
        })
    end
    tbl.SubTitle = var29
    tbl.Title = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.8, 0, 0.125, 0);
        AnchorPoint = Vector2.new(0.5, 1);
        Position = UDim2.new(0.5, 0, 0.92, 0);
        ZIndex = 3;
    }, {
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1.25, 0, 1.25, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Text = arg1.title;
            Font = Enum.Font.Bangers;
            LineHeight = 1;
            TextScaled = true;
            TextColor3 = Color3.new(1, 1, 1);
        });
    })
    tbl.Rarity = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.5, 0, 0.08, 0);
        AnchorPoint = Vector2.new(0.5, 1);
        Position = UDim2.new(0.5, 0, 1, 0);
        ZIndex = 3;
    }, {
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1.25, 0, 1.25, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Text = arg1.rarityTitle;
            Font = Enum.Font.Bangers;
            LineHeight = 1;
            TextScaled = true;
            TextColor3 = bubbleColor;
        });
    })
    module_2.Card = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 2;
    }, tbl)
    return createElement_upvr("Frame", module, module_2)
end