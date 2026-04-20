return function(arg1, arg2) -- Line 3
    local tbl_2 = {
        hasState = false;
        hasChildren = false;
        Args = {
            Image = 1;
            Size = 2;
            Rect = 3;
            ScaleType = 4;
            ResampleMode = 5;
            TileSize = 6;
            SliceCenter = 7;
            SliceScale = 8;
        };
        Discard = function(arg1_2) -- Line 17, Named "Discard"
            arg1_2.Instance:Destroy()
        end;
    }
    local tbl = {
        Events = {
            hovered = arg2.EVENTS.hover(function(arg1_3) -- Line 25
                return arg1_3.Instance
            end);
        };
    }
    local function Generate(arg1_4) -- Line 29
        local ImageLabel_3 = Instance.new("ImageLabel")
        ImageLabel_3.Name = "Iris_Image"
        ImageLabel_3.BackgroundTransparency = 1
        ImageLabel_3.BorderSizePixel = 0
        ImageLabel_3.ImageColor3 = arg1._config.ImageColor
        ImageLabel_3.ImageTransparency = arg1._config.ImageTransparency
        arg2.applyFrameStyle(ImageLabel_3, true)
        return ImageLabel_3
    end
    tbl.Generate = Generate
    local function Update(arg1_5) -- Line 41
        local Instance = arg1_5.Instance
        local Image_2 = arg1_5.arguments.Image
        if not Image_2 then
            Image_2 = arg2
            Image_2 = Image_2.ICONS
            Image_2 = Image_2.UNKNOWN_TEXTURE
        end
        Instance.Image = Image_2
        Instance.Size = arg1_5.arguments.Size
        if arg1_5.arguments.ScaleType then
            Instance.ScaleType = arg1_5.arguments.ScaleType
            if arg1_5.arguments.ScaleType == Enum.ScaleType.Tile and arg1_5.arguments.TileSize then
                Instance.TileSize = arg1_5.arguments.TileSize
            elseif arg1_5.arguments.ScaleType == Enum.ScaleType.Slice then
                if arg1_5.arguments.SliceCenter then
                    Instance.SliceCenter = arg1_5.arguments.SliceCenter
                end
                if arg1_5.arguments.SliceScale then
                    Instance.SliceScale = arg1_5.arguments.SliceScale
                end
            end
        end
        if arg1_5.arguments.Rect then
            Instance.ImageRectOffset = arg1_5.arguments.Rect.Min
            Instance.ImageRectSize = Vector2.new(arg1_5.arguments.Rect.Width, arg1_5.arguments.Rect.Height)
        end
        if arg1_5.arguments.ResampleMode then
            Instance.ResampleMode = arg1_5.arguments.ResampleMode
        end
    end
    tbl.Update = Update
    arg1.WidgetConstructor("Image", arg2.extend(tbl_2, tbl))
    local tbl_3 = {
        Events = {
            clicked = arg2.EVENTS.click(function(arg1_6) -- Line 75
                return arg1_6.Instance
            end);
            rightClicked = arg2.EVENTS.rightClick(function(arg1_7) -- Line 78
                return arg1_7.Instance
            end);
            doubleClicked = arg2.EVENTS.doubleClick(function(arg1_8) -- Line 81
                return arg1_8.Instance
            end);
            ctrlClicked = arg2.EVENTS.ctrlClick(function(arg1_9) -- Line 84
                return arg1_9.Instance
            end);
            hovered = arg2.EVENTS.hover(function(arg1_10) -- Line 87
                return arg1_10.Instance
            end);
        };
    }
    function tbl_3.Generate(arg1_11) -- Line 91
        local ImageButton = Instance.new("ImageButton")
        ImageButton.Name = "Iris_ImageButton"
        ImageButton.AutomaticSize = Enum.AutomaticSize.XY
        ImageButton.BackgroundColor3 = arg1._config.FrameBgColor
        ImageButton.BackgroundTransparency = arg1._config.FrameBgTransparency
        ImageButton.BorderSizePixel = 0
        ImageButton.Image = ""
        ImageButton.ImageTransparency = 1
        ImageButton.AutoButtonColor = false
        arg2.applyFrameStyle(ImageButton, true)
        arg2.UIPadding(ImageButton, Vector2.new(arg1._config.ImageBorderSize, arg1._config.ImageBorderSize))
        local ImageLabel_2 = Instance.new("ImageLabel")
        ImageLabel_2.Name = "ImageLabel"
        ImageLabel_2.BackgroundTransparency = 1
        ImageLabel_2.BorderSizePixel = 0
        ImageLabel_2.ImageColor3 = arg1._config.ImageColor
        ImageLabel_2.ImageTransparency = arg1._config.ImageTransparency
        ImageLabel_2.Parent = ImageButton
        arg2.applyInteractionHighlights("Background", ImageButton, ImageButton, {
            Color = arg1._config.FrameBgColor;
            Transparency = arg1._config.FrameBgTransparency;
            HoveredColor = arg1._config.FrameBgHoveredColor;
            HoveredTransparency = arg1._config.FrameBgHoveredTransparency;
            ActiveColor = arg1._config.FrameBgActiveColor;
            ActiveTransparency = arg1._config.FrameBgActiveTransparency;
        })
        return ImageButton
    end
    function tbl_3.Update(arg1_12) -- Line 124
        local ImageLabel = arg1_12.Instance.ImageLabel
        local Image = arg1_12.arguments.Image
        if not Image then
            Image = arg2
            Image = Image.ICONS
            Image = Image.UNKNOWN_TEXTURE
        end
        ImageLabel.Image = Image
        ImageLabel.Size = arg1_12.arguments.Size
        if arg1_12.arguments.ScaleType then
            ImageLabel.ScaleType = arg1_12.arguments.ScaleType
            if arg1_12.arguments.ScaleType == Enum.ScaleType.Tile and arg1_12.arguments.TileSize then
                ImageLabel.TileSize = arg1_12.arguments.TileSize
            elseif arg1_12.arguments.ScaleType == Enum.ScaleType.Slice then
                if arg1_12.arguments.SliceCenter then
                    ImageLabel.SliceCenter = arg1_12.arguments.SliceCenter
                end
                if arg1_12.arguments.SliceScale then
                    ImageLabel.SliceScale = arg1_12.arguments.SliceScale
                end
            end
        end
        if arg1_12.arguments.Rect then
            ImageLabel.ImageRectOffset = arg1_12.arguments.Rect.Min
            ImageLabel.ImageRectSize = Vector2.new(arg1_12.arguments.Rect.Width, arg1_12.arguments.Rect.Height)
        end
        if arg1_12.arguments.ResampleMode then
            ImageLabel.ResampleMode = arg1_12.arguments.ResampleMode
        end
    end
    arg1.WidgetConstructor("ImageButton", arg2.extend(tbl_2, tbl_3))
end