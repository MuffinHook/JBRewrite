require(script.Parent.Types)
return function(irisContext)
	local irisAPI = irisContext
	local showBackgroundState = irisContext.State(true)
	local showWindowState = irisContext.State(false)
	local showTreeState = irisContext.State(false)
	local showButtonState = irisContext.State(false)
	local showInputState = irisContext.State(false)
	local showDragState = irisContext.State(false)
	local showComboState = irisContext.State(false)
	local showBackgroundFrameState = irisContext.State(false)
	local backgroundColorState = irisContext.State(Color3.fromRGB(115, 140, 152))
	local backgroundTransparencyState = irisContext.State(0)

	-- Restored decompiler-lost upvalues.
	-- Kept the original decompiled function/local names below.
	local instance = showBackgroundState
	local vector2 = showWindowState
	local instance3 = showTreeState
	local var4 = showButtonState
	local var5 = showInputState
	local func6 = showDragState
	local var7 = showComboState
	local var8 = showBackgroundFrameState
	local var9 = backgroundColorState
	local var10 = backgroundTransparencyState
	table.insert(irisContext.Internal._initFunctions, function()
		local Background = Instance.new("Frame")
		Background.Name = "Background"
		Background.Size = UDim2.fromScale(1, 1)
		Background.BackgroundColor3 = backgroundColorState.value
		Background.BackgroundTransparency = backgroundTransparencyState.value
		local Iris_Background
		if irisContext._config.UseScreenGUIs then
			Iris_Background = Instance.new("ScreenGui")
			Iris_Background.Name = "Iris_Background"
			Iris_Background.IgnoreGuiInset = true
			Iris_Background.DisplayOrder = irisContext._config.DisplayOrderOffset - 1
			Iris_Background.ScreenInsets = Enum.ScreenInsets.None
			Iris_Background.Enabled = true
			Background.Parent = Iris_Background
		else
			Background.ZIndex = irisContext._config.DisplayOrderOffset - 1
			Iris_Background = Background
		end
		backgroundColorState:onChange(function(newColor)
			Background.BackgroundColor3 = newColor
		end)
		backgroundTransparencyState:onChange(function(newTransparency)
			Background.BackgroundTransparency = newTransparency
		end)
		showBackgroundFrameState:onChange(function(shouldShow)
			if shouldShow then
				Iris_Background.Parent = irisContext.Internal.parentInstance
			else
				Iris_Background.Parent = nil
			end
		end)
	end)
	local function helpMarker(tooltipText)
		irisAPI.PushConfig({
			TextColor = irisAPI._config.TextDisabledColor
		})
		local helpTextElement = irisAPI.Text({ "(?)" })
		irisAPI.PopConfig()
		irisAPI.PushConfig({
			ContentWidth = UDim.new(0, 350)
		})
		if helpTextElement.hovered() then
			irisAPI.Tooltip({ tooltipText })
		end
		irisAPI.PopConfig()
	end
	local function textAndHelpMarker(textContent, helpTooltip)
		irisAPI.SameLine()
		irisAPI.Text({ textContent })
		helpMarker(helpTooltip)
		irisAPI.End()
	end
	local widgetDemosMap = {
		Basic = function()
			irisAPI.Tree({ "Basic" })
			irisAPI.SeparatorText({ "Basic" })
			local selectedIndex = irisAPI.State(1)
			irisAPI.Button({ "Button" })
			irisAPI.SmallButton({ "SmallButton" })
			irisAPI.Text({ "Text" })
			irisAPI.TextWrapped({ string.rep("Text Wrapped ", 5) })
			irisAPI.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) })
			irisAPI.Text({ "Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>", true, nil, true })
			irisAPI.SameLine()
			irisAPI.RadioButton({ "Index \'1\'", 1 }, {
				index = selectedIndex
			})
			irisAPI.RadioButton({ "Index \'two\'", "two" }, {
				index = selectedIndex
			})
			if irisAPI.RadioButton({ "Index \'false\'", false }, {
				index = selectedIndex
			}).active() == false and irisAPI.SmallButton({ "Select last" }).clicked() then
				selectedIndex:set(false)
			end
			irisAPI.End()
			local displayText = {}
			displayText[1] = "The Index is: " .. tostring(selectedIndex.value)
			irisAPI.Text(displayText)
			irisAPI.SeparatorText({ "Inputs" })
			irisAPI.InputNum({})
			irisAPI.DragNum({})
			irisAPI.SliderNum({})
			irisAPI.End()
		end,
		Image = function()
			irisAPI.Tree({ "Image" })
			irisAPI.SeparatorText({ "Image Controls" })
			local imageAssetPath = irisAPI.State("rbxasset://textures/ui/common/robux.png")
			local imageSize = irisAPI.State(UDim2.fromOffset(100, 100))
			local imageRect = irisAPI.State(Rect.new(0, 0, 0, 0))
			local scaleType = irisAPI.State(Enum.ScaleType.Stretch)
			local isPixelated = irisAPI.State(false)
			local resamplerMode = irisAPI.ComputedState(isPixelated, function(pixelated)
				return pixelated and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default
			end)
			local imageTintColor = irisAPI.State(irisAPI._config.ImageColor)
			local imageTransparency = irisAPI.State(irisAPI._config.ImageTransparency)
			irisAPI.InputColor4({ "Image Tint" }, {
				color = imageTintColor,
				transparency = imageTransparency
			})
			irisAPI.Combo({ "Asset" }, {
				index = imageAssetPath
			})
			irisAPI.Selectable({ "Robux Small", "rbxasset://textures/ui/common/robux.png" }, {
				index = imageAssetPath
			})
			irisAPI.Selectable({ "Robux Large", "rbxasset://textures//ui/common/robux@3x.png" }, {
				index = imageAssetPath
			})
			irisAPI.Selectable({ "Loading Texture", "rbxasset://textures//loading/darkLoadingTexture.png" }, {
				index = imageAssetPath
			})
			irisAPI.Selectable({ "Hue-Saturation Gradient", "rbxasset://textures//TagEditor/huesatgradient.png" }, {
				index = imageAssetPath
			})
			irisAPI.Selectable({ "famfamfam.png (WHY?)", "rbxasset://textures//TagEditor/famfamfam.png" }, {
				index = imageAssetPath
			})
			irisAPI.End()
			irisAPI.SliderUDim2({
				"Image Size",
				nil,
				nil,
				UDim2.new(1, 240, 1, 240)
			}, {
				number = imageSize
			})
			irisAPI.SliderRect({
				"Image Rect",
				nil,
				nil,
				Rect.new(256, 256, 256, 256)
			}, {
				number = imageRect
			})
			irisAPI.Combo({ "Scale Type" }, {
				index = scaleType
			})
			irisAPI.Selectable({ "Stretch", Enum.ScaleType.Stretch }, {
				index = scaleType
			})
			irisAPI.Selectable({ "Fit", Enum.ScaleType.Fit }, {
				index = scaleType
			})
			irisAPI.Selectable({ "Crop", Enum.ScaleType.Crop }, {
				index = scaleType
			})
			irisAPI.End()
			irisAPI.Checkbox({ "Pixelated" }, {
				isChecked = isPixelated
			})
			irisAPI.PushConfig({
				ImageColor = imageTintColor:get(),
				ImageTransparency = imageTransparency:get()
			})
			irisAPI.Image({
				imageAssetPath:get(),
				imageSize:get(),
				imageRect:get(),
				scaleType:get(),
				resamplerMode:get()
			})
			irisAPI.PopConfig()
			irisAPI.SeparatorText({ "Tile" })
			local tileSize = irisAPI.State(UDim2.fromScale(0.5, 0.5))
			irisAPI.SliderUDim2({
				"Tile Size",
				nil,
				nil,
				UDim2.new(1, 240, 1, 240)
			}, {
				number = tileSize
			})
			irisAPI.PushConfig({
				ImageColor = imageTintColor:get(),
				ImageTransparency = imageTransparency:get()
			})
			irisAPI.Image({
				"rbxasset://textures/grid2.png",
				imageSize:get(),
				nil,
				Enum.ScaleType.Tile,
				resamplerMode:get(),
				tileSize:get()
			})
			irisAPI.PopConfig()
			irisAPI.SeparatorText({ "Slice" })
			local sliceScale = irisAPI.State(1)
			irisAPI.SliderNum({ "Image Slice Scale", 0.1, 0.1, 5 }, {
				number = sliceScale
			})
			irisAPI.PushConfig({
				ImageColor = imageTintColor:get(),
				ImageTransparency = imageTransparency:get()
			})
			irisAPI.Image({
				"rbxasset://textures/ui/chatBubble_blue_notify_bkg.png",
				imageSize:get(),
				nil,
				Enum.ScaleType.Slice,
				resamplerMode:get(),
				nil,
				Rect.new(12, 12, 56, 56),
				1
			}, sliceScale:get())
			irisAPI.PopConfig()
			irisAPI.SeparatorText({ "Image Button" })
			local clickCount = irisAPI.State(0)
			irisAPI.SameLine()
			irisAPI.PushConfig({
				ImageColor = imageTintColor:get(),
				ImageTransparency = imageTransparency:get()
			})
			if irisAPI.ImageButton({ "rbxasset://textures/AvatarCompatibilityPreviewer/add.png", UDim2.fromOffset(20, 20) }).clicked() then
				clickCount:set(clickCount.value + 1)
			end
			irisAPI.PopConfig()
			irisAPI.Text({ (("Click count: %s"):format(clickCount.value)) })
			irisAPI.End()
			irisAPI.End()
		end,
		Selectable = function()
			irisAPI.Tree({ "Selectable" })
			local selectableIndex = irisAPI.State(2)
			irisAPI.Selectable({ "Selectable #1", 1 }, {
				index = selectableIndex
			})
			irisAPI.Selectable({ "Selectable #2", 2 }, {
				index = selectableIndex
			})
			if irisAPI.Selectable({ "Double click Selectable", 3, true }, {
				index = selectableIndex
			}).doubleClicked() then
				selectableIndex:set(3)
			end
			irisAPI.Selectable({ "Impossible to select", 4, true }, {
				index = selectableIndex
			})
			if irisAPI.Button({ "Select last" }).clicked() then
				selectableIndex:set(4)
			end
			irisAPI.Selectable({ "Independent Selectable" })
			irisAPI.End()
		end,
		Combo = function()
			irisAPI.Tree({ "Combo" })
			irisAPI.PushConfig({
				ContentWidth = UDim.new(1, -200)
			})
			local comboSelection = irisAPI.State("No Selection")
			irisAPI.SameLine()
			local noPreviewCheckbox = irisAPI.Checkbox({ "No Preview" })
			local noButtonCheckbox = irisAPI.Checkbox({ "No Button" })
			if noPreviewCheckbox.checked() and noButtonCheckbox.isChecked.value == true then
				noButtonCheckbox.isChecked:set(false)
			end
			local currentButtonCheckbox = noButtonCheckbox
			if currentButtonCheckbox.checked() and noPreviewCheckbox.isChecked.value == true then
				noPreviewCheckbox.isChecked:set(false)
			end
			irisAPI.End()
			irisAPI.Combo({ "Basic Usage", currentButtonCheckbox.isChecked:get(), noPreviewCheckbox.isChecked:get() }, {
				index = comboSelection
			})
			irisAPI.Selectable({ "Select 1", "One" }, {
				index = comboSelection
			})
			irisAPI.Selectable({ "Select 2", "Two" }, {
				index = comboSelection
			})
			irisAPI.Selectable({ "Select 3", "Three" }, {
				index = comboSelection
			})
			irisAPI.End()
			irisAPI.ComboArray({ "Using ComboArray" }, {
				index = "No Selection"
			}, { "Red", "Green", "Blue" })
			local comboArrayItems = {}
			for i = 1, 50 do
				table.insert(comboArrayItems, (tostring(i)))
			end
			irisAPI.ComboArray({ "Height Test" }, {
				index = "1"
			}, comboArrayItems)
			local selectedShift = irisAPI.State("7 AM")
			irisAPI.Combo({ "Combo with Inner widgets" }, {
				index = selectedShift
			})
			irisAPI.Tree({ "Morning Shifts" })
			irisAPI.Selectable({ "Shift at 7 AM", "7 AM" }, {
				index = selectedShift
			})
			irisAPI.Selectable({ "Shift at 11 AM", "11 AM" }, {
				index = selectedShift
			})
			irisAPI.Selectable({ "Shift at 3 PM", "3 PM" }, {
				index = selectedShift
			})
			irisAPI.End()
			irisAPI.Tree({ "Night Shifts" })
			irisAPI.Selectable({ "Shift at 6 PM", "6 PM" }, {
				index = selectedShift
			})
			irisAPI.Selectable({ "Shift at 9 PM", "9 PM" }, {
				index = selectedShift
			})
			irisAPI.End()
			irisAPI.End()
			irisAPI.Text({ "Selected: " .. irisAPI.ComboEnum({ "Using ComboEnum" }, {
					index = Enum.UserInputState.Begin
				}, Enum.UserInputState).index:get().Name })
			irisAPI.PopConfig()
			irisAPI.End()
		end,
		Tree = function()
			irisAPI.Tree({ "Trees" })
			irisAPI.Tree({ "Tree using SpanAvailWidth", true })
			helpMarker("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area")
			irisAPI.End()
			local treeElement = irisAPI.Tree({ "Tree with Children" })
			irisAPI.Text({ "Im inside the first tree!" })
			irisAPI.Button({ "Im a button inside the first tree!" })
			irisAPI.Tree({ "Im a tree inside the first tree!" })
			irisAPI.Text({ "I am the innermost text!" })
			irisAPI.End()
			irisAPI.End()
			irisAPI.Checkbox({ "Toggle above tree" }, {
				isChecked = treeElement.state.isUncollapsed
			})
			irisAPI.End()
		end,
		CollapsingHeader = function()
			irisAPI.Tree({ "Collapsing Headers" })
			irisAPI.CollapsingHeader({ "A header" })
			irisAPI.Text({ "This is under the first header!" })
			irisAPI.End()
			local headerState = irisAPI.State(false)
			irisAPI.CollapsingHeader({ "Another header" }, {
				isUncollapsed = headerState
			})
			if irisAPI.Button({ "Shhh... secret button!" }).clicked() then
				headerState:set(true)
			end
			irisAPI.End()
			irisAPI.End()
		end,
		Group = function()
			irisAPI.Tree({ "Groups" })
			irisAPI.SameLine()
			irisAPI.Group()
			irisAPI.Text({ "I am in group A" })
			irisAPI.Button({ "Im also in A" })
			irisAPI.End()
			irisAPI.Separator()
			irisAPI.Group()
			irisAPI.Text({ "I am in group B" })
			irisAPI.Button({ "Im also in B" })
			irisAPI.Button({ "Also group B" })
			irisAPI.End()
			irisAPI.End()
			irisAPI.End()
		end,
		Tab = function()
			irisAPI.Tree({ "Tabs" })
			irisAPI.Tree({ "Simple" })
			irisAPI.TabBar()
			irisAPI.Tab({ "Apples" })
			irisAPI.Text({ "Who loves apples?" })
			irisAPI.End()
			irisAPI.Tab({ "Broccoli" })
			irisAPI.Text({ "And what about broccoli?" })
			irisAPI.End()
			irisAPI.Tab({ "Carrots" })
			irisAPI.Text({ "But carrots are the best." })
			irisAPI.End()
			irisAPI.End()
			irisAPI.Separator()
			irisAPI.Text({ "Very important questions." })
			irisAPI.End()
			irisAPI.Tree({ "Closable" })
			local appleTabOpen = irisAPI.State(true)
			local broccoliTabOpen = irisAPI.State(true)
			local carrotTabOpen = irisAPI.State(true)
			irisAPI.TabBar()
			irisAPI.Tab({ "\240\159\141\142", true }, {
				isOpened = appleTabOpen
			})
			irisAPI.Text({ "Who loves apples?" })
			if irisAPI.Button({ "I don\'t like apples." }).clicked() then
				appleTabOpen:set(false)
			end
			irisAPI.End()
			irisAPI.Tab({ "\240\159\165\166", true }, {
				isOpened = broccoliTabOpen
			})
			irisAPI.Text({ "And what about broccoli?" })
			if irisAPI.Button({ "Not for me." }).clicked() then
				broccoliTabOpen:set(false)
			end
			irisAPI.End()
			irisAPI.Tab({ "\240\159\165\149", true }, {
				isOpened = carrotTabOpen
			})
			irisAPI.Text({ "But carrots are the best." })
			if irisAPI.Button({ "I disagree with you." }).clicked() then
				carrotTabOpen:set(false)
			end
			irisAPI.End()
			irisAPI.End()
			irisAPI.Separator()
			if irisAPI.Button({ "Actually, let me reconsider it." }).clicked() then
				appleTabOpen:set(true)
				broccoliTabOpen:set(true)
				carrotTabOpen:set(true)
			end
			irisAPI.End()
			irisAPI.End()
		end,
		Indent = function()
			irisAPI.Tree({ "Indents" })
			irisAPI.Text({ "Not Indented" })
			irisAPI.Indent()
			irisAPI.Text({ "Indented" })
			irisAPI.Indent({ 7 })
			irisAPI.Text({ "Indented by 7 more pixels" })
			irisAPI.End()
			irisAPI.Indent({ -7 })
			irisAPI.Text({ "Indented by 7 less pixels" })
			irisAPI.End()
			irisAPI.End()
			irisAPI.End()
		end,
		Input = function()
			irisAPI.Tree({ "Input" })
			local noFieldChecked = irisAPI.State(false)
			local noButtonsChecked = irisAPI.State(false)
			local minValue = irisAPI.State(0)
			local maxValue = irisAPI.State(100)
			local incrementValue = irisAPI.State(1)
			local formatString = irisAPI.State("%d")
			irisAPI.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			local inputNumResult = irisAPI.InputNum({
				[irisAPI.Args.InputNum.Text] = "Input Number",
				[irisAPI.Args.InputNum.NoButtons] = noButtonsChecked.value,
				[irisAPI.Args.InputNum.Min] = minValue.value,
				[irisAPI.Args.InputNum.Max] = maxValue.value,
				[irisAPI.Args.InputNum.Increment] = incrementValue.value,
				[irisAPI.Args.InputNum.Format] = { formatString.value }
			})
			irisAPI.PopConfig()
			irisAPI.Text({ "The Value is: " .. inputNumResult.number.value })
			if irisAPI.Button({ "Randomize Number" }).clicked() then
				inputNumResult.number:set(math.random(1, 99))
			end
			local noFieldCheckbox = irisAPI.Checkbox({ "NoField" }, {
				isChecked = noFieldChecked
			})
			local noButtonsCheckbox = irisAPI.Checkbox({ "NoButtons" }, {
				isChecked = noButtonsChecked
			})
			if noFieldCheckbox.checked() and noButtonsCheckbox.isChecked.value == true then
				noButtonsCheckbox.isChecked:set(false)
			end
			if noButtonsCheckbox.checked() and noFieldCheckbox.isChecked.value == true then
				noFieldCheckbox.isChecked:set(false)
			end
			irisAPI.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			irisAPI.InputVector2({ "InputVector2" })
			irisAPI.InputVector3({ "InputVector3" })
			irisAPI.InputUDim({ "InputUDim" })
			irisAPI.InputUDim2({ "InputUDim2" })
			local useFloats = irisAPI.State(false)
			local useHSV = irisAPI.State(false)
			local selectedColor = irisAPI.State(Color3.new())
			local colorTransparency = irisAPI.State(0)
			irisAPI.SliderNum({ "Transparency", 0.01, 0, 1 }, {
				number = colorTransparency
			})
			irisAPI.InputColor3({ "InputColor3", useFloats:get(), useHSV:get() }, {
				color = selectedColor
			})
			irisAPI.InputColor4({ "InputColor4", useFloats:get(), useHSV:get() }, {
				color = selectedColor,
				transparency = colorTransparency
			})
			irisAPI.SameLine()
			irisAPI.Text({ (("#%s"):format((selectedColor:get():ToHex()))) })
			irisAPI.Checkbox({ "Use Floats" }, {
				isChecked = useFloats
			})
			irisAPI.Checkbox({ "Use HSV" }, {
				isChecked = useHSV
			})
			irisAPI.End()
			irisAPI.PopConfig()
			irisAPI.Separator()
			irisAPI.SameLine()
			irisAPI.Text({ "Slider Numbers" })
			helpMarker("ctrl + click slider number widgets to input a number")
			irisAPI.End()
			irisAPI.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			irisAPI.SliderNum({ "Slide Int", 1, 1, 8 })
			irisAPI.SliderNum({ "Slide Float", 0.01, 0, 100 })
			irisAPI.SliderNum({ "Small Numbers", 0.001, -2, 1, "%f radians" })
			irisAPI.SliderNum({ "Odd Ranges", 0.001, -3.141592653589793, math.pi, "%f radians" })
			irisAPI.SliderNum({ "Big Numbers", 10000, 100000, 10000000 })
			irisAPI.SliderNum({ "Few Numbers", 1, 0, 3 })
			irisAPI.PopConfig()
			irisAPI.Separator()
			irisAPI.SameLine()
			irisAPI.Text({ "Drag Numbers" })
			helpMarker("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed")
			irisAPI.End()
			irisAPI.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			irisAPI.DragNum({ "Drag Int" })
			irisAPI.DragNum({ "Slide Float", 0.001, -10, 10 })
			irisAPI.DragNum({ "Percentage", 1, 0, 100, "%d %%" })
			irisAPI.PopConfig()
			irisAPI.End()
		end,
		InputText = function()
			irisAPI.Tree({ "Input Text" })
			irisAPI.Text({ "The text is: " .. irisAPI.InputText({ "Input Text Test", "Input Text here" }).text.value })
			irisAPI.End()
		end,
		MultiInput = function()
			irisAPI.Tree({ "Multi-Component Input" })
			local vector2Value = irisAPI.State(Vector2.new())
			local vector3Value = irisAPI.State((Vector3.new()))
			local udimValue = irisAPI.State(UDim.new())
			local udim2Value = irisAPI.State(UDim2.new())
			local colorValue = irisAPI.State(Color3.new())
			local rectValue = irisAPI.State(Rect.new(0, 0, 0, 0))
			irisAPI.SeparatorText({ "Input" })
			irisAPI.InputVector2({}, {
				number = vector2Value
			})
			irisAPI.InputVector3({}, {
				number = vector3Value
			})
			irisAPI.InputUDim({}, {
				number = udimValue
			})
			irisAPI.InputUDim2({}, {
				number = udim2Value
			})
			irisAPI.InputRect({}, {
				number = rectValue
			})
			irisAPI.SeparatorText({ "Drag" })
			irisAPI.DragVector2({}, {
				number = vector2Value
			})
			irisAPI.DragVector3({}, {
				number = vector3Value
			})
			irisAPI.DragUDim({}, {
				number = udimValue
			})
			irisAPI.DragUDim2({}, {
				number = udim2Value
			})
			irisAPI.DragRect({}, {
				number = rectValue
			})
			irisAPI.SeparatorText({ "Slider" })
			irisAPI.SliderVector2({}, {
				number = vector2Value
			})
			irisAPI.SliderVector3({}, {
				number = vector3Value
			})
			irisAPI.SliderUDim({}, {
				number = udimValue
			})
			irisAPI.SliderUDim2({}, {
				number = udim2Value
			})
			irisAPI.SliderRect({}, {
				number = rectValue
			})
			irisAPI.SeparatorText({ "Color" })
			irisAPI.InputColor3({}, {
				color = colorValue
			})
			irisAPI.InputColor4({}, {
				color = colorValue
			})
			irisAPI.End()
		end,
		Tooltip = function()
			irisAPI.PushConfig({
				ContentWidth = UDim.new(0, 250)
			})
			irisAPI.Tree({ "Tooltip" })
			if irisAPI.Text({ "Hover over me to reveal a tooltip" }).hovered() then
				irisAPI.Tooltip({ "I am some helpful tooltip text" })
			end
			local repeatText = irisAPI.State("Hello ")
			local repeatCount = irisAPI.State(1)
			if irisAPI.InputNum({ "# of repeat", 1, 1, 50 }, {
				number = repeatCount
			}).numberChanged() then
				repeatText:set(string.rep("Hello ", repeatCount:get()))
			end
			if irisAPI.Checkbox({ "Show dynamic text tooltip" }).state.isChecked.value then
				irisAPI.Tooltip({ repeatText:get() })
			end
			irisAPI.End()
			irisAPI.PopConfig()
		end,
		Plotting = function()
			irisAPI.Tree({ "Plotting" })
			irisAPI.SeparatorText({ "Progress" })
			local animationTime = os.clock() * 15
			local progressValue = irisAPI.State(0)
			progressValue:set(math.clamp(math.abs(animationTime % 100 - 50) - 7.5, 0, 35) / 35)
			irisAPI.ProgressBar({ "Progress Bar" }, {
				progress = progressValue
			})
			local progressDisplay = {}
			local progressCount = progressValue:get() * 1753
			progressDisplay[1] = "Progress Bar"
			progressDisplay[2] = ("%s/1753"):format((math.floor(progressCount)))
			irisAPI.ProgressBar(progressDisplay, {
				progress = progressValue
			})
			irisAPI.SeparatorText({ "Graphs" })
			local plotValues = irisAPI.State({
				0.5,
				0.8,
				0.2,
				0.9,
				0.1,
				0.6,
				0.4,
				0.7,
				0.3,
				0
			})
			irisAPI.PlotHistogram({ "Histogram", 100, 0, 1, "random" }, {
				values = plotValues
			})
			irisAPI.PlotLines({ "Lines", 100, 0, 1, "random" }, {
				values = plotValues
			})
			local selectedPlotFunction = irisAPI.State("Cos")
			local sampleCount = irisAPI.State(37)
			local baselineValue = irisAPI.State(0)
			local computedPlotValues = irisAPI.State({})
			local animationFrame = irisAPI.State(0)
			local isAnimating = irisAPI.Checkbox({ "Animate" })
			local selectedFunctionCombo = irisAPI.ComboArray({ "Plotting Function" }, {
				index = selectedPlotFunction
			}, { "Sin", "Cos", "Tan", "Saw" })
			local sampleSlider = irisAPI.SliderNum({ "Samples", 1, 1, 145, "%d samples" }, {
				number = sampleCount
			})
			if irisAPI.SliderNum({ "Baseline", 0.1, -1, 1 }, {
				number = baselineValue
			}).numberChanged() then
				computedPlotValues:set(computedPlotValues.value, true)
			end
			if isAnimating.state.isChecked.value or (selectedFunctionCombo.closed() or (sampleSlider.numberChanged() or #computedPlotValues.value == 0)) then
				if isAnimating.state.isChecked.value then
					animationFrame:set(animationFrame.value + irisAPI.Internal._deltaTime)
				end
				local frameOffset = math.floor(animationFrame.value * 30) - 1
				local selectedFunction = selectedPlotFunction.value
				table.clear(computedPlotValues.value)
				for i = 1, sampleCount.value do
					local functionOutput
					if selectedFunction == "Sin" then
						computedPlotValues.value[i] = math.sin((math.rad((i + frameOffset) * 5)))
					elseif selectedFunction == "Cos" then
						computedPlotValues.value[i] = math.cos((math.rad((i + frameOffset) * 5)))
					elseif selectedFunction == "Tan" then
						computedPlotValues.value[i] = math.tan((math.rad((i + frameOffset) * 5)))
					elseif selectedFunction == "Saw" then
						functionOutput = if i % 2 == frameOffset % 2 then 1 else -1
						computedPlotValues.value[i] = functionOutput
					end
				end
				computedPlotValues:set(computedPlotValues.value, true)
			end
			irisAPI.PlotHistogram({
				"Histogram",
				100,
				-1,
				1,
				"",
				baselineValue:get()
			}, {
				values = computedPlotValues
			})
			irisAPI.PlotLines({ "Lines", 100, -1, 1 }, {
				values = computedPlotValues
			})
			irisAPI.End()
		end
	}
	local widgetDemoNamesList = {
		"Basic",
		"Image",
		"Selectable",
		"Combo",
		"Tree",
		"CollapsingHeader",
		"Group",
		"Tab",
		"Indent",
		"Input",
		"MultiInput",
		"InputText",
		"Tooltip",
		"Plotting"
	}
	local function recursiveTree()
		if irisAPI.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
			recursiveTree()
		end
		irisAPI.End()
	end
	local function recursiveWindow(windowState)
		irisAPI.Window({ "Recursive Window" }, {
			size = irisAPI.State(Vector2.new(175, 100)),
			isOpened = windowState
		})
		local recurseCheckbox = irisAPI.Checkbox({ "Recurse Again" })
		irisAPI.End()
		if recurseCheckbox.isChecked.value then
			recursiveWindow(recurseCheckbox.isChecked)
		end
	end
	local function runtimeInfo()
		local demoWindow = irisAPI.Window({ "Runtime Info" }, {
			isOpened = instance3
		})
		local vdomCache = irisAPI.Internal._lastVDOM
		local stateCache = irisAPI.Internal._states
		local searchDepth = irisAPI.State(3)
		local elapsedTime = irisAPI.State(0)
		local frameStartTime = irisAPI.State(os.clock())
		irisAPI.SameLine()
		irisAPI.InputNum({
			[irisAPI.Args.InputNum.Text] = "",
			[irisAPI.Args.InputNum.Format] = "%d Seconds",
			[irisAPI.Args.InputNum.Max] = 10
		}, {
			number = searchDepth
		})
		if irisAPI.Button({ "Disable" }).clicked() then
			irisAPI.Disabled = true
			task.delay(searchDepth:get(), function()
				irisAPI.Disabled = false
			end)
		end
		irisAPI.End()
		local currentFrameTime = os.clock()
		elapsedTime.value = elapsedTime.value + (currentFrameTime - frameStartTime.value - elapsedTime.value) * 0.2
		frameStartTime.value = currentFrameTime
		irisAPI.Text({ string.format("Average %.3f ms/frame (%.1f FPS)", elapsedTime.value * 1000, 1 / elapsedTime.value) })
		irisAPI.Text({ string.format("Window Position: (%d, %d), Window Size: (%d, %d)", demoWindow.position.value.X, demoWindow.position.value.Y, demoWindow.size.value.X, demoWindow.size.value.Y) })
		irisAPI.SameLine()
		irisAPI.Text({ "Enter an ID to learn more about it." })
		helpMarker("every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs")
		irisAPI.End()
		irisAPI.PushConfig({
			ItemWidth = UDim.new(1, -150)
		})
		local lookupIDValue = irisAPI.InputText({ "ID field" }, {
			text = irisAPI.State(demoWindow.ID)
		}).state.text.value
		irisAPI.PopConfig()
		irisAPI.Indent()
		local widgetData = vdomCache[lookupIDValue]
		local stateData = stateCache[lookupIDValue]
		if widgetData then
			irisAPI.Table({ 1 })
			irisAPI.Text({ string.format("The ID, \"%s\", is a widget", lookupIDValue) })
			irisAPI.NextRow()
			irisAPI.Text({ string.format("Widget is type: %s", widgetData.type) })
			irisAPI.NextRow()
			irisAPI.Tree({ "Widget has Args:" }, {
				isUncollapsed = irisAPI.State(true)
			})
			for argName, argValue in widgetData.arguments do
				irisAPI.Text({ argName .. " - " .. tostring(argValue) })
			end
			irisAPI.End()
			irisAPI.NextRow()
			if widgetData.state then
				irisAPI.Tree({ "Widget has State:" }, {
					isUncollapsed = irisAPI.State(true)
				})
				for stateName, stateValue in widgetData.state do
					local stateDisplay = {}
					stateDisplay[1] = stateName .. " - " .. tostring(stateValue.value)
					irisAPI.Text(stateDisplay)
				end
				irisAPI.End()
			end
			irisAPI.End()
		elseif stateData then
			irisAPI.Table({ 1 })
			irisAPI.Text({ string.format("The ID, \"%s\", is a state", lookupIDValue) })
			irisAPI.NextRow()
			local stateInfo = {}
			stateInfo[1] = string.format("Value is type: %s, Value = %s", typeof(stateData.value), (tostring(stateData.value)))
			irisAPI.Text(stateInfo)
			irisAPI.NextRow()
			irisAPI.Tree({ "state has connected widgets:" }, {
				isUncollapsed = irisAPI.State(true)
			})
			for widgetID, widget in stateData.ConnectedWidgets do
				irisAPI.Text({ widgetID .. " - " .. widget.type })
			end
			irisAPI.End()
			irisAPI.NextRow()
			irisAPI.Text({ string.format("state has: %d connected functions", #stateData.ConnectedFunctions) })
			irisAPI.End()
		else
			irisAPI.Text({ string.format("The ID, \"%s\", is not a state or widget", lookupIDValue) })
		end
		irisAPI.End()
		if irisAPI.Tree({ "Widgets" }).state.isUncollapsed.value then
			local widgetCount = 0
			local widgetList = ""
			for widgetID, widget in vdomCache do
				widgetList = widgetList .. "\n" .. widget.ID .. " - " .. widget.type
				widgetCount = widgetCount + 1
			end
			irisAPI.Text({ "Number of Widgets: " .. widgetCount })
			irisAPI.Text({ widgetList })
		end
		irisAPI.End()
		if irisAPI.Tree({ "States" }).state.isUncollapsed.value then
			local stateCount = 0
			local stateList = ""
			for stateID, state in stateCache do
				stateList = stateList .. "\n" .. stateID .. " - " .. tostring(state.value)
				stateCount = stateCount + 1
			end
			irisAPI.Text({ "Number of States: " .. stateCount })
			irisAPI.Text({ stateList })
		end
		irisAPI.End()
		irisAPI.End()
	end
	local function debugPanel()
		irisAPI.Window({ "Debug Panel" }, {
			isOpened = var7
		})
		irisAPI.CollapsingHeader({ "Widgets" })
		irisAPI.SeparatorText({ "GuiService" })
		irisAPI.Text({ (("GuiOffset: %s"):format(irisAPI.Internal._utility.GuiOffset)) })
		irisAPI.Text({ (("MouseOffset: %s"):format(irisAPI.Internal._utility.MouseOffset)) })
		irisAPI.SeparatorText({ "UserInputService" })
		irisAPI.Text({ (("MousePosition: %s"):format((irisAPI.Internal._utility.UserInputService:GetMouseLocation()))) })
		irisAPI.Text({ (("MouseLocation: %s"):format((irisAPI.Internal._utility.getMouseLocation()))) })
		irisAPI.Text({ (("Left Control: %s"):format((irisAPI.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)))) })
		irisAPI.Text({ (("Right Control: %s"):format((irisAPI.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)))) })
		irisAPI.End()
		irisAPI.End()
	end
	local function recursiveMenu()
		if irisAPI.Menu({ "Recursive" }).state.isOpened.value then
			irisAPI.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
			irisAPI.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
			irisAPI.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
			irisAPI.Separator()
			irisAPI.MenuToggle({ "Autosave" })
			irisAPI.MenuToggle({ "Checked" })
			irisAPI.Separator()
			irisAPI.Menu({ "Options" })
			irisAPI.MenuItem({ "Red" })
			irisAPI.MenuItem({ "Yellow" })
			irisAPI.MenuItem({ "Green" })
			irisAPI.MenuItem({ "Blue" })
			irisAPI.Separator()
			recursiveMenu()
			irisAPI.End()
		end
		irisAPI.End()
	end
	local function mainMenuBar()
		irisAPI.MenuBar()
		irisAPI.Menu({ "File" })
		irisAPI.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
		irisAPI.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
		irisAPI.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
		recursiveMenu()
		if irisAPI.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt }).clicked() then
			instance:set(false)
		end
		irisAPI.End()
		irisAPI.Menu({ "Examples" })
		irisAPI.MenuToggle({ "Recursive Window" }, {
			isChecked = vector2
		})
		irisAPI.MenuToggle({ "Windowless" }, {
			isChecked = var5
		})
		irisAPI.MenuToggle({ "Main Menu Bar" }, {
			isChecked = func6
		})
		irisAPI.End()
		irisAPI.Menu({ "Tools" })
		irisAPI.MenuToggle({ "Runtime Info" }, {
			isChecked = instance3
		})
		irisAPI.MenuToggle({ "Style Editor" }, {
			isChecked = var4
		})
		irisAPI.MenuToggle({ "Debug Panel" }, {
			isChecked = var7
		})
		irisAPI.End()
		irisAPI.End()
	end
	local function mainMenuBarExample()
		mainMenuBar()
	end
	local function styleEditor()
		local styleEditorTabs = {
			{ "Sizing", function()
					local configChanges = irisAPI.State({})
					irisAPI.SameLine()
					if irisAPI.Button({ "Update" }).clicked() then
						irisAPI.UpdateGlobalConfig(configChanges.value)
						configChanges:set({})
					end
					helpMarker("Update the global config with these changes.")
					irisAPI.End()
					local function SliderInput(sliderName, sliderConfig)
						local sliderResult = irisAPI[sliderName](sliderConfig, {
							number = irisAPI.WeakState(irisAPI._config[sliderConfig[1]])
						})
						if sliderResult.numberChanged() then
							configChanges.value[sliderConfig[1]] = sliderResult.number:get()
						end
					end
					local function BooleanInput(booleanConfig)
						local booleanResult = irisAPI.Checkbox(booleanConfig, {
							isChecked = irisAPI.WeakState(irisAPI._config[booleanConfig[1]])
						})
						if booleanResult.checked() or booleanResult.unchecked() then
							configChanges.value[booleanConfig[1]] = booleanResult.isChecked:get()
						end
					end
					irisAPI.SeparatorText({ "Main" })
					SliderInput("SliderVector2", {
						"WindowPadding",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					SliderInput("SliderVector2", {
						"WindowResizePadding",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					SliderInput("SliderVector2", {
						"FramePadding",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					SliderInput("SliderVector2", {
						"ItemSpacing",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					SliderInput("SliderVector2", {
						"ItemInnerSpacing",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					SliderInput("SliderVector2", {
						"CellPadding",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					SliderInput("SliderNum", { "IndentSpacing", 1, 0, 36 })
					SliderInput("SliderNum", { "ScrollbarSize", 1, 0, 20 })
					SliderInput("SliderNum", { "GrabMinSize", 1, 0, 20 })
					irisAPI.SeparatorText({ "Borders & Rounding" })
					SliderInput("SliderNum", { "FrameBorderSize", 0.1, 0, 1 })
					SliderInput("SliderNum", { "WindowBorderSize", 0.1, 0, 1 })
					SliderInput("SliderNum", { "PopupBorderSize", 0.1, 0, 1 })
					SliderInput("SliderNum", { "SeparatorTextBorderSize", 1, 0, 20 })
					SliderInput("SliderNum", { "FrameRounding", 1, 0, 12 })
					SliderInput("SliderNum", { "GrabRounding", 1, 0, 12 })
					SliderInput("SliderNum", { "PopupRounding", 1, 0, 12 })
					irisAPI.SeparatorText({ "Widgets" })
					SliderInput("SliderVector2", {
						"DisplaySafeAreaPadding",
						nil,
						Vector2.zero,
						Vector2.new(20, 20)
					})
					SliderInput("SliderVector2", {
						"SeparatorTextPadding",
						nil,
						Vector2.zero,
						Vector2.new(36, 36)
					})
					SliderInput("SliderUDim", {
						"ItemWidth",
						nil,
						UDim.new(),
						UDim.new(1, 200)
					})
					SliderInput("SliderUDim", {
						"ContentWidth",
						nil,
						UDim.new(),
						UDim.new(1, 200)
					})
					SliderInput("SliderNum", { "ImageBorderSize", 1, 0, 12 })
					local windowTitleAlignCombo = irisAPI.ComboEnum({ "WindowTitleAlign" }, {
						index = irisAPI.WeakState(irisAPI._config.WindowTitleAlign)
					}, Enum.LeftRight)
					if windowTitleAlignCombo.closed() then
						configChanges.value.WindowTitleAlign = windowTitleAlignCombo.index:get()
					end
					BooleanInput({ "RichText" })
					BooleanInput({ "TextWrapped" })
					irisAPI.SeparatorText({ "Config" })
					BooleanInput({ "UseScreenGUIs" })
					SliderInput("DragNum", { "DisplayOrderOffset", 1, 0 })
					SliderInput("DragNum", { "ZIndexOffset", 1, 0 })
					SliderInput("SliderNum", { "MouseDoubleClickTime", 0.1, 0, 5 })
					SliderInput("SliderNum", { "MouseDoubleClickMaxDist", 0.1, 0, 20 })
				end },
			{ "Colors", function()
					local configChanges = irisAPI.State({})
					irisAPI.SameLine()
					if irisAPI.Button({ "Update" }).clicked() then
						irisAPI.UpdateGlobalConfig(configChanges.value)
						configChanges:set({})
					end
					helpMarker("Update the global config with these changes.")
					irisAPI.End()
					for colorName, _ in {
						"Text",
						"TextDisabled",
						"WindowBg",
						"PopupBg",
						"Border",
						"BorderActive",
						"ScrollbarGrab",
						"TitleBg",
						"TitleBgActive",
						"TitleBgCollapsed",
						"MenubarBg",
						"FrameBg",
						"FrameBgHovered",
						"FrameBgActive",
						"Button",
						"ButtonHovered",
						"ButtonActive",
						"Image",
						"SliderGrab",
						"SliderGrabActive",
						"Header",
						"HeaderHovered",
						"HeaderActive",
						"SelectionImageObject",
						"SelectionImageObjectBorder",
						"TableBorderStrong",
						"TableBorderLight",
						"TableRowBg",
						"TableRowBgAlt",
						"NavWindowingHighlight",
						"NavWindowingDimBg",
						"Separator",
						"CheckMark"
					} do
						local colorInputResult = irisAPI.InputColor4({ colorName }, {
							color = irisAPI.WeakState(irisAPI._config[colorName .. "Color"]),
							transparency = irisAPI.WeakState(irisAPI._config[colorName .. "Transparency"])
						})
						if colorInputResult.numberChanged() then
							configChanges.value[colorName .. "Color"] = colorInputResult.color:get()
							configChanges.value[colorName .. "Transparency"] = colorInputResult.transparency:get()
						end
					end
				end },
			{ "Fonts", function()
					local configChanges = irisAPI.State({})
					irisAPI.SameLine()
					if irisAPI.Button({ "Update" }).clicked() then
						irisAPI.UpdateGlobalConfig(configChanges.value)
						configChanges:set({})
					end
					helpMarker("Update the global config with these changes.")
					irisAPI.End()
					local fontMap = {
						["Code (default)"] = Font.fromEnum(Enum.Font.Code),
						["Ubuntu (template)"] = Font.fromEnum(Enum.Font.Ubuntu),
						Arial = Font.fromEnum(Enum.Font.Arial),
						Highway = Font.fromEnum(Enum.Font.Highway),
						Roboto = Font.fromEnum(Enum.Font.Roboto),
						["Roboto Mono"] = Font.fromEnum(Enum.Font.RobotoMono),
						["Noto Sans"] = Font.new("rbxassetid://12187370747"),
						["Builder Sans"] = Font.fromEnum(Enum.Font.BuilderSans),
						["Builder Mono"] = Font.new("rbxassetid://16658246179"),
						Sono = Font.new("rbxassetid://12187374537")
					}
					irisAPI.Text({ (("Current Font: %s Weight: %s Style: %s"):format(irisAPI._config.TextFont.Family, irisAPI._config.TextFont.Weight, irisAPI._config.TextFont.Style)) })
					irisAPI.SeparatorText({ "Size" })
					local fontSizeSlider = irisAPI.SliderNum({ "Font Size", 1, 4, 20 }, {
						number = irisAPI.WeakState(irisAPI._config.TextSize)
					})
					if fontSizeSlider.numberChanged() then
						configChanges.value.TextSize = fontSizeSlider.state.number:get()
					end
					irisAPI.SeparatorText({ "Properties" })
					local selectedFontFamily = irisAPI.WeakState(irisAPI._config.TextFont.Family)
					local fontWeightCombo = irisAPI.ComboEnum({ "Font Weight" }, {
						index = irisAPI.WeakState(irisAPI._config.TextFont.Weight)
					}, Enum.FontWeight)
					local fontStyleCombo = irisAPI.ComboEnum({ "Font Style" }, {
						index = irisAPI.WeakState(irisAPI._config.TextFont.Style)
					}, Enum.FontStyle)
					irisAPI.SeparatorText({ "Fonts" })
					for fontLabel, fontData in fontMap do
						local fontInstance = Font.new(fontData.Family, fontWeightCombo.state.index.value, fontStyleCombo.state.index.value)
						irisAPI.SameLine()
						irisAPI.PushConfig({
							TextFont = fontInstance
						})
						if irisAPI.Selectable({ ("%s | \"The quick brown fox jumps over the lazy dog.\""):format(fontLabel), fontInstance.Family }, {
							index = selectedFontFamily
						}).selected() then
							configChanges.value.TextFont = fontInstance
						end
						irisAPI.PopConfig()
						irisAPI.End()
					end
				end }
		}
		irisAPI.Window({ "Style Editor" }, {
			isOpened = var4
		})
		irisAPI.Text({ "Customize the look of Iris in realtime." })
		local themeSelection = irisAPI.State("Dark Theme")
		if irisAPI.ComboArray({ "Theme" }, {
			index = themeSelection
		}, { "Dark Theme", "Light Theme" }).closed() then
			if themeSelection.value == "Dark Theme" then
				irisAPI.UpdateGlobalConfig(irisAPI.TemplateConfig.colorDark)
			elseif themeSelection.value == "Light Theme" then
				irisAPI.UpdateGlobalConfig(irisAPI.TemplateConfig.colorLight)
			end
		end
		local sizeSelection = irisAPI.State("Classic Size")
		if irisAPI.ComboArray({ "Size" }, {
			index = sizeSelection
		}, { "Classic Size", "Larger Size" }).closed() then
			if sizeSelection.value == "Classic Size" then
				irisAPI.UpdateGlobalConfig(irisAPI.TemplateConfig.sizeDefault)
			elseif sizeSelection.value == "Larger Size" then
				irisAPI.UpdateGlobalConfig(irisAPI.TemplateConfig.sizeClear)
			end
		end
		irisAPI.SameLine()
		if irisAPI.Button({ "Revert" }).clicked() then
			irisAPI.UpdateGlobalConfig(irisAPI.TemplateConfig.colorDark)
			irisAPI.UpdateGlobalConfig(irisAPI.TemplateConfig.sizeDefault)
			themeSelection:set("Dark Theme")
			sizeSelection:set("Classic Size")
		end
		helpMarker("Reset Iris to the default theme and size.")
		irisAPI.End()
		irisAPI.TabBar()
		for i, tabData in ipairs(styleEditorTabs) do
			irisAPI.Tab({ tabData[1] })
			styleEditorTabs[i][2]()
			irisAPI.End()
		end
		irisAPI.End()
		irisAPI.Separator()
		irisAPI.End()
	end
	local function widgetEventInteractivity()
		irisAPI.CollapsingHeader({ "Widget Event Interactivity" })
		local clickCounter = irisAPI.State(0)
		if irisAPI.Button({ "Click to increase Number" }).clicked() then
			clickCounter:set(clickCounter:get() + 1)
		end
		irisAPI.Text({ "The Number is: " .. clickCounter:get() })
		irisAPI.Separator()
		local toggleState = irisAPI.State(false)
		local eventType = irisAPI.State("clicked")
		irisAPI.SameLine()
		irisAPI.RadioButton({ "clicked", "clicked" }, {
			index = eventType
		})
		irisAPI.RadioButton({ "rightClicked", "rightClicked" }, {
			index = eventType
		})
		irisAPI.RadioButton({ "doubleClicked", "doubleClicked" }, {
			index = eventType
		})
		irisAPI.RadioButton({ "ctrlClicked", "ctrlClicked" }, {
			index = eventType
		})
		irisAPI.End()
		irisAPI.SameLine()
		if irisAPI.Button({ eventType:get() .. " to reveal text" })[eventType:get()]() then
			toggleState:set(not toggleState:get())
		end
		if toggleState:get() then
			irisAPI.Text({ "Here i am!" })
		end
		irisAPI.End()
		irisAPI.Separator()
		local displayTimer = irisAPI.State(0)
		irisAPI.SameLine()
		if irisAPI.Button({ "Click to show text for 20 frames" }).clicked() then
			displayTimer:set(20)
		end
		if displayTimer:get() > 0 then
			irisAPI.Text({ "Here i am!" })
		end
		irisAPI.End()
		displayTimer:set((math.max(0, displayTimer:get() - 1)))
		irisAPI.Text({ "Text Timer: " .. displayTimer:get() })
		local eventTracker = irisAPI.Checkbox({ "Event-tracked checkbox" })
		irisAPI.Indent()
		local uncheckedText = {}
		uncheckedText[1] = "unchecked: " .. tostring(eventTracker.unchecked())
		irisAPI.Text(uncheckedText)
		local checkedText = {}
		checkedText[1] = "checked: " .. tostring(eventTracker.checked())
		irisAPI.Text(checkedText)
		irisAPI.End()
		irisAPI.SameLine()
		if irisAPI.Button({ "Hover over me" }).hovered() then
			irisAPI.Text({ "The button is hovered" })
		end
		irisAPI.End()
		irisAPI.End()
	end
	local function widgetStateInteractivity()
		irisAPI.CollapsingHeader({ "Widget State Interactivity" })
		irisAPI.Text({ (("isChecked: %s\n"):format(irisAPI.Checkbox({ "Widget-Generated State" }).state.isChecked.value)) })
		irisAPI.Text({ (("isChecked: %s\n"):format(irisAPI.Checkbox({ "User-Generated State" }, {
				isChecked = irisAPI.State(false)
			}).state.isChecked.value)) })
		irisAPI.Text({ (("isChecked: %s\n"):format(irisAPI.Checkbox({ "Coupled to above Checkbox" }, {
				isChecked = irisAPI.Checkbox({ "Widget Coupled State" }).state.isChecked
			}).state.isChecked.value)) })
		local coupledState = irisAPI.State(false)
		irisAPI.Checkbox({ "Widget and Code Coupled State" }, {
			isChecked = coupledState
		})
		if irisAPI.Button({ "Click to toggle above checkbox" }).clicked() then
			coupledState:set(not coupledState:get())
		end
		irisAPI.Text({ (("isChecked: %s\n"):format(coupledState.value)) })
		local sourceState = irisAPI.State(true)
		local invertedState = irisAPI.ComputedState(sourceState, function(checked)
			return not checked
		end)
		irisAPI.Checkbox({ "ComputedState (dynamic coupling)" }, {
			isChecked = sourceState
		})
		irisAPI.Checkbox({ "Inverted of above checkbox" }, {
			isChecked = invertedState
		})
		irisAPI.Text({ (("isChecked: %s\n"):format(invertedState.value)) })
		irisAPI.End()
	end
	local function dynamicStyle()
		irisAPI.CollapsingHeader({ "Dynamic Styles" })
		local hueValue = irisAPI.State(0)
		irisAPI.SameLine()
		if irisAPI.Button({ "Change Color" }).clicked() then
			hueValue:set(math.random())
		end
		local hueDisplay = {}
		hueDisplay[1] = "Hue: " .. math.floor(hueValue:get() * 255)
		irisAPI.Text(hueDisplay)
		helpMarker("Using PushConfig with a changing value, this can be done with any config field")
		irisAPI.End()
		irisAPI.PushConfig({
			TextColor = Color3.fromHSV(hueValue:get(), 1, 1)
		})
		irisAPI.Text({ "Text with a unique and changable color" })
		irisAPI.PopConfig()
		irisAPI.End()
	end
	local function tablesDemo()
		local headerVisible = irisAPI.State(false)
		irisAPI.CollapsingHeader({ "Tables & Columns" }, {
			isUncollapsed = headerVisible
		})
		if headerVisible.value ~= false then
			irisAPI.Tree({ "Basic" })
			irisAPI.SameLine()
			irisAPI.Text({ "Table using NextColumn syntax:" })
			helpMarker("calling Iris.NextColumn() in the inner loop,\nwhich automatically goes to the next row at the end.")
			irisAPI.End()
			irisAPI.Table({ 3 })
			for i = 1, 4 do
				for j = 1, 3 do
					irisAPI.Text({ (("Row: %s, Column: %s"):format(i, j)) })
					irisAPI.NextColumn()
				end
			end
			irisAPI.End()
			irisAPI.Text({ "" })
			irisAPI.SameLine()
			irisAPI.Text({ "Table using NextColumn and NextRow syntax:" })
			helpMarker("Calling Iris.NextColumn() in the inner loop and Iris.NextRow() in the outer loop,\nto acehieve a visually identical result. Technically they are not the same.")
			irisAPI.End()
			irisAPI.Table({ 3 })
			for k = 1, 4 do
				for n = 1, 3 do
					irisAPI.Text({ (("Row: %s, Column: %s"):format(k, n)) })
					irisAPI.NextColumn()
				end
				irisAPI.NextRow()
			end
			irisAPI.End()
			irisAPI.End()
			irisAPI.Tree({ "Headers, borders and backgrounds" })
			local cellContentType = irisAPI.State(0)
			local showTableHeader = irisAPI.State(false)
			local showRowBackgrounds = irisAPI.State(false)
			local showOuterBorder = irisAPI.State(true)
			local showInnerBorders = irisAPI.State(true)
			irisAPI.Checkbox({ "Table header row" }, {
				isChecked = showTableHeader
			})
			irisAPI.Checkbox({ "Table row backgrounds" }, {
				isChecked = showRowBackgrounds
			})
			irisAPI.Checkbox({ "Table outer border" }, {
				isChecked = showOuterBorder
			})
			irisAPI.Checkbox({ "Table inner borders" }, {
				isChecked = showInnerBorders
			})
			irisAPI.SameLine()
			irisAPI.Text({ "Cell contents" })
			irisAPI.RadioButton({ "Text", 0 }, {
				index = cellContentType
			})
			irisAPI.RadioButton({ "Fill button", 1 }, {
				index = cellContentType
			})
			irisAPI.End()
			irisAPI.Table({
				3,
				showTableHeader.value,
				showRowBackgrounds.value,
				showOuterBorder.value,
				showInnerBorders.value
			})
			irisAPI.SetHeaderColumnIndex(1)
			for m = 0, 4 do
				for i = 1, 3 do
					if cellContentType.value == 0 then
						irisAPI.Text({ (("Cell (%s, %s)"):format(i, m)) })
					else
						irisAPI.Button({ ("Cell (%s, %s)"):format(i, m), UDim2.fromScale(1, 0) })
					end
					irisAPI.NextColumn()
				end
			end
			irisAPI.End()
			irisAPI.End()
			irisAPI.Tree({ "Sizing" })
			local isResizable = irisAPI.State(false)
			local limitTableWidth = irisAPI.State(false)
			irisAPI.Checkbox({ "Resizable" }, {
				isChecked = isResizable
			})
			irisAPI.Checkbox({ "Limit Table Width" }, {
				isChecked = limitTableWidth
			})
			irisAPI.SeparatorText({ "stretch, equal" })
			irisAPI.Table({
				3,
				false,
				true,
				true,
				true,
				isResizable.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					irisAPI.Text({ "stretch" })
					irisAPI.NextColumn()
				end
			end
			irisAPI.End()
			irisAPI.Table({
				3,
				false,
				true,
				true,
				true,
				isResizable.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					irisAPI.Text({ string.rep(string.char(i2 + 64), i2 * 4) })
					irisAPI.NextColumn()
				end
			end
			irisAPI.End()
			irisAPI.SeparatorText({ "stretch, proportional" })
			irisAPI.Table({
				3,
				false,
				true,
				true,
				true,
				isResizable.value,
				false,
				true
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					irisAPI.Text({ "stretch" })
					irisAPI.NextColumn()
				end
			end
			irisAPI.End()
			irisAPI.Table({
				3,
				false,
				true,
				true,
				true,
				isResizable.value,
				false,
				true
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					irisAPI.Text({ string.rep(string.char(i2 + 64), i2 * 4) })
					irisAPI.NextColumn()
				end
			end
			irisAPI.End()
			irisAPI.SeparatorText({ "fixed, equal" })
			irisAPI.Table({
				3,
				false,
				true,
				true,
				true,
				isResizable.value,
				true,
				false,
				limitTableWidth.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					irisAPI.Text({ "fixed" })
					irisAPI.NextColumn()
				end
			end
			irisAPI.End()
			irisAPI.Table({
				3,
				false,
				true,
				true,
				true,
				isResizable.value,
				true,
				false,
				limitTableWidth.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					irisAPI.Text({ string.rep(string.char(i2 + 64), i2 * 4) })
					irisAPI.NextColumn()
				end
			end
			irisAPI.End()
			irisAPI.SeparatorText({ "fixed, proportional" })
			irisAPI.Table({
				3,
				false,
				true,
				true,
				true,
				isResizable.value,
				true,
				true,
				limitTableWidth.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					irisAPI.Text({ "fixed" })
					irisAPI.NextColumn()
				end
			end
			irisAPI.End()
			irisAPI.Table({
				3,
				false,
				true,
				true,
				true,
				isResizable.value,
				true,
				true,
				limitTableWidth.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					irisAPI.Text({ string.rep(string.char(i2 + 64), i2 * 4) })
					irisAPI.NextColumn()
				end
			end
			irisAPI.End()
			irisAPI.End()
			irisAPI.Tree({ "Resizable" })
			local columnCount = irisAPI.State(4)
			local rowCount = irisAPI.State(3)
			local usesButtons = irisAPI.State(false)
			local showHeader = irisAPI.State(true)
			local showRowBgs = irisAPI.State(true)
			local showOuterBorders = irisAPI.State(true)
			local showInnerBorders = irisAPI.State(true)
			local isTableResizable = irisAPI.State(false)
			local isTableFixedWidth = irisAPI.State(false)
			local isTableProportional = irisAPI.State(false)
			local limitWidth = irisAPI.State(false)
			local addExtraContent = irisAPI.State(false)
			local columnWidths = irisAPI.State(table.create(10, 100))
			irisAPI.SliderNum({ "Num Columns", 1, 1, 10 }, {
				number = columnCount
			})
			irisAPI.SliderNum({ "Number of rows", 1, 0, 100 }, {
				number = rowCount
			})
			irisAPI.SameLine()
			irisAPI.RadioButton({ "Buttons", true }, {
				index = usesButtons
			})
			irisAPI.RadioButton({ "Text", false }, {
				index = usesButtons
			})
			irisAPI.End()
			irisAPI.Table({ 3 })
			irisAPI.Checkbox({ "Show Header Row" }, {
				isChecked = showHeader
			})
			irisAPI.NextColumn()
			irisAPI.Checkbox({ "Show Row Backgrounds" }, {
				isChecked = showRowBgs
			})
			irisAPI.NextColumn()
			irisAPI.Checkbox({ "Show Outer Border" }, {
				isChecked = showOuterBorders
			})
			irisAPI.NextColumn()
			irisAPI.Checkbox({ "Show Inner Border" }, {
				isChecked = showInnerBorders
			})
			irisAPI.NextColumn()
			irisAPI.Checkbox({ "Resizable" }, {
				isChecked = isTableResizable
			})
			irisAPI.NextColumn()
			irisAPI.Checkbox({ "Fixed Width" }, {
				isChecked = isTableFixedWidth
			})
			irisAPI.NextColumn()
			irisAPI.Checkbox({ "Proportional Width" }, {
				isChecked = isTableProportional
			})
			irisAPI.NextColumn()
			irisAPI.Checkbox({ "Limit Table Width" }, {
				isChecked = limitWidth
			})
			irisAPI.NextColumn()
			irisAPI.Checkbox({ "Add extra" }, {
				isChecked = addExtraContent
			})
			irisAPI.NextColumn()
			irisAPI.End()
			for i = 1, columnCount.value do
				local columnMin, columnDefault, columnMax
				columnMin = if isTableFixedWidth.value == true then 1 else 0.05
				columnDefault = if isTableFixedWidth.value == true then 2 else 0.05
				columnMax = if isTableFixedWidth.value == true then 480 else 1
				irisAPI.SliderNum({
					("Column %s Width"):format(i),
					columnMin,
					columnDefault,
					columnMax
				}, {
					number = irisAPI.TableState(columnWidths.value, i, function(newWidth)
						columnWidths.value[i] = newWidth
						columnWidths:set(columnWidths.value, true)
						return false
					end)
				})
			end
			irisAPI.PushConfig({
				NumColumns = columnCount.value
			})
			irisAPI.Table({
				columnCount.value,
				showHeader.value,
				showRowBgs.value,
				showOuterBorders.value,
				showInnerBorders.value,
				isTableResizable.value,
				isTableFixedWidth.value,
				isTableProportional.value,
				limitWidth.value
			}, {
				widths = columnWidths
			})
			irisAPI.SetHeaderColumnIndex(1)
			for i = 0, rowCount:get() do
				for i2 = 1, columnCount.value do
					if i == 0 then
						if usesButtons.value then
							irisAPI.Button({ (("H: %s"):format(i2)) })
						else
							irisAPI.Text({ (("H: %s"):format(i2)) })
						end
					elseif usesButtons.value then
						irisAPI.Button({ (("R: %s, C: %s"):format(i, i2)) })
						irisAPI.Button({ string.rep("...", i2) })
					else
						irisAPI.Text({ (("R: %s, C: %s"):format(i, i2)) })
						irisAPI.Text({ string.rep("...", i2) })
					end
					irisAPI.NextColumn()
				end
			end
			if addExtraContent.value then
				irisAPI.Text({ "A really long piece of text!" })
			end
			irisAPI.End()
			irisAPI.PopConfig()
			irisAPI.End()
		end
		irisAPI.End()
	end
	local function layoutDemo()
		irisAPI.CollapsingHeader({ "Widget Layout" })
		irisAPI.Tree({ "Widget Alignment" })
		irisAPI.Text({ "Iris.SameLine has optional argument supporting horizontal and vertical alignments." })
		irisAPI.Text({ "This allows widgets to be place anywhere on the line." })
		irisAPI.Separator()
		irisAPI.SameLine()
		irisAPI.Text({ "By default child widgets will be aligned to the left." })
		helpMarker("Iris.SameLine()\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		irisAPI.End()
		irisAPI.SameLine()
		irisAPI.Button({ "Button A" })
		irisAPI.Button({ "Button B" })
		irisAPI.End()
		irisAPI.SameLine()
		irisAPI.Text({ "But can be aligned to the center." })
		helpMarker("Iris.SameLine({ nil, nil, Enum.HorizontalAlignment.Center })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		irisAPI.End()
		irisAPI.SameLine({ nil, nil, Enum.HorizontalAlignment.Center })
		irisAPI.Button({ "Button A" })
		irisAPI.Button({ "Button B" })
		irisAPI.End()
		irisAPI.SameLine()
		irisAPI.Text({ "Or right." })
		helpMarker("Iris.SameLine({ nil, nil, Enum.HorizontalAlignment.Right })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		irisAPI.End()
		irisAPI.SameLine({ nil, nil, Enum.HorizontalAlignment.Right })
		irisAPI.Button({ "Button A" })
		irisAPI.Button({ "Button B" })
		irisAPI.End()
		irisAPI.Separator()
		irisAPI.SameLine()
		irisAPI.Text({ "You can also specify the padding." })
		helpMarker("Iris.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		irisAPI.End()
		irisAPI.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })
		irisAPI.Button({ "Button A" })
		irisAPI.Button({ "Button B" })
		irisAPI.End()
		irisAPI.End()
		irisAPI.Tree({ "Widget Sizing" })
		irisAPI.Text({ "Nearly all widgets are the minimum size of the content." })
		irisAPI.Text({ "For example, text and button widgets will be the size of the text labels." })
		irisAPI.Text({ "Some widgets, such as the Image and Button have Size arguments will will set the size of them." })
		irisAPI.Separator()
		irisAPI.SameLine()
		irisAPI.Text({ "The button takes up the full screen-width." })
		helpMarker("Iris.Button({ \"Button\", UDim2.fromScale(1, 0) })")
		irisAPI.End()
		irisAPI.Button({ "Button", UDim2.fromScale(1, 0) })
		irisAPI.SameLine()
		irisAPI.Text({ "The button takes up half the screen-width." })
		helpMarker("Iris.Button({ \"Button\", UDim2.fromScale(0.5, 0) })")
		irisAPI.End()
		irisAPI.Button({ "Button", UDim2.fromScale(0.5, 0) })
		irisAPI.SameLine()
		irisAPI.Text({ "Combining with SameLine, the buttons can fill the screen width." })
		helpMarker("The button will still be larger that the text size.")
		irisAPI.End()
		local buttonCount = irisAPI.State(2)
		irisAPI.SliderNum({ "Number of Buttons", 1, 1, 8 }, {
			number = buttonCount
		})
		irisAPI.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })
		for i = 1, buttonCount.value do
			irisAPI.Button({ ("Button %s"):format(i), UDim2.fromScale(1 / buttonCount.value, 0) })
		end
		irisAPI.End()
		irisAPI.End()
		irisAPI.Tree({ "Content Width" })
		local contentNumber = irisAPI.State(50)
		local contentAxis = irisAPI.State(Enum.Axis.X)
		irisAPI.Text({ "The Content Width is a size property which determines the width of input fields." })
		irisAPI.SameLine()
		irisAPI.Text({ "By default the value is UDim.new(0.65, 0)" })
		helpMarker("This is the default value from Dear ImGui.\nIt is 65% of the window width.")
		irisAPI.End()
		irisAPI.Text({ "This works well, but sometimes we know how wide elements are going to be and want to maximise the space." })
		irisAPI.Text({ "Therefore, we can use Iris.PushConfig() to change the width" })
		irisAPI.Separator()
		irisAPI.SameLine()
		irisAPI.Text({ "Content Width = 150 pixels" })
		helpMarker("UDim.new(0, 150)")
		irisAPI.End()
		irisAPI.PushConfig({
			ContentWidth = UDim.new(0, 150)
		})
		irisAPI.DragNum({ "number", 1, 0, 100 }, {
			number = contentNumber
		})
		irisAPI.InputEnum({ "axis" }, {
			index = contentAxis
		}, Enum.Axis)
		irisAPI.PopConfig()
		irisAPI.SameLine()
		irisAPI.Text({ "Content Width = 50% window width" })
		helpMarker("UDim.new(0.5, 0)")
		irisAPI.End()
		irisAPI.PushConfig({
			ContentWidth = UDim.new(0.5, 0)
		})
		irisAPI.DragNum({ "number", 1, 0, 100 }, {
			number = contentNumber
		})
		irisAPI.InputEnum({ "axis" }, {
			index = contentAxis
		}, Enum.Axis)
		irisAPI.PopConfig()
		irisAPI.SameLine()
		irisAPI.Text({ "Content Width = -150 pixels from the right side" })
		helpMarker("UDim.new(1, -150)")
		irisAPI.End()
		irisAPI.PushConfig({
			ContentWidth = UDim.new(1, -150)
		})
		irisAPI.DragNum({ "number", 1, 0, 100 }, {
			number = contentNumber
		})
		irisAPI.InputEnum({ "axis" }, {
			index = contentAxis
		}, Enum.Axis)
		irisAPI.PopConfig()
		irisAPI.End()
		irisAPI.Tree({ "Content Height" })
		local textContent = irisAPI.State("a single line")
		local heightNumber = irisAPI.State(50)
		local heightAxis = irisAPI.State(Enum.Axis.X)
		local heightProgress = irisAPI.State(0)
		heightProgress:set(math.clamp(math.abs(os.clock() * 15 % 100 - 50) - 7.5, 0, 35) / 35)
		irisAPI.Text({ "The Content Height is a size property that determines the minimum size of certain widgets." })
		irisAPI.Text({ "By default the value is UDim.new(0, 0), so there is no minimum height." })
		irisAPI.Text({ "We use Iris.PushConfig() to change this value." })
		irisAPI.Separator()
		irisAPI.SameLine()
		irisAPI.Text({ "Content Height = 0 pixels" })
		helpMarker("UDim.new(0, 0)")
		irisAPI.End()
		irisAPI.InputText({ "text" }, {
			text = textContent
		})
		irisAPI.ProgressBar({ "progress" }, {
			progress = heightProgress
		})
		irisAPI.DragNum({ "number", 1, 0, 100 }, {
			number = heightNumber
		})
		irisAPI.ComboEnum({ "axis" }, {
			index = heightAxis
		}, Enum.Axis)
		irisAPI.SameLine()
		irisAPI.Text({ "Content Height = 60 pixels" })
		helpMarker("UDim.new(0, 60)")
		irisAPI.End()
		irisAPI.PushConfig({
			ContentHeight = UDim.new(0, 60)
		})
		irisAPI.InputText({ "text", nil, nil, true }, {
			text = textContent
		})
		irisAPI.ProgressBar({ "progress" }, {
			progress = heightProgress
		})
		irisAPI.DragNum({ "number", 1, 0, 100 }, {
			number = heightNumber
		})
		irisAPI.ComboEnum({ "axis" }, {
			index = heightAxis
		}, Enum.Axis)
		irisAPI.PopConfig()
		irisAPI.Text({ "This property can be used to force the height of a text box." })
		irisAPI.Text({ "Just make sure you enable the MultiLine argument." })
		irisAPI.End()
		irisAPI.End()
	end
	local function windowlessDemo()
		irisAPI.PushConfig({
			ItemWidth = UDim.new(0, 150)
		})
		irisAPI.SameLine()
		irisAPI.TextWrapped({ "Windowless widgets" })
		helpMarker("Widgets which are placed outside of a window will appear on the top left side of the screen.")
		irisAPI.End()
		irisAPI.Button({})
		irisAPI.Tree({})
		irisAPI.InputText({})
		irisAPI.End()
		irisAPI.PopConfig()
	end
	return function()
		local noTitleBar = irisAPI.State(false)
		local noBackground = irisAPI.State(false)
		local noCollapse = irisAPI.State(false)
		local noClose = irisAPI.State(true)
		local noMove = irisAPI.State(false)
		local noScrollbar = irisAPI.State(false)
		local noResize = irisAPI.State(false)
		local noNav = irisAPI.State(false)
		local noMenu = irisAPI.State(false)
		if instance.value ~= false then
			debug.profilebegin("Iris/Demo/Window")
			local demoWindowElement = irisAPI.Window({
				[irisAPI.Args.Window.Title] = "Iris Demo Window",
				[irisAPI.Args.Window.NoTitleBar] = noTitleBar.value,
				[irisAPI.Args.Window.NoBackground] = noBackground.value,
				[irisAPI.Args.Window.NoCollapse] = noCollapse.value,
				[irisAPI.Args.Window.NoClose] = noClose.value,
				[irisAPI.Args.Window.NoMove] = noMove.value,
				[irisAPI.Args.Window.NoScrollbar] = noScrollbar.value,
				[irisAPI.Args.Window.NoResize] = noResize.value,
				[irisAPI.Args.Window.NoNav] = noNav.value,
				[irisAPI.Args.Window.NoMenu] = noMenu.value
			}, {
				size = irisAPI.State(Vector2.new(600, 550)),
				position = irisAPI.State(Vector2.new(100, 25)),
				isOpened = instance
			})
			if demoWindowElement.state.isUncollapsed.value and demoWindowElement.state.isOpened.value then
				debug.profilebegin("Iris/Demo/MenuBar")
				mainMenuBar()
				debug.profileend()
				irisAPI.Text({ "Iris says hello. (" .. irisAPI.Internal._version .. ")" })
				debug.profilebegin("Iris/Demo/Options")
				irisAPI.CollapsingHeader({ "Window Options" })
				irisAPI.Table({ 3, false, false, false })
				irisAPI.Checkbox({ "NoTitleBar" }, {
					isChecked = noTitleBar
				})
				irisAPI.NextColumn()
				irisAPI.Checkbox({ "NoBackground" }, {
					isChecked = noBackground
				})
				irisAPI.NextColumn()
				irisAPI.Checkbox({ "NoCollapse" }, {
					isChecked = noCollapse
				})
				irisAPI.NextColumn()
				irisAPI.Checkbox({ "NoClose" }, {
					isChecked = noClose
				})
				irisAPI.NextColumn()
				irisAPI.Checkbox({ "NoMove" }, {
					isChecked = noMove
				})
				irisAPI.NextColumn()
				irisAPI.Checkbox({ "NoScrollbar" }, {
					isChecked = noScrollbar
				})
				irisAPI.NextColumn()
				irisAPI.Checkbox({ "NoResize" }, {
					isChecked = noResize
				})
				irisAPI.NextColumn()
				irisAPI.Checkbox({ "NoNav" }, {
					isChecked = noNav
				})
				irisAPI.NextColumn()
				irisAPI.Checkbox({ "NoMenu" }, {
					isChecked = noMenu
				})
				irisAPI.NextColumn()
				irisAPI.End()
				irisAPI.End()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Events")
				widgetEventInteractivity()
				debug.profileend()
				debug.profilebegin("Iris/Demo/States")
				widgetStateInteractivity()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Recursive")
				irisAPI.CollapsingHeader({ "Recursive Tree" })
				if irisAPI.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
					recursiveTree()
				end
				irisAPI.End()
				irisAPI.End()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Style")
				dynamicStyle()
				debug.profileend()
				irisAPI.Separator()
				debug.profilebegin("Iris/Demo/Widgets")
				irisAPI.CollapsingHeader({ "Widgets" })
				for demoIndex, demoName in widgetDemoNamesList do
					debug.profilebegin((("Iris/Demo/Widgets/%s"):format(demoName)))
					widgetDemosMap[demoName]()
					debug.profileend()
				end
				irisAPI.End()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Tables")
				tablesDemo()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Layout")
				layoutDemo()
				debug.profileend()
				irisAPI.CollapsingHeader({ "Background" })
				irisAPI.Checkbox({ "Show background colour" }, {
					isChecked = var8
				})
				irisAPI.InputColor4({ "Background colour" }, {
					color = var9,
					transparency = var10
				})
				irisAPI.End()
			end
			irisAPI.End()
			debug.profileend()
			if vector2.value then
				recursiveWindow(vector2)
			end
			if instance3.value then
				runtimeInfo()
			end
			if var7.value then
				debugPanel()
			end
			if var4.value then
				styleEditor()
			end
			if var5.value then
				windowlessDemo()
			end
			if func6.value then
				mainMenuBar()
			end
			return demoWindowElement
		end
		irisAPI.Checkbox({ "Open main window" }, {
			isChecked = instance
		})
		return
	end
end
