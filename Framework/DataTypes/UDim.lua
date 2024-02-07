local module = {}
module.__index = module

module.new = function(scale, offset)
	return setmetatable({
		Scale = scale or 0, 
		Offset = offset or 0
	}, module)
end

Class.RegisterClass("UDim", module)

return module