local module = {}
module.__index = module

function module.new(object)
	local self = setmetatable({}, module)
	self.Maid = Class.new("Maid")
	self.Object = object
	
	return self
end

function module:IsA(className)
	return Class.IsA(getmetatable(self), className)
end

function module:Destroy()
	self.Maid:Destroy()
end

Class.RegisterClass("Component", module)

return module