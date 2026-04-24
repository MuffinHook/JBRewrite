-- Reviewed by Claude
-- variables reassigned
local GlobalConfig = require(script.GlobalConfig)
local createReconciler = require(script.createReconciler)
local createReconcilerCompat = require(script.createReconcilerCompat)
local RobloxRenderer = require(script.RobloxRenderer)
local strict = require(script.strict)
local Binding = require(script.Binding)
local var1 = createReconciler(RobloxRenderer)
local var2 = createReconcilerCompat(var1)
return strict({
	Component = require(script.Component),
	createElement = require(script.createElement),
	createFragment = require(script.createFragment),
	oneChild = require(script.oneChild),
	PureComponent = require(script.PureComponent),
	None = require(script.None),
	Portal = require(script.Portal),
	createRef = require(script.createRef),
	forwardRef = require(script.forwardRef),
	createBinding = Binding.create,
	joinBindings = Binding.join,
	createContext = require(script.createContext),
	Change = require(script.PropMarkers.Change),
	Children = require(script.PropMarkers.Children),
	Event = require(script.PropMarkers.Event),
	Ref = require(script.PropMarkers.Ref),
	mount = var1.mountVirtualTree,
	unmount = var1.unmountVirtualTree,
	update = var1.updateVirtualTree,
	reify = var2.reify,
	teardown = var2.teardown,
	reconcile = var2.reconcile,
	setGlobalConfig = GlobalConfig.set,
	UNSTABLE = {}
})