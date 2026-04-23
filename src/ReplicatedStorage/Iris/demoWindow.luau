require(script.Parent.Types)
return function(p1) --[[ Line: 3 ]]
	local v1 = p1.State(true)
	local v2 = p1.State(false)
	local v3 = p1.State(false)
	local v4 = p1.State(false)
	local v5 = p1.State(false)
	local v6 = p1.State(false)
	local v7 = p1.State(false)
	local v8 = p1.State(false)
	local v9 = p1.State(Color3.fromRGB(115, 140, 152))
	local v10 = p1.State(0)
	table.insert(p1.Internal._initFunctions, function() --[[ Line: 15 | Upvalues: v9 (copy), v10 (copy), p1 (copy), v8 (copy) ]]
		local Background = Instance.new("Frame")
		Background.Name = "Background"
		Background.Size = UDim2.fromScale(1, 1)
		Background.BackgroundColor3 = v9.value
		Background.BackgroundTransparency = v10.value
		local Iris_Background
		if p1._config.UseScreenGUIs then
			Iris_Background = Instance.new("ScreenGui")
			Iris_Background.Name = "Iris_Background"
			Iris_Background.IgnoreGuiInset = true
			Iris_Background.DisplayOrder = p1._config.DisplayOrderOffset - 1
			Iris_Background.ScreenInsets = Enum.ScreenInsets.None
			Iris_Background.Enabled = true
			Background.Parent = Iris_Background
		else
			Background.ZIndex = p1._config.DisplayOrderOffset - 1
			Iris_Background = Background
		end
		v9:onChange(function(p1) --[[ Line: 37 | Upvalues: Background (copy) ]]
			Background.BackgroundColor3 = p1
		end)
		v10:onChange(function(p1) --[[ Line: 40 | Upvalues: Background (copy) ]]
			Background.BackgroundTransparency = p1
		end)
		v8:onChange(function(p12) --[[ Line: 44 | Upvalues: Iris_Background (ref), p1 (ref) ]]
			if p12 then
				Iris_Background.Parent = p1.Internal.parentInstance
			else
				Iris_Background.Parent = nil
			end
		end)
	end)
	local function helpMarker(p12) --[[ Line: 53 | Upvalues: p1 (copy) ]]
		p1.PushConfig({
			TextColor = p1._config.TextDisabledColor
		})
		local v1 = p1.Text({ "(?)" })
		p1.PopConfig()
		p1.PushConfig({
			ContentWidth = UDim.new(0, 350)
		})
		if v1.hovered() then
			p1.Tooltip({ p12 })
		end
		p1.PopConfig()
	end
	local function textAndHelpMarker(p12, p2) --[[ Line: 65 | Upvalues: p1 (copy), helpMarker (copy) ]]
		p1.SameLine()
		p1.Text({ p12 })
		helpMarker(p2)
		p1.End()
	end
	local t = {
		Basic = function() --[[ Name: Basic | Line: 76 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Basic" })
			p1.SeparatorText({ "Basic" })
			local v1 = p1.State(1)
			p1.Button({ "Button" })
			p1.SmallButton({ "SmallButton" })
			p1.Text({ "Text" })
			p1.TextWrapped({ string.rep("Text Wrapped ", 5) })
			p1.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) })
			p1.Text({ "Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>", true, nil, true })
			p1.SameLine()
			p1.RadioButton({ "Index \'1\'", 1 }, {
				index = v1
			})
			p1.RadioButton({ "Index \'two\'", "two" }, {
				index = v1
			})
			if p1.RadioButton({ "Index \'false\'", false }, {
				index = v1
			}).active() == false and p1.SmallButton({ "Select last" }).clicked() then
				v1:set(false)
			end
			p1.End()
			local t = {}
			t[1] = "The Index is: " .. tostring(v1.value)
			p1.Text(t)
			p1.SeparatorText({ "Inputs" })
			p1.InputNum({})
			p1.DragNum({})
			p1.SliderNum({})
			p1.End()
		end,
		Image = function() --[[ Name: Image | Line: 112 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Image" })
			p1.SeparatorText({ "Image Controls" })
			local v1 = p1.State("rbxasset://textures/ui/common/robux.png")
			local v2 = p1.State(UDim2.fromOffset(100, 100))
			local v3 = p1.State(Rect.new(0, 0, 0, 0))
			local v4 = p1.State(Enum.ScaleType.Stretch)
			local v5 = p1.State(false)
			local v6 = p1.ComputedState(v5, function(p1) --[[ Line: 122 ]]
				return p1 and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default
			end)
			local v7 = p1.State(p1._config.ImageColor)
			local v8 = p1.State(p1._config.ImageTransparency)
			p1.InputColor4({ "Image Tint" }, {
				color = v7,
				transparency = v8
			})
			p1.Combo({ "Asset" }, {
				index = v1
			})
			p1.Selectable({ "Robux Small", "rbxasset://textures/ui/common/robux.png" }, {
				index = v1
			})
			p1.Selectable({ "Robux Large", "rbxasset://textures//ui/common/robux@3x.png" }, {
				index = v1
			})
			p1.Selectable({ "Loading Texture", "rbxasset://textures//loading/darkLoadingTexture.png" }, {
				index = v1
			})
			p1.Selectable({ "Hue-Saturation Gradient", "rbxasset://textures//TagEditor/huesatgradient.png" }, {
				index = v1
			})
			p1.Selectable({ "famfamfam.png (WHY?)", "rbxasset://textures//TagEditor/famfamfam.png" }, {
				index = v1
			})
			p1.End()
			p1.SliderUDim2({
				"Image Size",
				nil,
				nil,
				UDim2.new(1, 240, 1, 240)
			}, {
				number = v2
			})
			p1.SliderRect({
				"Image Rect",
				nil,
				nil,
				Rect.new(256, 256, 256, 256)
			}, {
				number = v3
			})
			p1.Combo({ "Scale Type" }, {
				index = v4
			})
			p1.Selectable({ "Stretch", Enum.ScaleType.Stretch }, {
				index = v4
			})
			p1.Selectable({ "Fit", Enum.ScaleType.Fit }, {
				index = v4
			})
			p1.Selectable({ "Crop", Enum.ScaleType.Crop }, {
				index = v4
			})
			p1.End()
			p1.Checkbox({ "Pixelated" }, {
				isChecked = v5
			})
			p1.PushConfig({
				ImageColor = v7:get(),
				ImageTransparency = v8:get()
			})
			p1.Image({
				v1:get(),
				v2:get(),
				v3:get(),
				v4:get(),
				v6:get()
			})
			p1.PopConfig()
			p1.SeparatorText({ "Tile" })
			local v9 = p1.State(UDim2.fromScale(0.5, 0.5))
			p1.SliderUDim2({
				"Tile Size",
				nil,
				nil,
				UDim2.new(1, 240, 1, 240)
			}, {
				number = v9
			})
			p1.PushConfig({
				ImageColor = v7:get(),
				ImageTransparency = v8:get()
			})
			p1.Image({
				"rbxasset://textures/grid2.png",
				v2:get(),
				nil,
				Enum.ScaleType.Tile,
				v6:get(),
				v9:get()
			})
			p1.PopConfig()
			p1.SeparatorText({ "Slice" })
			local v10 = p1.State(1)
			p1.SliderNum({ "Image Slice Scale", 0.1, 0.1, 5 }, {
				number = v10
			})
			p1.PushConfig({
				ImageColor = v7:get(),
				ImageTransparency = v8:get()
			})
			p1.Image({
				"rbxasset://textures/ui/chatBubble_blue_notify_bkg.png",
				v2:get(),
				nil,
				Enum.ScaleType.Slice,
				v6:get(),
				nil,
				Rect.new(12, 12, 56, 56),
				1
			}, v10:get())
			p1.PopConfig()
			p1.SeparatorText({ "Image Button" })
			local v11 = p1.State(0)
			p1.SameLine()
			p1.PushConfig({
				ImageColor = v7:get(),
				ImageTransparency = v8:get()
			})
			if p1.ImageButton({ "rbxasset://textures/AvatarCompatibilityPreviewer/add.png", UDim2.fromOffset(20, 20) }).clicked() then
				v11:set(v11.value + 1)
			end
			p1.PopConfig()
			p1.Text({ (("Click count: %*"):format(v11.value)) })
			p1.End()
			p1.End()
		end,
		Selectable = function() --[[ Name: Selectable | Line: 203 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Selectable" })
			local v1 = p1.State(2)
			p1.Selectable({ "Selectable #1", 1 }, {
				index = v1
			})
			p1.Selectable({ "Selectable #2", 2 }, {
				index = v1
			})
			if p1.Selectable({ "Double click Selectable", 3, true }, {
				index = v1
			}).doubleClicked() then
				v1:set(3)
			end
			p1.Selectable({ "Impossible to select", 4, true }, {
				index = v1
			})
			if p1.Button({ "Select last" }).clicked() then
				v1:set(4)
			end
			p1.Selectable({ "Independent Selectable" })
			p1.End()
		end,
		Combo = function() --[[ Name: Combo | Line: 223 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Combo" })
			p1.PushConfig({
				ContentWidth = UDim.new(1, -200)
			})
			local v1 = p1.State("No Selection")
			p1.SameLine()
			local v2 = p1.Checkbox({ "No Preview" })
			local v3 = p1.Checkbox({ "No Button" })
			if v2.checked() and v3.isChecked.value == true then
				v3.isChecked:set(false)
			end
			local v4 = v3
			if v4.checked() and v2.isChecked.value == true then
				v2.isChecked:set(false)
			end
			p1.End()
			p1.Combo({ "Basic Usage", v4.isChecked:get(), v2.isChecked:get() }, {
				index = v1
			})
			p1.Selectable({ "Select 1", "One" }, {
				index = v1
			})
			p1.Selectable({ "Select 2", "Two" }, {
				index = v1
			})
			p1.Selectable({ "Select 3", "Three" }, {
				index = v1
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
			local v7 = p1.State("7 AM")
			p1.Combo({ "Combo with Inner widgets" }, {
				index = v7
			})
			p1.Tree({ "Morning Shifts" })
			p1.Selectable({ "Shift at 7 AM", "7 AM" }, {
				index = v7
			})
			p1.Selectable({ "Shift at 11 AM", "11 AM" }, {
				index = v7
			})
			p1.Selectable({ "Shift at 3 PM", "3 PM" }, {
				index = v7
			})
			p1.End()
			p1.Tree({ "Night Shifts" })
			p1.Selectable({ "Shift at 6 PM", "6 PM" }, {
				index = v7
			})
			p1.Selectable({ "Shift at 9 PM", "9 PM" }, {
				index = v7
			})
			p1.End()
			p1.End()
			p1.Text({ "Selected: " .. p1.ComboEnum({ "Using ComboEnum" }, {
					index = Enum.UserInputState.Begin
				}, Enum.UserInputState).index:get().Name })
			p1.PopConfig()
			p1.End()
		end,
		Tree = function() --[[ Name: Tree | Line: 286 | Upvalues: p1 (copy), helpMarker (copy) ]]
			p1.Tree({ "Trees" })
			p1.Tree({ "Tree using SpanAvailWidth", true })
			helpMarker("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area")
			p1.End()
			local v1 = p1.Tree({ "Tree with Children" })
			p1.Text({ "Im inside the first tree!" })
			p1.Button({ "Im a button inside the first tree!" })
			p1.Tree({ "Im a tree inside the first tree!" })
			p1.Text({ "I am the innermost text!" })
			p1.End()
			p1.End()
			p1.Checkbox({ "Toggle above tree" }, {
				isChecked = v1.state.isUncollapsed
			})
			p1.End()
		end,
		CollapsingHeader = function() --[[ Name: CollapsingHeader | Line: 312 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Collapsing Headers" })
			p1.CollapsingHeader({ "A header" })
			p1.Text({ "This is under the first header!" })
			p1.End()
			local v1 = p1.State(false)
			p1.CollapsingHeader({ "Another header" }, {
				isUncollapsed = v1
			})
			if p1.Button({ "Shhh... secret button!" }).clicked() then
				v1:set(true)
			end
			p1.End()
			p1.End()
		end,
		Group = function() --[[ Name: Group | Line: 333 | Upvalues: p1 (copy) ]]
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
		Tab = function() --[[ Name: Tab | Line: 360 | Upvalues: p1 (copy) ]]
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
			local v1 = p1.State(true)
			local v2 = p1.State(true)
			local v3 = p1.State(true)
			p1.TabBar()
			p1.Tab({ "\240\159\141\142", true }, {
				isOpened = v1
			})
			p1.Text({ "Who loves apples?" })
			if p1.Button({ "I don\'t like apples." }).clicked() then
				v1:set(false)
			end
			p1.End()
			p1.Tab({ "\240\159\165\166", true }, {
				isOpened = v2
			})
			p1.Text({ "And what about broccoli?" })
			if p1.Button({ "Not for me." }).clicked() then
				v2:set(false)
			end
			p1.End()
			p1.Tab({ "\240\159\165\149", true }, {
				isOpened = v3
			})
			p1.Text({ "But carrots are the best." })
			if p1.Button({ "I disagree with you." }).clicked() then
				v3:set(false)
			end
			p1.End()
			p1.End()
			p1.Separator()
			if p1.Button({ "Actually, let me reconsider it." }).clicked() then
				v1:set(true)
				v2:set(true)
				v3:set(true)
			end
			p1.End()
			p1.End()
		end,
		Indent = function() --[[ Name: Indent | Line: 435 | Upvalues: p1 (copy) ]]
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
		Input = function() --[[ Name: Input | Line: 457 | Upvalues: p1 (copy), helpMarker (copy) ]]
			p1.Tree({ "Input" })
			local v1 = p1.State(false)
			local v2 = p1.State(false)
			local v3 = p1.State(0)
			local v4 = p1.State(100)
			local v5 = p1.State(1)
			local v6 = p1.State("%d")
			p1.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			local v7 = p1.InputNum({
				[p1.Args.InputNum.Text] = "Input Number",
				[p1.Args.InputNum.NoButtons] = v2.value,
				[p1.Args.InputNum.Min] = v3.value,
				[p1.Args.InputNum.Max] = v4.value,
				[p1.Args.InputNum.Increment] = v5.value,
				[p1.Args.InputNum.Format] = { v6.value }
			})
			p1.PopConfig()
			p1.Text({ "The Value is: " .. v7.number.value })
			if p1.Button({ "Randomize Number" }).clicked() then
				v7.number:set(math.random(1, 99))
			end
			local v8 = p1.Checkbox({ "NoField" }, {
				isChecked = v1
			})
			local v9 = p1.Checkbox({ "NoButtons" }, {
				isChecked = v2
			})
			if v8.checked() and v9.isChecked.value == true then
				v9.isChecked:set(false)
			end
			if v9.checked() and v8.isChecked.value == true then
				v8.isChecked:set(false)
			end
			p1.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			p1.InputVector2({ "InputVector2" })
			p1.InputVector3({ "InputVector3" })
			p1.InputUDim({ "InputUDim" })
			p1.InputUDim2({ "InputUDim2" })
			local v10 = p1.State(false)
			local v11 = p1.State(false)
			local v12 = p1.State(Color3.new())
			local v13 = p1.State(0)
			p1.SliderNum({ "Transparency", 0.01, 0, 1 }, {
				number = v13
			})
			p1.InputColor3({ "InputColor3", v10:get(), v11:get() }, {
				color = v12
			})
			p1.InputColor4({ "InputColor4", v10:get(), v11:get() }, {
				color = v12,
				transparency = v13
			})
			p1.SameLine()
			p1.Text({ (("#%*"):format((v12:get():ToHex()))) })
			p1.Checkbox({ "Use Floats" }, {
				isChecked = v10
			})
			p1.Checkbox({ "Use HSV" }, {
				isChecked = v11
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
		InputText = function() --[[ Name: InputText | Line: 540 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Input Text" })
			p1.Text({ "The text is: " .. p1.InputText({ "Input Text Test", "Input Text here" }).text.value })
			p1.End()
		end,
		MultiInput = function() --[[ Name: MultiInput | Line: 549 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Multi-Component Input" })
			local v1 = p1.State(Vector2.new())
			local v2 = p1.State((Vector3.new()))
			local v3 = p1.State(UDim.new())
			local v4 = p1.State(UDim2.new())
			local v5 = p1.State(Color3.new())
			local v6 = p1.State(Rect.new(0, 0, 0, 0))
			p1.SeparatorText({ "Input" })
			p1.InputVector2({}, {
				number = v1
			})
			p1.InputVector3({}, {
				number = v2
			})
			p1.InputUDim({}, {
				number = v3
			})
			p1.InputUDim2({}, {
				number = v4
			})
			p1.InputRect({}, {
				number = v6
			})
			p1.SeparatorText({ "Drag" })
			p1.DragVector2({}, {
				number = v1
			})
			p1.DragVector3({}, {
				number = v2
			})
			p1.DragUDim({}, {
				number = v3
			})
			p1.DragUDim2({}, {
				number = v4
			})
			p1.DragRect({}, {
				number = v6
			})
			p1.SeparatorText({ "Slider" })
			p1.SliderVector2({}, {
				number = v1
			})
			p1.SliderVector3({}, {
				number = v2
			})
			p1.SliderUDim({}, {
				number = v3
			})
			p1.SliderUDim2({}, {
				number = v4
			})
			p1.SliderRect({}, {
				number = v6
			})
			p1.SeparatorText({ "Color" })
			p1.InputColor3({}, {
				color = v5
			})
			p1.InputColor4({}, {
				color = v5
			})
			p1.End()
		end,
		Tooltip = function() --[[ Name: Tooltip | Line: 591 | Upvalues: p1 (copy) ]]
			p1.PushConfig({
				ContentWidth = UDim.new(0, 250)
			})
			p1.Tree({ "Tooltip" })
			if p1.Text({ "Hover over me to reveal a tooltip" }).hovered() then
				p1.Tooltip({ "I am some helpful tooltip text" })
			end
			local v1 = p1.State("Hello ")
			local v2 = p1.State(1)
			if p1.InputNum({ "# of repeat", 1, 1, 50 }, {
				number = v2
			}).numberChanged() then
				v1:set(string.rep("Hello ", v2:get()))
			end
			if p1.Checkbox({ "Show dynamic text tooltip" }).state.isChecked.value then
				p1.Tooltip({ v1:get() })
			end
			p1.End()
			p1.PopConfig()
		end,
		Plotting = function() --[[ Name: Plotting | Line: 611 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Plotting" })
			p1.SeparatorText({ "Progress" })
			local v1 = os.clock() * 15
			local v2 = p1.State(0)
			v2:set(math.clamp(math.abs(v1 % 100 - 50) - 7.5, 0, 35) / 35)
			p1.ProgressBar({ "Progress Bar" }, {
				progress = v2
			})
			local t = {}
			local v4 = v2:get() * 1753
			t[1] = "Progress Bar"
			t[2] = ("%*/1753"):format((math.floor(v4)))
			p1.ProgressBar(t, {
				progress = v2
			})
			p1.SeparatorText({ "Graphs" })
			local v5 = p1.State({
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
				values = v5
			})
			p1.PlotLines({ "Lines", 100, 0, 1, "random" }, {
				values = v5
			})
			local v6 = p1.State("Cos")
			local v7 = p1.State(37)
			local v8 = p1.State(0)
			local v9 = p1.State({})
			local v10 = p1.State(0)
			local v11 = p1.Checkbox({ "Animate" })
			local v12 = p1.ComboArray({ "Plotting Function" }, {
				index = v6
			}, { "Sin", "Cos", "Tan", "Saw" })
			local v13 = p1.SliderNum({ "Samples", 1, 1, 145, "%d samples" }, {
				number = v7
			})
			if p1.SliderNum({ "Baseline", 0.1, -1, 1 }, {
				number = v8
			}).numberChanged() then
				v9:set(v9.value, true)
			end
			if v11.state.isChecked.value or (v12.closed() or (v13.numberChanged() or #v9.value == 0)) then
				if v11.state.isChecked.value then
					v10:set(v10.value + p1.Internal._deltaTime)
				end
				local v15 = math.floor(v10.value * 30) - 1
				local value = v6.value
				table.clear(v9.value)
				for i = 1, v7.value do
					local v16
					if value == "Sin" then
						v9.value[i] = math.sin((math.rad((i + v15) * 5)))
					elseif value == "Cos" then
						v9.value[i] = math.cos((math.rad((i + v15) * 5)))
					elseif value == "Tan" then
						v9.value[i] = math.tan((math.rad((i + v15) * 5)))
					elseif value == "Saw" then
						v16 = if i % 2 == v15 % 2 then 1 else -1
						v9.value[i] = v16
					end
				end
				v9:set(v9.value, true)
			end
			p1.PlotHistogram({
				"Histogram",
				100,
				-1,
				1,
				"",
				v8:get()
			}, {
				values = v9
			})
			p1.PlotLines({ "Lines", 100, -1, 1 }, {
				values = v9
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
	local function v11() --[[ Line: 679 | Upvalues: p1 (copy), v11 (copy) ]]
		if p1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
			v11()
		end
		p1.End()
	end
	local function v12(p12) --[[ Line: 689 | Upvalues: p1 (copy), v12 (copy) ]]
		p1.Window({ "Recursive Window" }, {
			size = p1.State(Vector2.new(175, 100)),
			isOpened = p12
		})
		local v1 = p1.Checkbox({ "Recurse Again" })
		p1.End()
		if v1.isChecked.value then
			v12(v1.isChecked)
		end
	end
	local function runtimeInfo() --[[ Line: 703 | Upvalues: p1 (copy), v3 (copy), helpMarker (copy) ]]
		local v1 = p1.Window({ "Runtime Info" }, {
			isOpened = v3
		})
		local _lastVDOM = p1.Internal._lastVDOM
		local _states = p1.Internal._states
		local v2 = p1.State(3)
		local v32 = p1.State(0)
		local v4 = p1.State(os.clock())
		p1.SameLine()
		p1.InputNum({
			[p1.Args.InputNum.Text] = "",
			[p1.Args.InputNum.Format] = "%d Seconds",
			[p1.Args.InputNum.Max] = 10
		}, {
			number = v2
		})
		if p1.Button({ "Disable" }).clicked() then
			p1.Disabled = true
			task.delay(v2:get(), function() --[[ Line: 718 | Upvalues: p1 (ref) ]]
				p1.Disabled = false
			end)
		end
		p1.End()
		local v5 = os.clock()
		v32.value = v32.value + (v5 - v4.value - v32.value) * 0.2
		v4.value = v5
		p1.Text({ string.format("Average %.3f ms/frame (%.1f FPS)", v32.value * 1000, 1 / v32.value) })
		p1.Text({ string.format("Window Position: (%d, %d), Window Size: (%d, %d)", v1.position.value.X, v1.position.value.Y, v1.size.value.X, v1.size.value.Y) })
		p1.SameLine()
		p1.Text({ "Enter an ID to learn more about it." })
		helpMarker("every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs")
		p1.End()
		p1.PushConfig({
			ItemWidth = UDim.new(1, -150)
		})
		local value = p1.InputText({ "ID field" }, {
			text = p1.State(v1.ID)
		}).state.text.value
		p1.PopConfig()
		p1.Indent()
		local v7 = _lastVDOM[value]
		local v8 = _states[value]
		if v7 then
			p1.Table({ 1 })
			p1.Text({ string.format("The ID, \"%s\", is a widget", value) })
			p1.NextRow()
			p1.Text({ string.format("Widget is type: %s", v7.type) })
			p1.NextRow()
			p1.Tree({ "Widget has Args:" }, {
				isUncollapsed = p1.State(true)
			})
			for v9, v10 in v7.arguments do
				p1.Text({ v9 .. " - " .. tostring(v10) })
			end
			p1.End()
			p1.NextRow()
			if v7.state then
				p1.Tree({ "Widget has State:" }, {
					isUncollapsed = p1.State(true)
				})
				for v11, v12 in v7.state do
					local t = {}
					t[1] = v11 .. " - " .. tostring(v12.value)
					p1.Text(t)
				end
				p1.End()
			end
			p1.End()
		elseif v8 then
			p1.Table({ 1 })
			p1.Text({ string.format("The ID, \"%s\", is a state", value) })
			p1.NextRow()
			local t = {}
			t[1] = string.format("Value is type: %s, Value = %s", typeof(v8.value), (tostring(v8.value)))
			p1.Text(t)
			p1.NextRow()
			p1.Tree({ "state has connected widgets:" }, {
				isUncollapsed = p1.State(true)
			})
			for v14, v15 in v8.ConnectedWidgets do
				p1.Text({ v14 .. " - " .. v15.type })
			end
			p1.End()
			p1.NextRow()
			p1.Text({ string.format("state has: %d connected functions", #v8.ConnectedFunctions) })
			p1.End()
		else
			p1.Text({ string.format("The ID, \"%s\", is not a state or widget", value) })
		end
		p1.End()
		if p1.Tree({ "Widgets" }).state.isUncollapsed.value then
			local count = 0
			local v16 = ""
			for v17, v18 in _lastVDOM do
				v16 = v16 .. "\n" .. v18.ID .. " - " .. v18.type
				count = count + 1
			end
			p1.Text({ "Number of Widgets: " .. count })
			p1.Text({ v16 })
		end
		p1.End()
		if p1.Tree({ "States" }).state.isUncollapsed.value then
			local count = 0
			local v19 = ""
			for v20, v21 in _states do
				v19 = v19 .. "\n" .. v20 .. " - " .. tostring(v21.value)
				count = count + 1
			end
			p1.Text({ "Number of States: " .. count })
			p1.Text({ v19 })
		end
		p1.End()
		p1.End()
	end
	local function debugPanel() --[[ Line: 827 | Upvalues: p1 (copy), v7 (copy) ]]
		p1.Window({ "Debug Panel" }, {
			isOpened = v7
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
	local function v13() --[[ Line: 848 | Upvalues: p1 (copy), v13 (copy) ]]
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
			v13()
			p1.End()
		end
		p1.End()
	end
	local function mainMenuBar() --[[ Line: 869 | Upvalues: p1 (copy), v13 (copy), v1 (copy), v2 (copy), v5 (copy), v6 (copy), v3 (copy), v4 (copy), v7 (copy) ]]
		p1.MenuBar()
		p1.Menu({ "File" })
		p1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
		p1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
		p1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
		v13()
		if p1.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt }).clicked() then
			v1:set(false)
		end
		p1.End()
		p1.Menu({ "Examples" })
		p1.MenuToggle({ "Recursive Window" }, {
			isChecked = v2
		})
		p1.MenuToggle({ "Windowless" }, {
			isChecked = v5
		})
		p1.MenuToggle({ "Main Menu Bar" }, {
			isChecked = v6
		})
		p1.End()
		p1.Menu({ "Tools" })
		p1.MenuToggle({ "Runtime Info" }, {
			isChecked = v3
		})
		p1.MenuToggle({ "Style Editor" }, {
			isChecked = v4
		})
		p1.MenuToggle({ "Debug Panel" }, {
			isChecked = v7
		})
		p1.End()
		p1.End()
	end
	local function mainMenuBarExample() --[[ Line: 903 | Upvalues: mainMenuBar (copy) ]]
		mainMenuBar()
	end
	local function f14() --[[ Line: 918 | Upvalues: p1 (copy), helpMarker (copy), v4 (copy) ]]
		local list = {
			{ "Sizing", function() --[[ Line: 922 | Upvalues: p1 (ref), helpMarker (ref) ]]
					local v1 = p1.State({})
					p1.SameLine()
					if p1.Button({ "Update" }).clicked() then
						p1.UpdateGlobalConfig(v1.value)
						v1:set({})
					end
					helpMarker("Update the global config with these changes.")
					p1.End()
					local function SliderInput(p12, p2) --[[ Line: 936 | Upvalues: p1 (ref), v1 (copy) ]]
						local v12 = p1[p12](p2, {
							number = p1.WeakState(p1._config[p2[1]])
						})
						if v12.numberChanged() then
							v1.value[p2[1]] = v12.number:get()
						end
					end
					local function BooleanInput(p12) --[[ Line: 943 | Upvalues: p1 (ref), v1 (copy) ]]
						local v12 = p1.Checkbox(p12, {
							isChecked = p1.WeakState(p1._config[p12[1]])
						})
						if v12.checked() or v12.unchecked() then
							v1.value[p12[1]] = v12.isChecked:get()
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
					local v2 = p1.ComboEnum({ "WindowTitleAlign" }, {
						index = p1.WeakState(p1._config.WindowTitleAlign)
					}, Enum.LeftRight)
					if v2.closed() then
						v1.value.WindowTitleAlign = v2.index:get()
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
			{ "Colors", function() --[[ Line: 993 | Upvalues: p1 (ref), helpMarker (ref) ]]
					local v1 = p1.State({})
					p1.SameLine()
					if p1.Button({ "Update" }).clicked() then
						p1.UpdateGlobalConfig(v1.value)
						v1:set({})
					end
					helpMarker("Update the global config with these changes.")
					p1.End()
					for v2, v3 in {
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
						local v4 = p1.InputColor4({ v3 }, {
							color = p1.WeakState(p1._config[v3 .. "Color"]),
							transparency = p1.WeakState(p1._config[v3 .. "Transparency"])
						})
						if v4.numberChanged() then
							v1.value[v3 .. "Color"] = v4.color:get()
							v1.value[v3 .. "Transparency"] = v4.transparency:get()
						end
					end
				end },
			{ "Fonts", function() --[[ Line: 1056 | Upvalues: p1 (ref), helpMarker (ref) ]]
					local v1 = p1.State({})
					p1.SameLine()
					if p1.Button({ "Update" }).clicked() then
						p1.UpdateGlobalConfig(v1.value)
						v1:set({})
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
					local v2 = p1.SliderNum({ "Font Size", 1, 4, 20 }, {
						number = p1.WeakState(p1._config.TextSize)
					})
					if v2.numberChanged() then
						v1.value.TextSize = v2.state.number:get()
					end
					p1.SeparatorText({ "Properties" })
					local v3 = p1.WeakState(p1._config.TextFont.Family)
					local v4 = p1.ComboEnum({ "Font Weight" }, {
						index = p1.WeakState(p1._config.TextFont.Weight)
					}, Enum.FontWeight)
					local v5 = p1.ComboEnum({ "Font Style" }, {
						index = p1.WeakState(p1._config.TextFont.Style)
					}, Enum.FontStyle)
					p1.SeparatorText({ "Fonts" })
					for v6, v7 in t do
						local v8 = Font.new(v7.Family, v4.state.index.value, v5.state.index.value)
						p1.SameLine()
						p1.PushConfig({
							TextFont = v8
						})
						if p1.Selectable({ ("%* | \"The quick brown fox jumps over the lazy dog.\""):format(v6), v8.Family }, {
							index = v3
						}).selected() then
							v1.value.TextFont = v8
						end
						p1.PopConfig()
						p1.End()
					end
				end }
		}
		p1.Window({ "Style Editor" }, {
			isOpened = v4
		})
		p1.Text({ "Customize the look of Iris in realtime." })
		local v1 = p1.State("Dark Theme")
		if p1.ComboArray({ "Theme" }, {
			index = v1
		}, { "Dark Theme", "Light Theme" }).closed() then
			if v1.value == "Dark Theme" then
				p1.UpdateGlobalConfig(p1.TemplateConfig.colorDark)
			elseif v1.value == "Light Theme" then
				p1.UpdateGlobalConfig(p1.TemplateConfig.colorLight)
			end
		end
		local v2 = p1.State("Classic Size")
		if p1.ComboArray({ "Size" }, {
			index = v2
		}, { "Classic Size", "Larger Size" }).closed() then
			if v2.value == "Classic Size" then
				p1.UpdateGlobalConfig(p1.TemplateConfig.sizeDefault)
			elseif v2.value == "Larger Size" then
				p1.UpdateGlobalConfig(p1.TemplateConfig.sizeClear)
			end
		end
		p1.SameLine()
		if p1.Button({ "Revert" }).clicked() then
			p1.UpdateGlobalConfig(p1.TemplateConfig.colorDark)
			p1.UpdateGlobalConfig(p1.TemplateConfig.sizeDefault)
			v1:set("Dark Theme")
			v2:set("Classic Size")
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
	local function widgetEventInteractivity() --[[ Line: 1170 | Upvalues: p1 (copy) ]]
		p1.CollapsingHeader({ "Widget Event Interactivity" })
		local v1 = p1.State(0)
		if p1.Button({ "Click to increase Number" }).clicked() then
			v1:set(v1:get() + 1)
		end
		p1.Text({ "The Number is: " .. v1:get() })
		p1.Separator()
		local v2 = p1.State(false)
		local v3 = p1.State("clicked")
		p1.SameLine()
		p1.RadioButton({ "clicked", "clicked" }, {
			index = v3
		})
		p1.RadioButton({ "rightClicked", "rightClicked" }, {
			index = v3
		})
		p1.RadioButton({ "doubleClicked", "doubleClicked" }, {
			index = v3
		})
		p1.RadioButton({ "ctrlClicked", "ctrlClicked" }, {
			index = v3
		})
		p1.End()
		p1.SameLine()
		if p1.Button({ v3:get() .. " to reveal text" })[v3:get()]() then
			v2:set(not v2:get())
		end
		if v2:get() then
			p1.Text({ "Here i am!" })
		end
		p1.End()
		p1.Separator()
		local v4 = p1.State(0)
		p1.SameLine()
		if p1.Button({ "Click to show text for 20 frames" }).clicked() then
			v4:set(20)
		end
		if v4:get() > 0 then
			p1.Text({ "Here i am!" })
		end
		p1.End()
		v4:set((math.max(0, v4:get() - 1)))
		p1.Text({ "Text Timer: " .. v4:get() })
		local v6 = p1.Checkbox({ "Event-tracked checkbox" })
		p1.Indent()
		local t = {}
		t[1] = "unchecked: " .. tostring(v6.unchecked())
		p1.Text(t)
		local t2 = {}
		t2[1] = "checked: " .. tostring(v6.checked())
		p1.Text(t2)
		p1.End()
		p1.SameLine()
		if p1.Button({ "Hover over me" }).hovered() then
			p1.Text({ "The button is hovered" })
		end
		p1.End()
		p1.End()
	end
	local function widgetStateInteractivity() --[[ Line: 1241 | Upvalues: p1 (copy) ]]
		p1.CollapsingHeader({ "Widget State Interactivity" })
		p1.Text({ (("isChecked: %*\n"):format(p1.Checkbox({ "Widget-Generated State" }).state.isChecked.value)) })
		p1.Text({ (("isChecked: %*\n"):format(p1.Checkbox({ "User-Generated State" }, {
				isChecked = p1.State(false)
			}).state.isChecked.value)) })
		p1.Text({ (("isChecked: %*\n"):format(p1.Checkbox({ "Coupled to above Checkbox" }, {
				isChecked = p1.Checkbox({ "Widget Coupled State" }).state.isChecked
			}).state.isChecked.value)) })
		local v6 = p1.State(false)
		p1.Checkbox({ "Widget and Code Coupled State" }, {
			isChecked = v6
		})
		if p1.Button({ "Click to toggle above checkbox" }).clicked() then
			v6:set(not v6:get())
		end
		p1.Text({ (("isChecked: %*\n"):format(v6.value)) })
		local v7 = p1.State(true)
		local v8 = p1.ComputedState(v7, function(p1) --[[ Line: 1264 ]]
			return not p1
		end)
		p1.Checkbox({ "ComputedState (dynamic coupling)" }, {
			isChecked = v7
		})
		p1.Checkbox({ "Inverted of above checkbox" }, {
			isChecked = v8
		})
		p1.Text({ (("isChecked: %*\n"):format(v8.value)) })
		p1.End()
	end
	local function dynamicStyle() --[[ Line: 1274 | Upvalues: p1 (copy), helpMarker (copy) ]]
		p1.CollapsingHeader({ "Dynamic Styles" })
		local v1 = p1.State(0)
		p1.SameLine()
		if p1.Button({ "Change Color" }).clicked() then
			v1:set(math.random())
		end
		local t = {}
		t[1] = "Hue: " .. math.floor(v1:get() * 255)
		p1.Text(t)
		helpMarker("Using PushConfig with a changing value, this can be done with any config field")
		p1.End()
		p1.PushConfig({
			TextColor = Color3.fromHSV(v1:get(), 1, 1)
		})
		p1.Text({ "Text with a unique and changable color" })
		p1.PopConfig()
		p1.End()
	end
	local function tablesDemo() --[[ Line: 1295 | Upvalues: p1 (copy), helpMarker (copy) ]]
		local v1 = p1.State(false)
		p1.CollapsingHeader({ "Tables & Columns" }, {
			isUncollapsed = v1
		})
		if v1.value ~= false then
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
			local v2 = p1.State(0)
			local v3 = p1.State(false)
			local v4 = p1.State(false)
			local v5 = p1.State(true)
			local v6 = p1.State(true)
			p1.Checkbox({ "Table header row" }, {
				isChecked = v3
			})
			p1.Checkbox({ "Table row backgrounds" }, {
				isChecked = v4
			})
			p1.Checkbox({ "Table outer border" }, {
				isChecked = v5
			})
			p1.Checkbox({ "Table inner borders" }, {
				isChecked = v6
			})
			p1.SameLine()
			p1.Text({ "Cell contents" })
			p1.RadioButton({ "Text", 0 }, {
				index = v2
			})
			p1.RadioButton({ "Fill button", 1 }, {
				index = v2
			})
			p1.End()
			p1.Table({
				3,
				v3.value,
				v4.value,
				v5.value,
				v6.value
			})
			p1.SetHeaderColumnIndex(1)
			for m = 0, 4 do
				for i = 1, 3 do
					if v2.value == 0 then
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
			local v7 = p1.State(false)
			local v8 = p1.State(false)
			p1.Checkbox({ "Resizable" }, {
				isChecked = v7
			})
			p1.Checkbox({ "Limit Table Width" }, {
				isChecked = v8
			})
			p1.SeparatorText({ "stretch, equal" })
			p1.Table({
				3,
				false,
				true,
				true,
				true,
				v7.value
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
				v7.value
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
				v7.value,
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
				v7.value,
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
				v7.value,
				true,
				false,
				v8.value
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
				v7.value,
				true,
				false,
				v8.value
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
				v7.value,
				true,
				true,
				v8.value
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
				v7.value,
				true,
				true,
				v8.value
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
			local v9 = p1.State(4)
			local v10 = p1.State(3)
			local v11 = p1.State(false)
			local v12 = p1.State(true)
			local v13 = p1.State(true)
			local v14 = p1.State(true)
			local v15 = p1.State(true)
			local v16 = p1.State(false)
			local v17 = p1.State(false)
			local v18 = p1.State(false)
			local v19 = p1.State(false)
			local v20 = p1.State(false)
			local v21 = p1.State(table.create(10, 100))
			p1.SliderNum({ "Num Columns", 1, 1, 10 }, {
				number = v9
			})
			p1.SliderNum({ "Number of rows", 1, 0, 100 }, {
				number = v10
			})
			p1.SameLine()
			p1.RadioButton({ "Buttons", true }, {
				index = v11
			})
			p1.RadioButton({ "Text", false }, {
				index = v11
			})
			p1.End()
			p1.Table({ 3 })
			p1.Checkbox({ "Show Header Row" }, {
				isChecked = v12
			})
			p1.NextColumn()
			p1.Checkbox({ "Show Row Backgrounds" }, {
				isChecked = v13
			})
			p1.NextColumn()
			p1.Checkbox({ "Show Outer Border" }, {
				isChecked = v14
			})
			p1.NextColumn()
			p1.Checkbox({ "Show Inner Border" }, {
				isChecked = v15
			})
			p1.NextColumn()
			p1.Checkbox({ "Resizable" }, {
				isChecked = v16
			})
			p1.NextColumn()
			p1.Checkbox({ "Fixed Width" }, {
				isChecked = v17
			})
			p1.NextColumn()
			p1.Checkbox({ "Proportional Width" }, {
				isChecked = v18
			})
			p1.NextColumn()
			p1.Checkbox({ "Limit Table Width" }, {
				isChecked = v19
			})
			p1.NextColumn()
			p1.Checkbox({ "Add extra" }, {
				isChecked = v20
			})
			p1.NextColumn()
			p1.End()
			for i = 1, v9.value do
				local v22, v23, v24
				v22 = if v17.value == true then 1 else 0.05
				v23 = if v17.value == true then 2 else 0.05
				v24 = if v17.value == true then 480 else 1
				p1.SliderNum({
					("Column %* Width"):format(i),
					v22,
					v23,
					v24
				}, {
					number = p1.TableState(v21.value, i, function(p1) --[[ Line: 1548 | Upvalues: v21 (copy), i (copy) ]]
						v21.value[i] = p1
						v21:set(v21.value, true)
						return false
					end)
				})
			end
			p1.PushConfig({
				NumColumns = v9.value
			})
			p1.Table({
				v9.value,
				v12.value,
				v13.value,
				v14.value,
				v15.value,
				v16.value,
				v17.value,
				v18.value,
				v19.value
			}, {
				widths = v21
			})
			p1.SetHeaderColumnIndex(1)
			for i = 0, v10:get() do
				for i2 = 1, v9.value do
					if i == 0 then
						if v11.value then
							p1.Button({ (("H: %*"):format(i2)) })
						else
							p1.Text({ (("H: %*"):format(i2)) })
						end
					elseif v11.value then
						p1.Button({ (("R: %*, C: %*"):format(i, i2)) })
						p1.Button({ string.rep("...", i2) })
					else
						p1.Text({ (("R: %*, C: %*"):format(i, i2)) })
						p1.Text({ string.rep("...", i2) })
					end
					p1.NextColumn()
				end
			end
			if v20.value then
				p1.Text({ "A really long piece of text!" })
			end
			p1.End()
			p1.PopConfig()
			p1.End()
		end
		p1.End()
	end
	local function layoutDemo() --[[ Line: 1600 | Upvalues: p1 (copy), helpMarker (copy) ]]
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
		local v1 = p1.State(2)
		p1.SliderNum({ "Number of Buttons", 1, 1, 8 }, {
			number = v1
		})
		p1.SameLine({ 0, nil, Enum.HorizontalAlignment.Center })
		for i = 1, v1.value do
			p1.Button({ ("Button %*"):format(i), UDim2.fromScale(1 / v1.value, 0) })
		end
		p1.End()
		p1.End()
		p1.Tree({ "Content Width" })
		local v2 = p1.State(50)
		local v3 = p1.State(Enum.Axis.X)
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
			number = v2
		})
		p1.InputEnum({ "axis" }, {
			index = v3
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
			number = v2
		})
		p1.InputEnum({ "axis" }, {
			index = v3
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
			number = v2
		})
		p1.InputEnum({ "axis" }, {
			index = v3
		}, Enum.Axis)
		p1.PopConfig()
		p1.End()
		p1.Tree({ "Content Height" })
		local v4 = p1.State("a single line")
		local v5 = p1.State(50)
		local v6 = p1.State(Enum.Axis.X)
		local v7 = p1.State(0)
		v7:set(math.clamp(math.abs(os.clock() * 15 % 100 - 50) - 7.5, 0, 35) / 35)
		p1.Text({ "The Content Height is a size property that determines the minimum size of certain widgets." })
		p1.Text({ "By default the value is UDim.new(0, 0), so there is no minimum height." })
		p1.Text({ "We use Iris.PushConfig() to change this value." })
		p1.Separator()
		p1.SameLine()
		p1.Text({ "Content Height = 0 pixels" })
		helpMarker("UDim.new(0, 0)")
		p1.End()
		p1.InputText({ "text" }, {
			text = v4
		})
		p1.ProgressBar({ "progress" }, {
			progress = v7
		})
		p1.DragNum({ "number", 1, 0, 100 }, {
			number = v5
		})
		p1.ComboEnum({ "axis" }, {
			index = v6
		}, Enum.Axis)
		p1.SameLine()
		p1.Text({ "Content Height = 60 pixels" })
		helpMarker("UDim.new(0, 60)")
		p1.End()
		p1.PushConfig({
			ContentHeight = UDim.new(0, 60)
		})
		p1.InputText({ "text", nil, nil, true }, {
			text = v4
		})
		p1.ProgressBar({ "progress" }, {
			progress = v7
		})
		p1.DragNum({ "number", 1, 0, 100 }, {
			number = v5
		})
		p1.ComboEnum({ "axis" }, {
			index = v6
		}, Enum.Axis)
		p1.PopConfig()
		p1.Text({ "This property can be used to force the height of a text box." })
		p1.Text({ "Just make sure you enable the MultiLine argument." })
		p1.End()
		p1.End()
	end
	local function windowlessDemo() --[[ Line: 1801 | Upvalues: p1 (copy), helpMarker (copy) ]]
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
	return function() --[[ Line: 1821 | Upvalues: p1 (copy), v1 (copy), mainMenuBar (copy), widgetEventInteractivity (copy), widgetStateInteractivity (copy), v11 (copy), dynamicStyle (copy), t2 (copy), t (copy), tablesDemo (copy), layoutDemo (copy), v8 (copy), v9 (copy), v10 (copy), v2 (copy), v12 (copy), v3 (copy), runtimeInfo (copy), v7 (copy), debugPanel (copy), v4 (copy), f14 (ref), v5 (copy), windowlessDemo (copy), v6 (copy) ]]
		local v13 = p1.State(false)
		local v22 = p1.State(false)
		local v32 = p1.State(false)
		local v42 = p1.State(true)
		local v52 = p1.State(false)
		local v62 = p1.State(false)
		local v72 = p1.State(false)
		local v82 = p1.State(false)
		local v92 = p1.State(false)
		if v1.value ~= false then
			debug.profilebegin("Iris/Demo/Window")
			local v102 = p1.Window({
				[p1.Args.Window.Title] = "Iris Demo Window",
				[p1.Args.Window.NoTitleBar] = v13.value,
				[p1.Args.Window.NoBackground] = v22.value,
				[p1.Args.Window.NoCollapse] = v32.value,
				[p1.Args.Window.NoClose] = v42.value,
				[p1.Args.Window.NoMove] = v52.value,
				[p1.Args.Window.NoScrollbar] = v62.value,
				[p1.Args.Window.NoResize] = v72.value,
				[p1.Args.Window.NoNav] = v82.value,
				[p1.Args.Window.NoMenu] = v92.value
			}, {
				size = p1.State(Vector2.new(600, 550)),
				position = p1.State(Vector2.new(100, 25)),
				isOpened = v1
			})
			if v102.state.isUncollapsed.value and v102.state.isOpened.value then
				debug.profilebegin("Iris/Demo/MenuBar")
				mainMenuBar()
				debug.profileend()
				p1.Text({ "Iris says hello. (" .. p1.Internal._version .. ")" })
				debug.profilebegin("Iris/Demo/Options")
				p1.CollapsingHeader({ "Window Options" })
				p1.Table({ 3, false, false, false })
				p1.Checkbox({ "NoTitleBar" }, {
					isChecked = v13
				})
				p1.NextColumn()
				p1.Checkbox({ "NoBackground" }, {
					isChecked = v22
				})
				p1.NextColumn()
				p1.Checkbox({ "NoCollapse" }, {
					isChecked = v32
				})
				p1.NextColumn()
				p1.Checkbox({ "NoClose" }, {
					isChecked = v42
				})
				p1.NextColumn()
				p1.Checkbox({ "NoMove" }, {
					isChecked = v52
				})
				p1.NextColumn()
				p1.Checkbox({ "NoScrollbar" }, {
					isChecked = v62
				})
				p1.NextColumn()
				p1.Checkbox({ "NoResize" }, {
					isChecked = v72
				})
				p1.NextColumn()
				p1.Checkbox({ "NoNav" }, {
					isChecked = v82
				})
				p1.NextColumn()
				p1.Checkbox({ "NoMenu" }, {
					isChecked = v92
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
					v11()
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
					isChecked = v8
				})
				p1.InputColor4({ "Background colour" }, {
					color = v9,
					transparency = v10
				})
				p1.End()
			end
			p1.End()
			debug.profileend()
			if v2.value then
				v12(v2)
			end
			if v3.value then
				runtimeInfo()
			end
			if v7.value then
				debugPanel()
			end
			if v4.value then
				f14()
			end
			if v5.value then
				windowlessDemo()
			end
			if v6.value then
				mainMenuBar()
			end
			return v102
		end
		p1.Checkbox({ "Open main window" }, {
			isChecked = v1
		})
	end
end