-- Reviewed by Claude
require(script.Parent.Types)
return function(irisContext)
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
	local function helpMarker(p12)
		p1.PushConfig({
			TextColor = p1._config.TextDisabledColor
		})
		local instance = p1.Text({ "(?)" })
		p1.PopConfig()
		p1.PushConfig({
			ContentWidth = UDim.new(0, 350)
		})
		if instance.hovered() then
			p1.Tooltip({ p12 })
		end
		p1.PopConfig()
	end
	local function textAndHelpMarker(p12, p2)
		p1.SameLine()
		p1.Text({ p12 })
		helpMarker(p2)
		p1.End()
	end
	local t = {
		Basic = function()
			p1.Tree({ "Basic" })
			p1.SeparatorText({ "Basic" })
			local instance = p1.State(1)
			p1.Button({ "Button" })
			p1.SmallButton({ "SmallButton" })
			p1.Text({ "Text" })
			p1.TextWrapped({ string.rep("Text Wrapped ", 5) })
			p1.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) })
			p1.Text({ "Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>", true, nil, true })
			p1.SameLine()
			p1.RadioButton({ "Index \'1\'", 1 }, {
				index = instance
			})
			p1.RadioButton({ "Index \'two\'", "two" }, {
				index = instance
			})
			if p1.RadioButton({ "Index \'false\'", false }, {
				index = instance
			}).active() == false and p1.SmallButton({ "Select last" }).clicked() then
				instance:set(false)
			end
			p1.End()
			local t = {}
			t[1] = "The Index is: " .. tostring(instance.value)
			p1.Text(t)
			p1.SeparatorText({ "Inputs" })
			p1.InputNum({})
			p1.DragNum({})
			p1.SliderNum({})
			p1.End()
		end,
		Image = function()
			p1.Tree({ "Image" })
			p1.SeparatorText({ "Image Controls" })
			local instance = p1.State("rbxasset://textures/ui/common/robux.png")
			local vector2 = p1.State(UDim2.fromOffset(100, 100))
			local instance3 = p1.State(Rect.new(0, 0, 0, 0))
			local var4 = p1.State(Enum.ScaleType.Stretch)
			local var5 = p1.State(false)
			local func6 = p1.ComputedState(var5, function(p1)
				return p1 and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default
			end)
			local var7 = p1.State(p1._config.ImageColor)
			local var8 = p1.State(p1._config.ImageTransparency)
			p1.InputColor4({ "Image Tint" }, {
				color = var7,
				transparency = var8
			})
			p1.Combo({ "Asset" }, {
				index = instance
			})
			p1.Selectable({ "Robux Small", "rbxasset://textures/ui/common/robux.png" }, {
				index = instance
			})
			p1.Selectable({ "Robux Large", "rbxasset://textures//ui/common/robux@3x.png" }, {
				index = instance
			})
			p1.Selectable({ "Loading Texture", "rbxasset://textures//loading/darkLoadingTexture.png" }, {
				index = instance
			})
			p1.Selectable({ "Hue-Saturation Gradient", "rbxasset://textures//TagEditor/huesatgradient.png" }, {
				index = instance
			})
			p1.Selectable({ "famfamfam.png (WHY?)", "rbxasset://textures//TagEditor/famfamfam.png" }, {
				index = instance
			})
			p1.End()
			p1.SliderUDim2({
				"Image Size",
				nil,
				nil,
				UDim2.new(1, 240, 1, 240)
			}, {
				number = vector2
			})
			p1.SliderRect({
				"Image Rect",
				nil,
				nil,
				Rect.new(256, 256, 256, 256)
			}, {
				number = instance3
			})
			p1.Combo({ "Scale Type" }, {
				index = var4
			})
			p1.Selectable({ "Stretch", Enum.ScaleType.Stretch }, {
				index = var4
			})
			p1.Selectable({ "Fit", Enum.ScaleType.Fit }, {
				index = var4
			})
			p1.Selectable({ "Crop", Enum.ScaleType.Crop }, {
				index = var4
			})
			p1.End()
			p1.Checkbox({ "Pixelated" }, {
				isChecked = var5
			})
			p1.PushConfig({
				ImageColor = var7:get(),
				ImageTransparency = var8:get()
			})
			p1.Image({
				instance:get(),
				vector2:get(),
				instance3:get(),
				var4:get(),
				func6:get()
			})
			p1.PopConfig()
			p1.SeparatorText({ "Tile" })
			local var9 = p1.State(UDim2.fromScale(0.5, 0.5))
			p1.SliderUDim2({
				"Tile Size",
				nil,
				nil,
				UDim2.new(1, 240, 1, 240)
			}, {
				number = var9
			})
			p1.PushConfig({
				ImageColor = var7:get(),
				ImageTransparency = var8:get()
			})
			p1.Image({
				"rbxasset://textures/grid2.png",
				vector2:get(),
				nil,
				Enum.ScaleType.Tile,
				func6:get(),
				var9:get()
			})
			p1.PopConfig()
			p1.SeparatorText({ "Slice" })
			local var10 = p1.State(1)
			p1.SliderNum({ "Image Slice Scale", 0.1, 0.1, 5 }, {
				number = var10
			})
			p1.PushConfig({
				ImageColor = var7:get(),
				ImageTransparency = var8:get()
			})
			p1.Image({
				"rbxasset://textures/ui/chatBubble_blue_notify_bkg.png",
				vector2:get(),
				nil,
				Enum.ScaleType.Slice,
				func6:get(),
				nil,
				Rect.new(12, 12, 56, 56),
				1
			}, var10:get())
			p1.PopConfig()
			p1.SeparatorText({ "Image Button" })
			local var11 = p1.State(0)
			p1.SameLine()
			p1.PushConfig({
				ImageColor = var7:get(),
				ImageTransparency = var8:get()
			})
			if p1.ImageButton({ "rbxasset://textures/AvatarCompatibilityPreviewer/add.png", UDim2.fromOffset(20, 20) }).clicked() then
				var11:set(var11.value + 1)
			end
			p1.PopConfig()
			p1.Text({ (("Click count: %*"):format(var11.value)) })
			p1.End()
			p1.End()
		end,
		Selectable = function()
			p1.Tree({ "Selectable" })
			local instance = p1.State(2)
			p1.Selectable({ "Selectable #1", 1 }, {
				index = instance
			})
			p1.Selectable({ "Selectable #2", 2 }, {
				index = instance
			})
			if p1.Selectable({ "Double click Selectable", 3, true }, {
				index = instance
			}).doubleClicked() then
				instance:set(3)
			end
			p1.Selectable({ "Impossible to select", 4, true }, {
				index = instance
			})
			if p1.Button({ "Select last" }).clicked() then
				instance:set(4)
			end
			p1.Selectable({ "Independent Selectable" })
			p1.End()
		end,
		Combo = function()
			p1.Tree({ "Combo" })
			p1.PushConfig({
				ContentWidth = UDim.new(1, -200)
			})
			local instance = p1.State("No Selection")
			p1.SameLine()
			local vector2 = p1.Checkbox({ "No Preview" })
			local instance3 = p1.Checkbox({ "No Button" })
			if vector2.checked() and instance3.isChecked.value == true then
				instance3.isChecked:set(false)
			end
			local var4 = instance3
			if var4.checked() and vector2.isChecked.value == true then
				vector2.isChecked:set(false)
			end
			p1.End()
			p1.Combo({ "Basic Usage", var4.isChecked:get(), vector2.isChecked:get() }, {
				index = instance
			})
			p1.Selectable({ "Select 1", "One" }, {
				index = instance
			})
			p1.Selectable({ "Select 2", "Two" }, {
				index = instance
			})
			p1.Selectable({ "Select 3", "Three" }, {
				index = instance
			})
			p1.End()
			p1.ComboArray({ "Using ComboArray" }, {
				index = "No Selection"
			}, { "Red", "Green", "Blue" })
			local t = {}
			for i = 1, 50 do
				table.insert(t, (tostring(i)))
			end
			p1.ComboArray({ "Height Test" }, {
				index = "1"
			}, t)
			local var7 = p1.State("7 AM")
			p1.Combo({ "Combo with Inner widgets" }, {
				index = var7
			})
			p1.Tree({ "Morning Shifts" })
			p1.Selectable({ "Shift at 7 AM", "7 AM" }, {
				index = var7
			})
			p1.Selectable({ "Shift at 11 AM", "11 AM" }, {
				index = var7
			})
			p1.Selectable({ "Shift at 3 PM", "3 PM" }, {
				index = var7
			})
			p1.End()
			p1.Tree({ "Night Shifts" })
			p1.Selectable({ "Shift at 6 PM", "6 PM" }, {
				index = var7
			})
			p1.Selectable({ "Shift at 9 PM", "9 PM" }, {
				index = var7
			})
			p1.End()
			p1.End()
			p1.Text({ "Selected: " .. p1.ComboEnum({ "Using ComboEnum" }, {
					index = Enum.UserInputState.Begin
				}, Enum.UserInputState).index:get().Name })
			p1.PopConfig()
			p1.End()
		end,
		Tree = function()
			p1.Tree({ "Trees" })
			p1.Tree({ "Tree using SpanAvailWidth", true })
			helpMarker("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area")
			p1.End()
			local instance = p1.Tree({ "Tree with Children" })
			p1.Text({ "Im inside the first tree!" })
			p1.Button({ "Im a button inside the first tree!" })
			p1.Tree({ "Im a tree inside the first tree!" })
			p1.Text({ "I am the innermost text!" })
			p1.End()
			p1.End()
			p1.Checkbox({ "Toggle above tree" }, {
				isChecked = instance.state.isUncollapsed
			})
			p1.End()
		end,
		CollapsingHeader = function()
			p1.Tree({ "Collapsing Headers" })
			p1.CollapsingHeader({ "A header" })
			p1.Text({ "This is under the first header!" })
			p1.End()
			local instance = p1.State(false)
			p1.CollapsingHeader({ "Another header" }, {
				isUncollapsed = instance
			})
			if p1.Button({ "Shhh... secret button!" }).clicked() then
				instance:set(true)
			end
			p1.End()
			p1.End()
		end,
		Group = function()
			p1.Tree({ "Groups" })
			p1.SameLine()
			p1.Group()
			p1.Text({ "I am in group A" })
			p1.Button({ "Im also in A" })
			p1.End()
			p1.Separator()
			p1.Group()
			p1.Text({ "I am in group B" })
			p1.Button({ "Im also in B" })
			p1.Button({ "Also group B" })
			p1.End()
			p1.End()
			p1.End()
		end,
		Tab = function()
			p1.Tree({ "Tabs" })
			p1.Tree({ "Simple" })
			p1.TabBar()
			p1.Tab({ "Apples" })
			p1.Text({ "Who loves apples?" })
			p1.End()
			p1.Tab({ "Broccoli" })
			p1.Text({ "And what about broccoli?" })
			p1.End()
			p1.Tab({ "Carrots" })
			p1.Text({ "But carrots are the best." })
			p1.End()
			p1.End()
			p1.Separator()
			p1.Text({ "Very important questions." })
			p1.End()
			p1.Tree({ "Closable" })
			local instance = p1.State(true)
			local vector2 = p1.State(true)
			local instance3 = p1.State(true)
			p1.TabBar()
			p1.Tab({ "\240\159\141\142", true }, {
				isOpened = instance
			})
			p1.Text({ "Who loves apples?" })
			if p1.Button({ "I don\'t like apples." }).clicked() then
				instance:set(false)
			end
			p1.End()
			p1.Tab({ "\240\159\165\166", true }, {
				isOpened = vector2
			})
			p1.Text({ "And what about broccoli?" })
			if p1.Button({ "Not for me." }).clicked() then
				vector2:set(false)
			end
			p1.End()
			p1.Tab({ "\240\159\165\149", true }, {
				isOpened = instance3
			})
			p1.Text({ "But carrots are the best." })
			if p1.Button({ "I disagree with you." }).clicked() then
				instance3:set(false)
			end
			p1.End()
			p1.End()
			p1.Separator()
			if p1.Button({ "Actually, let me reconsider it." }).clicked() then
				instance:set(true)
				vector2:set(true)
				instance3:set(true)
			end
			p1.End()
			p1.End()
		end,
		Indent = function()
			p1.Tree({ "Indents" })
			p1.Text({ "Not Indented" })
			p1.Indent()
			p1.Text({ "Indented" })
			p1.Indent({ 7 })
			p1.Text({ "Indented by 7 more pixels" })
			p1.End()
			p1.Indent({ -7 })
			p1.Text({ "Indented by 7 less pixels" })
			p1.End()
			p1.End()
			p1.End()
		end,
		Input = function()
			p1.Tree({ "Input" })
			local instance = p1.State(false)
			local vector2 = p1.State(false)
			local instance3 = p1.State(0)
			local var4 = p1.State(100)
			local var5 = p1.State(1)
			local func6 = p1.State("%d")
			p1.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			local var7 = p1.InputNum({
				[p1.Args.InputNum.Text] = "Input Number",
				[p1.Args.InputNum.NoButtons] = vector2.value,
				[p1.Args.InputNum.Min] = instance3.value,
				[p1.Args.InputNum.Max] = var4.value,
				[p1.Args.InputNum.Increment] = var5.value,
				[p1.Args.InputNum.Format] = { func6.value }
			})
			p1.PopConfig()
			p1.Text({ "The Value is: " .. var7.number.value })
			if p1.Button({ "Randomize Number" }).clicked() then
				var7.number:set(math.random(1, 99))
			end
			local var8 = p1.Checkbox({ "NoField" }, {
				isChecked = instance
			})
			local var9 = p1.Checkbox({ "NoButtons" }, {
				isChecked = vector2
			})
			if var8.checked() and var9.isChecked.value == true then
				var9.isChecked:set(false)
			end
			if var9.checked() and var8.isChecked.value == true then
				var8.isChecked:set(false)
			end
			p1.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			p1.InputVector2({ "InputVector2" })
			p1.InputVector3({ "InputVector3" })
			p1.InputUDim({ "InputUDim" })
			p1.InputUDim2({ "InputUDim2" })
			local var10 = p1.State(false)
			local var11 = p1.State(false)
			local color12 = p1.State(Color3.new())
			local var13 = p1.State(0)
			p1.SliderNum({ "Transparency", 0.01, 0, 1 }, {
				number = var13
			})
			p1.InputColor3({ "InputColor3", var10:get(), var11:get() }, {
				color = color12
			})
			p1.InputColor4({ "InputColor4", var10:get(), var11:get() }, {
				color = color12,
				transparency = var13
			})
			p1.SameLine()
			p1.Text({ (("#%*"):format((color12:get():ToHex()))) })
			p1.Checkbox({ "Use Floats" }, {
				isChecked = var10
			})
			p1.Checkbox({ "Use HSV" }, {
				isChecked = var11
			})
			p1.End()
			p1.PopConfig()
			p1.Separator()
			p1.SameLine()
			p1.Text({ "Slider Numbers" })
			helpMarker("ctrl + click slider number widgets to input a number")
			p1.End()
			p1.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			p1.SliderNum({ "Slide Int", 1, 1, 8 })
			p1.SliderNum({ "Slide Float", 0.01, 0, 100 })
			p1.SliderNum({ "Small Numbers", 0.001, -2, 1, "%f radians" })
			p1.SliderNum({ "Odd Ranges", 0.001, -3.141592653589793, math.pi, "%f radians" })
			p1.SliderNum({ "Big Numbers", 10000, 100000, 10000000 })
			p1.SliderNum({ "Few Numbers", 1, 0, 3 })
			p1.PopConfig()
			p1.Separator()
			p1.SameLine()
			p1.Text({ "Drag Numbers" })
			helpMarker("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed")
			p1.End()
			p1.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			p1.DragNum({ "Drag Int" })
			p1.DragNum({ "Slide Float", 0.001, -10, 10 })
			p1.DragNum({ "Percentage", 1, 0, 100, "%d %%" })
			p1.PopConfig()
			p1.End()
		end,
		InputText = function()
			p1.Tree({ "Input Text" })
			p1.Text({ "The text is: " .. p1.InputText({ "Input Text Test", "Input Text here" }).text.value })
			p1.End()
		end,
		MultiInput = function()
			p1.Tree({ "Multi-Component Input" })
			local instance = p1.State(Vector2.new())
			local vector2 = p1.State((Vector3.new()))
			local instance3 = p1.State(UDim.new())
			local var4 = p1.State(UDim2.new())
			local var5 = p1.State(Color3.new())
			local func6 = p1.State(Rect.new(0, 0, 0, 0))
			p1.SeparatorText({ "Input" })
			p1.InputVector2({}, {
				number = instance
			})
			p1.InputVector3({}, {
				number = vector2
			})
			p1.InputUDim({}, {
				number = instance3
			})
			p1.InputUDim2({}, {
				number = var4
			})
			p1.InputRect({}, {
				number = func6
			})
			p1.SeparatorText({ "Drag" })
			p1.DragVector2({}, {
				number = instance
			})
			p1.DragVector3({}, {
				number = vector2
			})
			p1.DragUDim({}, {
				number = instance3
			})
			p1.DragUDim2({}, {
				number = var4
			})
			p1.DragRect({}, {
				number = func6
			})
			p1.SeparatorText({ "Slider" })
			p1.SliderVector2({}, {
				number = instance
			})
			p1.SliderVector3({}, {
				number = vector2
			})
			p1.SliderUDim({}, {
				number = instance3
			})
			p1.SliderUDim2({}, {
				number = var4
			})
			p1.SliderRect({}, {
				number = func6
			})
			p1.SeparatorText({ "Color" })
			p1.InputColor3({}, {
				color = var5
			})
			p1.InputColor4({}, {
				color = var5
			})
			p1.End()
		end,
		Tooltip = function()
			p1.PushConfig({
				ContentWidth = UDim.new(0, 250)
			})
			p1.Tree({ "Tooltip" })
			if p1.Text({ "Hover over me to reveal a tooltip" }).hovered() then
				p1.Tooltip({ "I am some helpful tooltip text" })
			end
			local instance = p1.State("Hello ")
			local vector2 = p1.State(1)
			if p1.InputNum({ "# of repeat", 1, 1, 50 }, {
				number = vector2
			}).numberChanged() then
				instance:set(string.rep("Hello ", vector2:get()))
			end
			if p1.Checkbox({ "Show dynamic text tooltip" }).state.isChecked.value then
				p1.Tooltip({ instance:get() })
			end
			p1.End()
			p1.PopConfig()
		end,
		Plotting = function()
			p1.Tree({ "Plotting" })
			p1.SeparatorText({ "Progress" })
			local instance = os.clock() * 15
			local vector2 = p1.State(0)
			vector2:set(math.clamp(math.abs(instance % 100 - 50) - 7.5, 0, 35) / 35)
			p1.ProgressBar({ "Progress Bar" }, {
				progress = vector2
			})
			local t = {}
			local var4 = vector2:get() * 1753
			t[1] = "Progress Bar"
			t[2] = ("%*/1753"):format((math.floor(var4)))
			p1.ProgressBar(t, {
				progress = vector2
			})
			p1.SeparatorText({ "Graphs" })
			local var5 = p1.State({
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
			p1.PlotHistogram({ "Histogram", 100, 0, 1, "random" }, {
				values = var5
			})
			p1.PlotLines({ "Lines", 100, 0, 1, "random" }, {
				values = var5
			})
			local func6 = p1.State("Cos")
			local var7 = p1.State(37)
			local var8 = p1.State(0)
			local var9 = p1.State({})
			local var10 = p1.State(0)
			local var11 = p1.Checkbox({ "Animate" })
			local color12 = p1.ComboArray({ "Plotting Function" }, {
				index = func6
			}, { "Sin", "Cos", "Tan", "Saw" })
			local var13 = p1.SliderNum({ "Samples", 1, 1, 145, "%d samples" }, {
				number = var7
			})
			if p1.SliderNum({ "Baseline", 0.1, -1, 1 }, {
				number = var8
			}).numberChanged() then
				var9:set(var9.value, true)
			end
			if var11.state.isChecked.value or (color12.closed() or (var13.numberChanged() or #var9.value == 0)) then
				if var11.state.isChecked.value then
					var10:set(var10.value + p1.Internal._deltaTime)
				end
				local var15 = math.floor(var10.value * 30) - 1
				local value = func6.value
				table.clear(var9.value)
				for i = 1, var7.value do
					local var16
					if value == "Sin" then
						var9.value[i] = math.sin((math.rad((i + var15) * 5)))
					elseif value == "Cos" then
						var9.value[i] = math.cos((math.rad((i + var15) * 5)))
					elseif value == "Tan" then
						var9.value[i] = math.tan((math.rad((i + var15) * 5)))
					elseif value == "Saw" then
						var16 = if i % 2 == var15 % 2 then 1 else -1
						var9.value[i] = var16
					end
				end
				var9:set(var9.value, true)
			end
			p1.PlotHistogram({
				"Histogram",
				100,
				-1,
				1,
				"",
				var8:get()
			}, {
				values = var9
			})
			p1.PlotLines({ "Lines", 100, -1, 1 }, {
				values = var9
			})
			p1.End()
		end
	}
	local t2 = {
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
	local function var11()
		if p1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
			var11()
		end
		p1.End()
	end
	local function color12(p12)
		p1.Window({ "Recursive Window" }, {
			size = p1.State(Vector2.new(175, 100)),
			isOpened = p12
		})
		local instance = p1.Checkbox({ "Recurse Again" })
		p1.End()
		if instance.isChecked.value then
			color12(instance.isChecked)
		end
	end
	local function runtimeInfo()
		local instance = p1.Window({ "Runtime Info" }, {
			isOpened = instance3
		})
		local _lastVDOM = p1.Internal._lastVDOM
		local _states = p1.Internal._states
		local vector2 = p1.State(3)
		local var32 = p1.State(0)
		local var4 = p1.State(os.clock())
		p1.SameLine()
		p1.InputNum({
			[p1.Args.InputNum.Text] = "",
			[p1.Args.InputNum.Format] = "%d Seconds",
			[p1.Args.InputNum.Max] = 10
		}, {
			number = vector2
		})
		if p1.Button({ "Disable" }).clicked() then
			p1.Disabled = true
			task.delay(vector2:get(), function()
				p1.Disabled = false
			end)
		end
		p1.End()
		local var5 = os.clock()
		var32.value = var32.value + (var5 - var4.value - var32.value) * 0.2
		var4.value = var5
		p1.Text({ string.format("Average %.3f ms/frame (%.1f FPS)", var32.value * 1000, 1 / var32.value) })
		p1.Text({ string.format("Window Position: (%d, %d), Window Size: (%d, %d)", instance.position.value.X, instance.position.value.Y, instance.size.value.X, instance.size.value.Y) })
		p1.SameLine()
		p1.Text({ "Enter an ID to learn more about it." })
		helpMarker("every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs")
		p1.End()
		p1.PushConfig({
			ItemWidth = UDim.new(1, -150)
		})
		local value = p1.InputText({ "ID field" }, {
			text = p1.State(instance.ID)
		}).state.text.value
		p1.PopConfig()
		p1.Indent()
		local var7 = _lastVDOM[value]
		local var8 = _states[value]
		if var7 then
			p1.Table({ 1 })
			p1.Text({ string.format("The ID, \"%s\", is a widget", value) })
			p1.NextRow()
			p1.Text({ string.format("Widget is type: %s", var7.type) })
			p1.NextRow()
			p1.Tree({ "Widget has Args:" }, {
				isUncollapsed = p1.State(true)
			})
			for var9, var10 in var7.arguments do
				p1.Text({ var9 .. " - " .. tostring(var10) })
			end
			p1.End()
			p1.NextRow()
			if var7.state then
				p1.Tree({ "Widget has State:" }, {
					isUncollapsed = p1.State(true)
				})
				for var11, color12 in var7.state do
					local t = {}
					t[1] = var11 .. " - " .. tostring(color12.value)
					p1.Text(t)
				end
				p1.End()
			end
			p1.End()
		elseif var8 then
			p1.Table({ 1 })
			p1.Text({ string.format("The ID, \"%s\", is a state", value) })
			p1.NextRow()
			local t = {}
			t[1] = string.format("Value is type: %s, Value = %s", typeof(var8.value), (tostring(var8.value)))
			p1.Text(t)
			p1.NextRow()
			p1.Tree({ "state has connected widgets:" }, {
				isUncollapsed = p1.State(true)
			})
			for var14, var15 in var8.ConnectedWidgets do
				p1.Text({ var14 .. " - " .. var15.type })
			end
			p1.End()
			p1.NextRow()
			p1.Text({ string.format("state has: %d connected functions", #var8.ConnectedFunctions) })
			p1.End()
		else
			p1.Text({ string.format("The ID, \"%s\", is not a state or widget", value) })
		end
		p1.End()
		if p1.Tree({ "Widgets" }).state.isUncollapsed.value then
			local count = 0
			local var16 = ""
			for var17, var18 in _lastVDOM do
				var16 = var16 .. "\n" .. var18.ID .. " - " .. var18.type
				count = count + 1
			end
			p1.Text({ "Number of Widgets: " .. count })
			p1.Text({ var16 })
		end
		p1.End()
		if p1.Tree({ "States" }).state.isUncollapsed.value then
			local count = 0
			local var19 = ""
			for var20, table21 in _states do
				var19 = var19 .. "\n" .. var20 .. " - " .. tostring(table21.value)
				count = count + 1
			end
			p1.Text({ "Number of States: " .. count })
			p1.Text({ var19 })
		end
		p1.End()
		p1.End()
	end
	local function debugPanel()
		p1.Window({ "Debug Panel" }, {
			isOpened = var7
		})
		p1.CollapsingHeader({ "Widgets" })
		p1.SeparatorText({ "GuiService" })
		p1.Text({ (("GuiOffset: %*"):format(p1.Internal._utility.GuiOffset)) })
		p1.Text({ (("MouseOffset: %*"):format(p1.Internal._utility.MouseOffset)) })
		p1.SeparatorText({ "UserInputService" })
		p1.Text({ (("MousePosition: %*"):format((p1.Internal._utility.UserInputService:GetMouseLocation()))) })
		p1.Text({ (("MouseLocation: %*"):format((p1.Internal._utility.getMouseLocation()))) })
		p1.Text({ (("Left Control: %*"):format((p1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)))) })
		p1.Text({ (("Right Control: %*"):format((p1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)))) })
		p1.End()
		p1.End()
	end
	local function var13()
		if p1.Menu({ "Recursive" }).state.isOpened.value then
			p1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
			p1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
			p1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
			p1.Separator()
			p1.MenuToggle({ "Autosave" })
			p1.MenuToggle({ "Checked" })
			p1.Separator()
			p1.Menu({ "Options" })
			p1.MenuItem({ "Red" })
			p1.MenuItem({ "Yellow" })
			p1.MenuItem({ "Green" })
			p1.MenuItem({ "Blue" })
			p1.Separator()
			var13()
			p1.End()
		end
		p1.End()
	end
	local function mainMenuBar()
		p1.MenuBar()
		p1.Menu({ "File" })
		p1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
		p1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
		p1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
		var13()
		if p1.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt }).clicked() then
			instance:set(false)
		end
		p1.End()
		p1.Menu({ "Examples" })
		p1.MenuToggle({ "Recursive Window" }, {
			isChecked = vector2
		})
		p1.MenuToggle({ "Windowless" }, {
			isChecked = var5
		})
		p1.MenuToggle({ "Main Menu Bar" }, {
			isChecked = func6
		})
		p1.End()
		p1.Menu({ "Tools" })
		p1.MenuToggle({ "Runtime Info" }, {
			isChecked = instance3
		})
		p1.MenuToggle({ "Style Editor" }, {
			isChecked = var4
		})
		p1.MenuToggle({ "Debug Panel" }, {
			isChecked = var7
		})
		p1.End()
		p1.End()
	end
	local function mainMenuBarExample()
		mainMenuBar()
	end
	local function f14()
		local list = {
			{ "Sizing", function()
					local instance = p1.State({})
					p1.SameLine()
					if p1.Button({ "Update" }).clicked() then
						p1.UpdateGlobalConfig(instance.value)
						instance:set({})
					end
					helpMarker("Update the global config with these changes.")
					p1.End()
					local function SliderInput(p12, p2)
						local color12 = p1[p12](p2, {
							number = p1.WeakState(p1._config[p2[1]])
						})
						if color12.numberChanged() then
							instance.value[p2[1]] = color12.number:get()
						end
					end
					local function BooleanInput(p12)
						local color12 = p1.Checkbox(p12, {
							isChecked = p1.WeakState(p1._config[p12[1]])
						})
						if color12.checked() or color12.unchecked() then
							instance.value[p12[1]] = color12.isChecked:get()
						end
					end
					p1.SeparatorText({ "Main" })
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
					p1.SeparatorText({ "Borders & Rounding" })
					SliderInput("SliderNum", { "FrameBorderSize", 0.1, 0, 1 })
					SliderInput("SliderNum", { "WindowBorderSize", 0.1, 0, 1 })
					SliderInput("SliderNum", { "PopupBorderSize", 0.1, 0, 1 })
					SliderInput("SliderNum", { "SeparatorTextBorderSize", 1, 0, 20 })
					SliderInput("SliderNum", { "FrameRounding", 1, 0, 12 })
					SliderInput("SliderNum", { "GrabRounding", 1, 0, 12 })
					SliderInput("SliderNum", { "PopupRounding", 1, 0, 12 })
					p1.SeparatorText({ "Widgets" })
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
					local vector2 = p1.ComboEnum({ "WindowTitleAlign" }, {
						index = p1.WeakState(p1._config.WindowTitleAlign)
					}, Enum.LeftRight)
					if vector2.closed() then
						instance.value.WindowTitleAlign = vector2.index:get()
					end
					BooleanInput({ "RichText" })
					BooleanInput({ "TextWrapped" })
					p1.SeparatorText({ "Config" })
					BooleanInput({ "UseScreenGUIs" })
					SliderInput("DragNum", { "DisplayOrderOffset", 1, 0 })
					SliderInput("DragNum", { "ZIndexOffset", 1, 0 })
					SliderInput("SliderNum", { "MouseDoubleClickTime", 0.1, 0, 5 })
					SliderInput("SliderNum", { "MouseDoubleClickMaxDist", 0.1, 0, 20 })
				end },
			{ "Colors", function()
					local instance = p1.State({})
					p1.SameLine()
					if p1.Button({ "Update" }).clicked() then
						p1.UpdateGlobalConfig(instance.value)
						instance:set({})
					end
					helpMarker("Update the global config with these changes.")
					p1.End()
					for vector2, instance3 in {
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
						local var4 = p1.InputColor4({ instance3 }, {
							color = p1.WeakState(p1._config[instance3 .. "Color"]),
							transparency = p1.WeakState(p1._config[instance3 .. "Transparency"])
						})
						if var4.numberChanged() then
							instance.value[instance3 .. "Color"] = var4.color:get()
							instance.value[instance3 .. "Transparency"] = var4.transparency:get()
						end
					end
				end },
			{ "Fonts", function()
					local instance = p1.State({})
					p1.SameLine()
					if p1.Button({ "Update" }).clicked() then
						p1.UpdateGlobalConfig(instance.value)
						instance:set({})
					end
					helpMarker("Update the global config with these changes.")
					p1.End()
					local t = {
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
					p1.Text({ (("Current Font: %* Weight: %* Style: %*"):format(p1._config.TextFont.Family, p1._config.TextFont.Weight, p1._config.TextFont.Style)) })
					p1.SeparatorText({ "Size" })
					local vector2 = p1.SliderNum({ "Font Size", 1, 4, 20 }, {
						number = p1.WeakState(p1._config.TextSize)
					})
					if vector2.numberChanged() then
						instance.value.TextSize = vector2.state.number:get()
					end
					p1.SeparatorText({ "Properties" })
					local instance3 = p1.WeakState(p1._config.TextFont.Family)
					local var4 = p1.ComboEnum({ "Font Weight" }, {
						index = p1.WeakState(p1._config.TextFont.Weight)
					}, Enum.FontWeight)
					local var5 = p1.ComboEnum({ "Font Style" }, {
						index = p1.WeakState(p1._config.TextFont.Style)
					}, Enum.FontStyle)
					p1.SeparatorText({ "Fonts" })
					for func6, var7 in t do
						local var8 = Font.new(var7.Family, var4.state.index.value, var5.state.index.value)
						p1.SameLine()
						p1.PushConfig({
							TextFont = var8
						})
						if p1.Selectable({ ("%* | \"The quick brown fox jumps over the lazy dog.\""):format(func6), var8.Family }, {
							index = instance3
						}).selected() then
							instance.value.TextFont = var8
						end
						p1.PopConfig()
						p1.End()
					end
				end }
		}
		p1.Window({ "Style Editor" }, {
			isOpened = var4
		})
		p1.Text({ "Customize the look of Iris in realtime." })
		local instance = p1.State("Dark Theme")
		if p1.ComboArray({ "Theme" }, {
			index = instance
		}, { "Dark Theme", "Light Theme" }).closed() then
			if instance.value == "Dark Theme" then
				p1.UpdateGlobalConfig(p1.TemplateConfig.colorDark)
			elseif instance.value == "Light Theme" then
				p1.UpdateGlobalConfig(p1.TemplateConfig.colorLight)
			end
		end
		local vector2 = p1.State("Classic Size")
		if p1.ComboArray({ "Size" }, {
			index = vector2
		}, { "Classic Size", "Larger Size" }).closed() then
			if vector2.value == "Classic Size" then
				p1.UpdateGlobalConfig(p1.TemplateConfig.sizeDefault)
			elseif vector2.value == "Larger Size" then
				p1.UpdateGlobalConfig(p1.TemplateConfig.sizeClear)
			end
		end
		p1.SameLine()
		if p1.Button({ "Revert" }).clicked() then
			p1.UpdateGlobalConfig(p1.TemplateConfig.colorDark)
			p1.UpdateGlobalConfig(p1.TemplateConfig.sizeDefault)
			instance:set("Dark Theme")
			vector2:set("Classic Size")
		end
		helpMarker("Reset Iris to the default theme and size.")
		p1.End()
		p1.TabBar()
		for i, v in ipairs(list) do
			p1.Tab({ v[1] })
			list[i][2]()
			p1.End()
		end
		p1.End()
		p1.Separator()
		p1.End()
	end
	local function widgetEventInteractivity()
		p1.CollapsingHeader({ "Widget Event Interactivity" })
		local instance = p1.State(0)
		if p1.Button({ "Click to increase Number" }).clicked() then
			instance:set(instance:get() + 1)
		end
		p1.Text({ "The Number is: " .. instance:get() })
		p1.Separator()
		local vector2 = p1.State(false)
		local instance3 = p1.State("clicked")
		p1.SameLine()
		p1.RadioButton({ "clicked", "clicked" }, {
			index = instance3
		})
		p1.RadioButton({ "rightClicked", "rightClicked" }, {
			index = instance3
		})
		p1.RadioButton({ "doubleClicked", "doubleClicked" }, {
			index = instance3
		})
		p1.RadioButton({ "ctrlClicked", "ctrlClicked" }, {
			index = instance3
		})
		p1.End()
		p1.SameLine()
		if p1.Button({ instance3:get() .. " to reveal text" })[instance3:get()]() then
			vector2:set(not vector2:get())
		end
		if vector2:get() then
			p1.Text({ "Here i am!" })
		end
		p1.End()
		p1.Separator()
		local var4 = p1.State(0)
		p1.SameLine()
		if p1.Button({ "Click to show text for 20 frames" }).clicked() then
			var4:set(20)
		end
		if var4:get() > 0 then
			p1.Text({ "Here i am!" })
		end
		p1.End()
		var4:set((math.max(0, var4:get() - 1)))
		p1.Text({ "Text Timer: " .. var4:get() })
		local func6 = p1.Checkbox({ "Event-tracked checkbox" })
		p1.Indent()
		local t = {}
		t[1] = "unchecked: " .. tostring(func6.unchecked())
		p1.Text(t)
		local t2 = {}
		t2[1] = "checked: " .. tostring(func6.checked())
		p1.Text(t2)
		p1.End()
		p1.SameLine()
		if p1.Button({ "Hover over me" }).hovered() then
			p1.Text({ "The button is hovered" })
		end
		p1.End()
		p1.End()
	end
	local function widgetStateInteractivity()
		p1.CollapsingHeader({ "Widget State Interactivity" })
		p1.Text({ (("isChecked: %*\n"):format(p1.Checkbox({ "Widget-Generated State" }).state.isChecked.value)) })
		p1.Text({ (("isChecked: %*\n"):format(p1.Checkbox({ "User-Generated State" }, {
				isChecked = p1.State(false)
			}).state.isChecked.value)) })
		p1.Text({ (("isChecked: %*\n"):format(p1.Checkbox({ "Coupled to above Checkbox" }, {
				isChecked = p1.Checkbox({ "Widget Coupled State" }).state.isChecked
			}).state.isChecked.value)) })
		local func6 = p1.State(false)
		p1.Checkbox({ "Widget and Code Coupled State" }, {
			isChecked = func6
		})
		if p1.Button({ "Click to toggle above checkbox" }).clicked() then
			func6:set(not func6:get())
		end
		p1.Text({ (("isChecked: %*\n"):format(func6.value)) })
		local var7 = p1.State(true)
		local var8 = p1.ComputedState(var7, function(p1)
			return not p1
		end)
		p1.Checkbox({ "ComputedState (dynamic coupling)" }, {
			isChecked = var7
		})
		p1.Checkbox({ "Inverted of above checkbox" }, {
			isChecked = var8
		})
		p1.Text({ (("isChecked: %*\n"):format(var8.value)) })
		p1.End()
	end
	local function dynamicStyle()
		p1.CollapsingHeader({ "Dynamic Styles" })
		local instance = p1.State(0)
		p1.SameLine()
		if p1.Button({ "Change Color" }).clicked() then
			instance:set(math.random())
		end
		local t = {}
		t[1] = "Hue: " .. math.floor(instance:get() * 255)
		p1.Text(t)
		helpMarker("Using PushConfig with a changing value, this can be done with any config field")
		p1.End()
		p1.PushConfig({
			TextColor = Color3.fromHSV(instance:get(), 1, 1)
		})
		p1.Text({ "Text with a unique and changable color" })
		p1.PopConfig()
		p1.End()
	end
	local function tablesDemo()
		local instance = p1.State(false)
		p1.CollapsingHeader({ "Tables & Columns" }, {
			isUncollapsed = instance
		})
		if instance.value ~= false then
			p1.Tree({ "Basic" })
			p1.SameLine()
			p1.Text({ "Table using NextColumn syntax:" })
			helpMarker("calling Iris.NextColumn() in the inner loop,\nwhich automatically goes to the next row at the end.")
			p1.End()
			p1.Table({ 3 })
			for i = 1, 4 do
				for j = 1, 3 do
					p1.Text({ (("Row: %*, Column: %*"):format(i, j)) })
					p1.NextColumn()
				end
			end
			p1.End()
			p1.Text({ "" })
			p1.SameLine()
			p1.Text({ "Table using NextColumn and NextRow syntax:" })
			helpMarker("Calling Iris.NextColumn() in the inner loop and Iris.NextRow() in the outer loop,\nto acehieve a visually identical result. Technically they are not the same.")
			p1.End()
			p1.Table({ 3 })
			for k = 1, 4 do
				for n = 1, 3 do
					p1.Text({ (("Row: %*, Column: %*"):format(k, n)) })
					p1.NextColumn()
				end
				p1.NextRow()
			end
			p1.End()
			p1.End()
			p1.Tree({ "Headers, borders and backgrounds" })
			local vector2 = p1.State(0)
			local instance3 = p1.State(false)
			local var4 = p1.State(false)
			local var5 = p1.State(true)
			local func6 = p1.State(true)
			p1.Checkbox({ "Table header row" }, {
				isChecked = instance3
			})
			p1.Checkbox({ "Table row backgrounds" }, {
				isChecked = var4
			})
			p1.Checkbox({ "Table outer border" }, {
				isChecked = var5
			})
			p1.Checkbox({ "Table inner borders" }, {
				isChecked = func6
			})
			p1.SameLine()
			p1.Text({ "Cell contents" })
			p1.RadioButton({ "Text", 0 }, {
				index = vector2
			})
			p1.RadioButton({ "Fill button", 1 }, {
				index = vector2
			})
			p1.End()
			p1.Table({
				3,
				instance3.value,
				var4.value,
				var5.value,
				func6.value
			})
			p1.SetHeaderColumnIndex(1)
			for m = 0, 4 do
				for i = 1, 3 do
					if vector2.value == 0 then
						p1.Text({ (("Cell (%*, %*)"):format(i, m)) })
					else
						p1.Button({ ("Cell (%*, %*)"):format(i, m), UDim2.fromScale(1, 0) })
					end
					p1.NextColumn()
				end
			end
			p1.End()
			p1.End()
			p1.Tree({ "Sizing" })
			local var7 = p1.State(false)
			local var8 = p1.State(false)
			p1.Checkbox({ "Resizable" }, {
				isChecked = var7
			})
			p1.Checkbox({ "Limit Table Width" }, {
				isChecked = var8
			})
			p1.SeparatorText({ "stretch, equal" })
			p1.Table({
				3,
				false,
				true,
				true,
				true,
				var7.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					p1.Text({ "stretch" })
					p1.NextColumn()
				end
			end
			p1.End()
			p1.Table({
				3,
				false,
				true,
				true,
				true,
				var7.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					p1.Text({ string.rep(string.char(i2 + 64), i2 * 4) })
					p1.NextColumn()
				end
			end
			p1.End()
			p1.SeparatorText({ "stretch, proportional" })
			p1.Table({
				3,
				false,
				true,
				true,
				true,
				var7.value,
				false,
				true
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					p1.Text({ "stretch" })
					p1.NextColumn()
				end
			end
			p1.End()
			p1.Table({
				3,
				false,
				true,
				true,
				true,
				var7.value,
				false,
				true
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					p1.Text({ string.rep(string.char(i2 + 64), i2 * 4) })
					p1.NextColumn()
				end
			end
			p1.End()
			p1.SeparatorText({ "fixed, equal" })
			p1.Table({
				3,
				false,
				true,
				true,
				true,
				var7.value,
				true,
				false,
				var8.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					p1.Text({ "fixed" })
					p1.NextColumn()
				end
			end
			p1.End()
			p1.Table({
				3,
				false,
				true,
				true,
				true,
				var7.value,
				true,
				false,
				var8.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					p1.Text({ string.rep(string.char(i2 + 64), i2 * 4) })
					p1.NextColumn()
				end
			end
			p1.End()
			p1.SeparatorText({ "fixed, proportional" })
			p1.Table({
				3,
				false,
				true,
				true,
				true,
				var7.value,
				true,
				true,
				var8.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					p1.Text({ "fixed" })
					p1.NextColumn()
				end
			end
			p1.End()
			p1.Table({
				3,
				false,
				true,
				true,
				true,
				var7.value,
				true,
				true,
				var8.value
			})
			for i = 1, 3 do
				for i2 = 1, 3 do
					p1.Text({ string.rep(string.char(i2 + 64), i2 * 4) })
					p1.NextColumn()
				end
			end
			p1.End()
			p1.End()
			p1.Tree({ "Resizable" })
			local var9 = p1.State(4)
			local var10 = p1.State(3)
			local var11 = p1.State(false)
			local color12 = p1.State(true)
			local var13 = p1.State(true)
			local var14 = p1.State(true)
			local var15 = p1.State(true)
			local var16 = p1.State(false)
			local var17 = p1.State(false)
			local var18 = p1.State(false)
			local var19 = p1.State(false)
			local var20 = p1.State(false)
			local table21 = p1.State(table.create(10, 100))
			p1.SliderNum({ "Num Columns", 1, 1, 10 }, {
				number = var9
			})
			p1.SliderNum({ "Number of rows", 1, 0, 100 }, {
				number = var10
			})
			p1.SameLine()
			p1.RadioButton({ "Buttons", true }, {
				index = var11
			})
			p1.RadioButton({ "Text", false }, {
				index = var11
			})
			p1.End()
			p1.Table({ 3 })
			p1.Checkbox({ "Show Header Row" }, {
				isChecked = color12
			})
			p1.NextColumn()
			p1.Checkbox({ "Show Row Backgrounds" }, {
				isChecked = var13
			})
			p1.NextColumn()
			p1.Checkbox({ "Show Outer Border" }, {
				isChecked = var14
			})
			p1.NextColumn()
			p1.Checkbox({ "Show Inner Border" }, {
				isChecked = var15
			})
			p1.NextColumn()
			p1.Checkbox({ "Resizable" }, {
				isChecked = var16
			})
			p1.NextColumn()
			p1.Checkbox({ "Fixed Width" }, {
				isChecked = var17
			})
			p1.NextColumn()
			p1.Checkbox({ "Proportional Width" }, {
				isChecked = var18
			})
			p1.NextColumn()
			p1.Checkbox({ "Limit Table Width" }, {
				isChecked = var19
			})
			p1.NextColumn()
			p1.Checkbox({ "Add extra" }, {
				isChecked = var20
			})
			p1.NextColumn()
			p1.End()
			for i = 1, var9.value do
				local var22, v23, v24
				var22 = if var17.value == true then 1 else 0.05
				v23 = if var17.value == true then 2 else 0.05
				v24 = if var17.value == true then 480 else 1
				p1.SliderNum({
					("Column %* Width"):format(i),
					var22,
					v23,
					v24
				}, {
					number = p1.TableState(table21.value, i, function(p1)
						table21.value[i] = p1
						table21:set(table21.value, true)
						return false
					end)
				})
			end
			p1.PushConfig({
				NumColumns = var9.value
			})
			p1.Table({
				var9.value,
				color12.value,
				var13.value,
				var14.value,
				var15.value,
				var16.value,
				var17.value,
				var18.value,
				var19.value
			}, {
				widths = table21
			})
			p1.SetHeaderColumnIndex(1)
			for i = 0, var10:get() do
				for i2 = 1, var9.value do
					if i == 0 then
						if var11.value then
							p1.Button({ (("H: %*"):format(i2)) })
						else
							p1.Text({ (("H: %*"):format(i2)) })
						end
					elseif var11.value then
						p1.Button({ (("R: %*, C: %*"):format(i, i2)) })
						p1.Button({ string.rep("...", i2) })
					else
						p1.Text({ (("R: %*, C: %*"):format(i, i2)) })
						p1.Text({ string.rep("...", i2) })
					end
					p1.NextColumn()
				end
			end
			if var20.value then
				p1.Text({ "A really long piece of text!" })
			end
			p1.End()
			p1.PopConfig()
			p1.End()
		end
		p1.End()
	end
	local function layoutDemo()
		p1.CollapsingHeader({ "Widget Layout" })
		p1.Tree({ "Widget Alignment" })
		p1.Text({ "Iris.SameLine has optional argument supporting horizontal and vertical alignments." })
		p1.Text({ "This allows widgets to be place anywhere on the line." })
		p1.Separator()
		p1.SameLine()
		p1.Text({ "By default child widgets will be aligned to the left." })
		helpMarker("Iris.SameLine()\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		p1.End()
		p1.SameLine()
		p1.Button({ "Button A" })
		p1.Button({ "Button B" })
		p1.End()
		p1.SameLine()
		p1.Text({ "But can be aligned to the center." })
		helpMarker("Iris.SameLine({ nil, nil, Enum.HorizontalAlignment.Center })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		p1.End()
		p1.SameLine({ nil, nil, Enum.HorizontalAlignment.Center })
		p1.Button({ "Button A" })
		p1.Button({ "Button B" })
		p1.End()
		p1.SameLine()
		p1.Text({ "Or right." })
		helpMarker("Iris.SameLine({ nil, nil, Enum.HorizontalAlignment.Right })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		p1.End()
		p1.SameLine({ nil, nil, Enum.HorizontalAlignment.Right })
		p1.Button({ "Button A" })
		p1.Button({ "Button B" })
		p1.End()
		p1.Separator()
		p1.SameLine()
		p1.Text({ "You can also specify the padding." })
		helpMarker("Iris.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })\n\tIris.Button({ \"Button A\" })\n\tIris.Button({ \"Button B\" })\nIris.End()")
		p1.End()
		p1.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })
		p1.Button({ "Button A" })
		p1.Button({ "Button B" })
		p1.End()
		p1.End()
		p1.Tree({ "Widget Sizing" })
		p1.Text({ "Nearly all widgets are the minimum size of the content." })
		p1.Text({ "For example, text and button widgets will be the size of the text labels." })
		p1.Text({ "Some widgets, such as the Image and Button have Size arguments will will set the size of them." })
		p1.Separator()
		p1.SameLine()
		p1.Text({ "The button takes up the full screen-width." })
		helpMarker("Iris.Button({ \"Button\", UDim2.fromScale(1, 0) })")
		p1.End()
		p1.Button({ "Button", UDim2.fromScale(1, 0) })
		p1.SameLine()
		p1.Text({ "The button takes up half the screen-width." })
		helpMarker("Iris.Button({ \"Button\", UDim2.fromScale(0.5, 0) })")
		p1.End()
		p1.Button({ "Button", UDim2.fromScale(0.5, 0) })
		p1.SameLine()
		p1.Text({ "Combining with SameLine, the buttons can fill the screen width." })
		helpMarker("The button will still be larger that the text size.")
		p1.End()
		local instance = p1.State(2)
		p1.SliderNum({ "Number of Buttons", 1, 1, 8 }, {
			number = instance
		})
		p1.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })
		for i = 1, instance.value do
			p1.Button({ ("Button %*"):format(i), UDim2.fromScale(1 / instance.value, 0) })
		end
		p1.End()
		p1.End()
		p1.Tree({ "Content Width" })
		local vector2 = p1.State(50)
		local instance3 = p1.State(Enum.Axis.X)
		p1.Text({ "The Content Width is a size property which determines the width of input fields." })
		p1.SameLine()
		p1.Text({ "By default the value is UDim.new(0.65, 0)" })
		helpMarker("This is the default value from Dear ImGui.\nIt is 65% of the window width.")
		p1.End()
		p1.Text({ "This works well, but sometimes we know how wide elements are going to be and want to maximise the space." })
		p1.Text({ "Therefore, we can use Iris.PushConfig() to change the width" })
		p1.Separator()
		p1.SameLine()
		p1.Text({ "Content Width = 150 pixels" })
		helpMarker("UDim.new(0, 150)")
		p1.End()
		p1.PushConfig({
			ContentWidth = UDim.new(0, 150)
		})
		p1.DragNum({ "number", 1, 0, 100 }, {
			number = vector2
		})
		p1.InputEnum({ "axis" }, {
			index = instance3
		}, Enum.Axis)
		p1.PopConfig()
		p1.SameLine()
		p1.Text({ "Content Width = 50% window width" })
		helpMarker("UDim.new(0.5, 0)")
		p1.End()
		p1.PushConfig({
			ContentWidth = UDim.new(0.5, 0)
		})
		p1.DragNum({ "number", 1, 0, 100 }, {
			number = vector2
		})
		p1.InputEnum({ "axis" }, {
			index = instance3
		}, Enum.Axis)
		p1.PopConfig()
		p1.SameLine()
		p1.Text({ "Content Width = -150 pixels from the right side" })
		helpMarker("UDim.new(1, -150)")
		p1.End()
		p1.PushConfig({
			ContentWidth = UDim.new(1, -150)
		})
		p1.DragNum({ "number", 1, 0, 100 }, {
			number = vector2
		})
		p1.InputEnum({ "axis" }, {
			index = instance3
		}, Enum.Axis)
		p1.PopConfig()
		p1.End()
		p1.Tree({ "Content Height" })
		local var4 = p1.State("a single line")
		local var5 = p1.State(50)
		local func6 = p1.State(Enum.Axis.X)
		local var7 = p1.State(0)
		var7:set(math.clamp(math.abs(os.clock() * 15 % 100 - 50) - 7.5, 0, 35) / 35)
		p1.Text({ "The Content Height is a size property that determines the minimum size of certain widgets." })
		p1.Text({ "By default the value is UDim.new(0, 0), so there is no minimum height." })
		p1.Text({ "We use Iris.PushConfig() to change this value." })
		p1.Separator()
		p1.SameLine()
		p1.Text({ "Content Height = 0 pixels" })
		helpMarker("UDim.new(0, 0)")
		p1.End()
		p1.InputText({ "text" }, {
			text = var4
		})
		p1.ProgressBar({ "progress" }, {
			progress = var7
		})
		p1.DragNum({ "number", 1, 0, 100 }, {
			number = var5
		})
		p1.ComboEnum({ "axis" }, {
			index = func6
		}, Enum.Axis)
		p1.SameLine()
		p1.Text({ "Content Height = 60 pixels" })
		helpMarker("UDim.new(0, 60)")
		p1.End()
		p1.PushConfig({
			ContentHeight = UDim.new(0, 60)
		})
		p1.InputText({ "text", nil, nil, true }, {
			text = var4
		})
		p1.ProgressBar({ "progress" }, {
			progress = var7
		})
		p1.DragNum({ "number", 1, 0, 100 }, {
			number = var5
		})
		p1.ComboEnum({ "axis" }, {
			index = func6
		}, Enum.Axis)
		p1.PopConfig()
		p1.Text({ "This property can be used to force the height of a text box." })
		p1.Text({ "Just make sure you enable the MultiLine argument." })
		p1.End()
		p1.End()
	end
	local function windowlessDemo()
		p1.PushConfig({
			ItemWidth = UDim.new(0, 150)
		})
		p1.SameLine()
		p1.TextWrapped({ "Windowless widgets" })
		helpMarker("Widgets which are placed outside of a window will appear on the top left side of the screen.")
		p1.End()
		p1.Button({})
		p1.Tree({})
		p1.InputText({})
		p1.End()
		p1.PopConfig()
	end
	return function()
		local var13 = p1.State(false)
		local var22 = p1.State(false)
		local var32 = p1.State(false)
		local var42 = p1.State(true)
		local var52 = p1.State(false)
		local var62 = p1.State(false)
		local var72 = p1.State(false)
		local var82 = p1.State(false)
		local var92 = p1.State(false)
		if instance.value ~= false then
			debug.profilebegin("Iris/Demo/Window")
			local var102 = p1.Window({
				[p1.Args.Window.Title] = "Iris Demo Window",
				[p1.Args.Window.NoTitleBar] = var13.value,
				[p1.Args.Window.NoBackground] = var22.value,
				[p1.Args.Window.NoCollapse] = var32.value,
				[p1.Args.Window.NoClose] = var42.value,
				[p1.Args.Window.NoMove] = var52.value,
				[p1.Args.Window.NoScrollbar] = var62.value,
				[p1.Args.Window.NoResize] = var72.value,
				[p1.Args.Window.NoNav] = var82.value,
				[p1.Args.Window.NoMenu] = var92.value
			}, {
				size = p1.State(Vector2.new(600, 550)),
				position = p1.State(Vector2.new(100, 25)),
				isOpened = instance
			})
			if var102.state.isUncollapsed.value and var102.state.isOpened.value then
				debug.profilebegin("Iris/Demo/MenuBar")
				mainMenuBar()
				debug.profileend()
				p1.Text({ "Iris says hello. (" .. p1.Internal._version .. ")" })
				debug.profilebegin("Iris/Demo/Options")
				p1.CollapsingHeader({ "Window Options" })
				p1.Table({ 3, false, false, false })
				p1.Checkbox({ "NoTitleBar" }, {
					isChecked = var13
				})
				p1.NextColumn()
				p1.Checkbox({ "NoBackground" }, {
					isChecked = var22
				})
				p1.NextColumn()
				p1.Checkbox({ "NoCollapse" }, {
					isChecked = var32
				})
				p1.NextColumn()
				p1.Checkbox({ "NoClose" }, {
					isChecked = var42
				})
				p1.NextColumn()
				p1.Checkbox({ "NoMove" }, {
					isChecked = var52
				})
				p1.NextColumn()
				p1.Checkbox({ "NoScrollbar" }, {
					isChecked = var62
				})
				p1.NextColumn()
				p1.Checkbox({ "NoResize" }, {
					isChecked = var72
				})
				p1.NextColumn()
				p1.Checkbox({ "NoNav" }, {
					isChecked = var82
				})
				p1.NextColumn()
				p1.Checkbox({ "NoMenu" }, {
					isChecked = var92
				})
				p1.NextColumn()
				p1.End()
				p1.End()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Events")
				widgetEventInteractivity()
				debug.profileend()
				debug.profilebegin("Iris/Demo/States")
				widgetStateInteractivity()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Recursive")
				p1.CollapsingHeader({ "Recursive Tree" })
				if p1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
					var11()
				end
				p1.End()
				p1.End()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Style")
				dynamicStyle()
				debug.profileend()
				p1.Separator()
				debug.profilebegin("Iris/Demo/Widgets")
				p1.CollapsingHeader({ "Widgets" })
				for v112, v122 in t2 do
					debug.profilebegin((("Iris/Demo/Widgets/%*"):format(v122)))
					t[v122]()
					debug.profileend()
				end
				p1.End()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Tables")
				tablesDemo()
				debug.profileend()
				debug.profilebegin("Iris/Demo/Layout")
				layoutDemo()
				debug.profileend()
				p1.CollapsingHeader({ "Background" })
				p1.Checkbox({ "Show background colour" }, {
					isChecked = var8
				})
				p1.InputColor4({ "Background colour" }, {
					color = var9,
					transparency = var10
				})
				p1.End()
			end
			p1.End()
			debug.profileend()
			if vector2.value then
				color12(vector2)
			end
			if instance3.value then
				runtimeInfo()
			end
			if var7.value then
				debugPanel()
			end
			if var4.value then
				f14()
			end
			if var5.value then
				windowlessDemo()
			end
			if func6.value then
				mainMenuBar()
			end
			return var102
		end
		p1.Checkbox({ "Open main window" }, {
			isChecked = instance
		})
	end
end
