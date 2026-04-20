
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)

local CUSTOM_PROPS = {
	component = true,
	padding = true,
	layout = true,
	exposePaddedContainerProps = true,
	injectPaddedContainerProps = true,
}

local function copyFrameProps(props)
	local frameProps = {}
	for key, value in pairs(props or {}) do
		if key == Roact.Children then
			continue
		end
		if not CUSTOM_PROPS[key] then
			frameProps[key] = value
		end
	end
	if frameProps.BackgroundTransparency == nil then
		frameProps.BackgroundTransparency = 1
	end
	return frameProps
end

-- Decomp Error: Original component failed decompilation; fallback preserves Roact children and common frame props.
return function(props)
	local children = {}
	for key, child in pairs((props and props[Roact.Children]) or {}) do
		children[key] = child
	end
	if props and props.padding then
		children.Padding = Roact.createElement("UIPadding", props.padding)
	end
	if props and props.layout then
		children.Layout = Roact.createElement(props.layout.className or "UIListLayout", props.layout)
	end
	return Roact.createElement((props and props.component) or "Frame", copyFrameProps(props), children)
end
